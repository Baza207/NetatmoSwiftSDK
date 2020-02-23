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
    
    static func authorizeURL(scope: [AuthScope] = [.readStation]) throws -> URL {
        
        let manager = NetatmoManager.shared
        manager.requestedScope = scope
        
        guard var urlComponents = URLComponents(string: "https://api.netatmo.com/oauth2/authorize") else {
            throw NetatmoError.badURL
        }
        
        if manager.stateUUID == nil {
            manager.stateUUID = UUID().uuidString
        }
        
        urlComponents.queryItems = [
            URLQueryItem(name: "client_id", value: manager.clientId),
            URLQueryItem(name: "redirect_uri", value: manager.redirectURI),
            URLQueryItem(name: "scope", value: AuthScope.string(from: scope)),
            URLQueryItem(name: "state", value: manager.stateUUID)
        ]
        
        guard let url = urlComponents.url else {
            manager.authState = .failed(NetatmoError.badURL)
            throw NetatmoError.badURL
        }
        
        return url
    }
    
    static func authorizationCallback(with url: URL, completed: ((Result<AuthState, Error>) -> Void)? = nil) {
        
        let manager = NetatmoManager.shared
        let urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true)
        
        guard
            let state = urlComponents?.queryItems?.first(where: { $0.name == "state" })?.value,
            let stateUUID = manager.stateUUID, state == stateUUID,
            let code = urlComponents?.queryItems?.first(where: { $0.name == "code" })?.value
        else {
            
            let authState: AuthState = .failed(NetatmoError.noCallbackCode)
            manager.authState = authState
            completed?(Result.success(authState))
            return
        }
        
        manager.token(with: code) { (result) in
            
            let authState: AuthState
            switch result {
            case .success:
                authState = .authorized
            case .failure(let error):
                authState = .failed(error)
            }
            
            NetatmoManager.shared.authState = authState
            completed?(Result.success(authState))
        }
    }
    
    // MARK: - Token
    
    internal func token(with code: String, completed: @escaping (Result<AuthState, Error>) -> Void) {
        
        guard let url = URL(string: "https://api.netatmo.com/oauth2/token") else {
            completed(Result.failure(NetatmoError.badURL))
            return
        }
        
        guard let requestedScope = self.requestedScope else {
            let error = NetatmoError.noScope
            completed(Result.failure(error))
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
            let expires = authResult.expiresInDate(from: requestDate)
            self.expires = expires
            
            if let stateUUID = self.stateUUID {
                
                self.saveStateUUID(stateUUID)
                
                let state = OAuthState(accessToken: authResult.accessToken, refreshToken: authResult.refreshToken, expires: expires)
                try? KeychainPasswordItem(service: NetatmoManager.keychainServiceName, account: stateUUID)
                    .saveJSON(state)
            }
            
            completed(Result.success(.authorized))
        }
        downloadTask.resume()
    }
    
    static func refreshToken(_ completed: @escaping (Result<AuthState, Error>) -> Void) {
        
        let manager = NetatmoManager.shared
        
        // If the token has not yet expired, just return success
        if manager.isValid == true {
            completed(Result.success(.authorized))
        }
        
        guard let refreshToken = manager.refreshToken, refreshToken.isEmpty == false else {
            completed(Result.failure(NetatmoError.noRefreshToken))
            return
        }
        
        guard let url = URL(string: "https://api.netatmo.com/oauth2/token") else {
            completed(Result.failure(NetatmoError.badURL))
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        
        let body = "grant_type=refresh_token&client_id=\(manager.clientId)&client_secret=\(manager.clientSecret)&refresh_token=\(refreshToken)"
        urlRequest.httpBody = body.data(using: .utf8)!
        
        let requestDate = Date()
        let downloadTask = URLSession.shared.dataTask(with: urlRequest) { (data, _, error) in
            
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
            
            guard let authResult = result else {
                completed(Result.failure(NetatmoError.generalError))
                return
            }
            
            let manager = NetatmoManager.shared
            manager.accessToken = authResult.accessToken
            manager.refreshToken = authResult.refreshToken
            let expires = authResult.expiresInDate(from: requestDate)
            manager.expires = expires
            
            if let stateUUID = manager.stateUUID {
                
                manager.saveStateUUID(stateUUID)
                
                let state = OAuthState(accessToken: authResult.accessToken, refreshToken: authResult.refreshToken, expires: expires)
                try? KeychainPasswordItem(service: NetatmoManager.keychainServiceName, account: stateUUID)
                    .saveJSON(state)
            }
            
            completed(Result.success(.authorized))
        }
        downloadTask.resume()
    }
    
    // MARK: - Logout
    
    static func logout() throws {
        
        let manager = NetatmoManager.shared
        
        if let stateUUID = manager.stateUUID {
            try KeychainPasswordItem(service: NetatmoManager.keychainServiceName, account: stateUUID)
                .deleteItem()
        }
        
        manager.removeStateUUID()
        
        manager.accessToken = nil
        manager.refreshToken = nil
        manager.expires = nil
        manager.requestedScope = nil
        manager.stateUUID = nil
        
        manager.authState = .unknown
    }
    
    // MARK: - Auth State Changed Listner
    
    typealias Listener = UUID
    
    static func addAuthStateDidChangeListener(_ callback: @escaping ((_ authState: AuthState) -> Void)) -> Listener {
        
        return NetatmoManager.shared.authStateListenerQueue.sync(flags: .barrier) {
            
            let manager = NetatmoManager.shared
            
            let listener = Listener()
            manager.authStateDidChangeListeners[listener] = callback

            // Perform callback with current state
            callback(manager.authState)
            
            return listener
        }
    }
    
    static func removeAuthStateDidChangeListener(with uuid: Listener) {
        
        NetatmoManager.shared.authStateListenerQueue.async(flags: .barrier) {
            NetatmoManager.shared.authStateDidChangeListeners.removeValue(forKey: uuid)
        }
    }
    
}

internal extension NetatmoManager {
    
    /// Client credentials grant type
    ///
    /// - WARNING: This method should only be used for personnal use and testing purpose.
    ///
    /// - NOTE: This method does not call `authStateDidChangeListeners`, as it should not be used in production.
    ///
    /// - Parameters:
    ///   - username: User address email
    ///   - password: User password
    ///   - scope: Scopes required
    ///   - completed: `AuthResult` with OAuth2 details or an error
    static func login(username: String, password: String, scope: [AuthScope] = [.readStation], completed: @escaping (Result<AuthResult, Error>) -> Void) {
        
        guard let url = URL(string: "https://api.netatmo.com/oauth2/token") else {
            completed(Result.failure(NetatmoError.badURL))
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        
        let manager = NetatmoManager.shared
        
        let body = "grant_type=password&client_id=\(manager.clientId)&client_secret=\(manager.clientSecret)&username=\(username)&password=\(password)&scope=\(AuthScope.string(from: scope, separationType: .space))"
        urlRequest.httpBody = body.data(using: .utf8)!
        
        let requestDate = Date()
        let downloadTask = URLSession.shared.dataTask(with: urlRequest) { (data, _, error) in
            
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
            
            guard let authResult = result else {
                completed(Result.failure(NetatmoError.generalError))
                return
            }
            
            let manager = NetatmoManager.shared
            manager.accessToken = authResult.accessToken
            manager.refreshToken = authResult.refreshToken
            manager.expires = authResult.expiresInDate(from: requestDate)
            
            completed(Result.success(authResult))
        }
        downloadTask.resume()
    }
    
}
