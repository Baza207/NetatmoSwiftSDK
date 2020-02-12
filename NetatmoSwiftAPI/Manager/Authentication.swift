//
//  Authentication.swift
//  NetatmoSwiftAPI
//
//  Created by James Barrow on 2019-10-23.
//  Copyright © 2019 Pig on a Hill Productions. All rights reserved.
//

import Foundation

public extension NetatmoManager {
    
    // MARK: - Authentication
    
    /// Client credentials grant type
    ///
    /// - WARNING: This method should only be used for personnal use and testing purpose.
    ///
    /// - Parameters:
    ///   - username: User address email
    ///   - password: User password
    ///   - scope: Scopes required
    ///   - completed: `AuthResult` with Oauth2 details or an error
    internal func login(username: String, password: String, scope: [AuthScope] = [.readStation], completed: @escaping (Result<AuthResult, Error>) -> Void) {
        
        guard let url = URL(string: "https://api.netatmo.com/oauth2/token") else {
            completed(Result.failure(NetatmoError.badURL))
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        
        let body = "grant_type=password&client_id=\(clientId)&client_secret=\(clientSecret)&username=\(username)&password=\(password)&scope=\(AuthScope.string(from: scope, separationType: .space))"
        urlRequest.httpBody = body.data(using: .utf8)!
        
        let requestDate = Date()
        let downloadTask = URLSession.shared.dataTask(with: urlRequest) { [weak self] (data, _, error) in
            
            if let error = error {
                completed(Result.failure(error))
                return
            }
            
            guard let data = data else {
                completed(Result.failure(NetatmoError.noData))
                return
            }
            
            let decoder = JSONDecoder()
            let result: AuthResult?
            do {
                result = try decoder.decode(AuthResult.self, from: data)
            } catch {
                completed(Result.failure(error))
                return
            }
            
            guard let authResult = result, let self = self else {
                completed(Result.failure(NetatmoError.generalError))
                return
            }
            
            self.accessToken = authResult.accessToken
            self.refreshToken = authResult.refreshToken
            self.expires = authResult.expiresInDate(from: requestDate)
            
            completed(Result.success(authResult))
        }
        downloadTask.resume()
    }
    
    func authorizeURL(scope: [AuthScope] = [.readStation]) throws -> URL {
        
        // TODO: Chack if a state UUID already exists and check if the user wants to override it
        
        guard var urlComponents = URLComponents(string: "https://api.netatmo.com/oauth2/authorize") else {
            throw(NetatmoError.badURL)
        }
        
        let stateUUID = UUID().uuidString
        self.stateUUID = stateUUID
        self.requestedScope = scope
        
        urlComponents.queryItems = [
            URLQueryItem(name: "client_id", value: clientId),
            URLQueryItem(name: "redirect_uri", value: redirectURI),
            URLQueryItem(name: "scope", value: AuthScope.string(from: scope)),
            URLQueryItem(name: "state", value: stateUUID)
        ]
        
        guard let url = urlComponents.url else {
            throw(NetatmoError.badURL)
        }
        
        return url
    }
    
    func authorizationCallback(with url: URL, completed: @escaping (Result<AuthResult, Error>) -> Void) {
        
        let urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true)
        
        guard
            let state = urlComponents?.queryItems?.first(where: { $0.name == "state" })?.value,
            let stateUUID = self.stateUUID, state == stateUUID,
            let code = urlComponents?.queryItems?.first(where: { $0.name == "code" })?.value
        else {
            // TODO: Call completed with error
            return
        }
        
        token(with: code, completed: completed)
    }
    
    internal func token(with code: String, completed: @escaping (Result<AuthResult, Error>) -> Void) {
        
        guard let url = URL(string: "https://api.netatmo.com/oauth2/token") else {
            completed(Result.failure(NetatmoError.badURL))
            return
        }
        
        guard let requestedScope = self.requestedScope else {
            // TODO: Call completed with error
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        
        let body = "grant_type=authorization_code&client_id=\(clientId)&client_secret=\(clientSecret)&code=\(code)&redirect_uri=\(redirectURI)&scope=\(AuthScope.string(from: requestedScope))"
        urlRequest.httpBody = body.data(using: .utf8)!
        
        let requestDate = Date()
        let downloadTask = URLSession.shared.dataTask(with: urlRequest) { [weak self] (data, _, error) in
            
            if let error = error {
                completed(Result.failure(error))
                return
            }
            
            guard let data = data else {
                completed(Result.failure(NetatmoError.noData))
                return
            }
            
            let decoder = JSONDecoder()
            let result: AuthResult?
            do {
                result = try decoder.decode(AuthResult.self, from: data)
            } catch {
                completed(Result.failure(error))
                return
            }
            
            guard let authResult = result, let self = self else {
                completed(Result.failure(NetatmoError.generalError))
                return
            }
            
            self.accessToken = authResult.accessToken
            self.refreshToken = authResult.refreshToken
            self.expires = authResult.expiresInDate(from: requestDate)
            
            completed(Result.success(authResult))
        }
        downloadTask.resume()
    }
    
    func refreshToken(_ completed: @escaping (Result<AuthResult, Error>) -> Void) {
        
        guard let refreshToken = self.refreshToken, refreshToken.isEmpty == false, let expires = self.expires else {
            completed(Result.failure(NetatmoError.noRefreshToken))
            return
        }
        
        // If the token has not yet expired, just return success
        if expires < Date(), let authResult = authResultBuilder {
            completed(Result.success(authResult))
        }
        
        guard let url = URL(string: "https://api.netatmo.com/oauth2/token") else {
            completed(Result.failure(NetatmoError.badURL))
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        
        let body = "grant_type=refresh_token&client_id=\(clientId)&client_secret=\(clientSecret)&refresh_token=\(refreshToken)"
        urlRequest.httpBody = body.data(using: .utf8)!
        
        let requestDate = Date()
        let downloadTask = URLSession.shared.dataTask(with: urlRequest) { [weak self] (data, _, error) in
            
            if let error = error {
                completed(Result.failure(error))
                return
            }
            
            guard let data = data else {
                completed(Result.failure(NetatmoError.noData))
                return
            }
            
            let decoder = JSONDecoder()
            let result: AuthResult?
            do {
                result = try decoder.decode(AuthResult.self, from: data)
            } catch {
                completed(Result.failure(error))
                return
            }
            
            guard let authResult = result, let self = self else {
                completed(Result.failure(NetatmoError.generalError))
                return
            }
            
            self.accessToken = authResult.accessToken
            self.refreshToken = authResult.refreshToken
            self.expires = authResult.expiresInDate(from: requestDate)
            
            completed(Result.success(authResult))
        }
        downloadTask.resume()
    }
    
}
