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
    
    func login(username: String, password: String, completed: @escaping (Result<AuthenticationResult, Error>) -> Void) {
        
        guard let url = URL(string: "https://api.netatmo.com/oauth2/token") else {
            completed(Result.failure(NetatmoError.badURL))
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        
        let body = "grant_type=password&client_id=\(clientId)&client_secret=\(clientSecret)&username=\(username)&password=\(password)"
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
            let result: AuthenticationResult?
            do {
                result = try decoder.decode(AuthenticationResult.self, from: data)
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
            self.scope = authResult.scope
            
            completed(Result.success(authResult))
        }
        downloadTask.resume()
    }
    
    internal func authorize(_ completed: @escaping (Result<NetatmoManager, Error>) -> Void) {
        
        // TODO: Refresh token if previous one has expired
    }
    
    internal func refreshToken(_ completed: @escaping (Result<AuthenticationResult, Error>) -> Void) {
        
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
            let result: AuthenticationResult?
            do {
                result = try decoder.decode(AuthenticationResult.self, from: data)
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
            self.scope = authResult.scope
            
            completed(Result.success(authResult))
        }
        downloadTask.resume()
    }
    
}
