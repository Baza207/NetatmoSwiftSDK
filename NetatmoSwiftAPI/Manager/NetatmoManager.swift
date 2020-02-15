//
//  NetatmoManager.swift
//  NetatmoSwiftAPI
//
//  Created by James Barrow on 2019-10-23.
//  Copyright © 2019 Pig on a Hill Productions. All rights reserved.
//

import Foundation

public class NetatmoManager {
    
    public static var shared = NetatmoManager()
    
    // MARK: - Types

    public enum NetatmoError: Error {
        case badURL
        case noData
        case generalError
        case noRefreshToken
        case noAccessToken
        case noCallbackCode
        case noScope
        case existingState
        case stateMismatch
    }

    public enum AuthState {
        case unknown
        case authorized
        case tokenExpired
        case failed(_ error: Error)
    }
    
    // MARK: - Properties
    
    var clientId: String = ""
    var clientSecret: String = ""
    var redirectURI: String = ""
    var accessToken: String?
    var refreshToken: String?
    var expires: Date?
    var requestedScope: [AuthScope]?
    var stateUUID: String?
    var authResultBuilder: AuthResult? {
        
        guard let accessToken = self.accessToken, let refreshToken = self.refreshToken, let expires = self.expires else {
            return nil
        }
        return AuthResult(accessToken: accessToken, refreshToken: refreshToken, exires: expires)
    }
    lazy var authStateDidChangeListeners = [UUID: ((authState: AuthState) -> Void)]()
    
    // MARK: - Lifecycle
    
    public static func configure(clientId: String, clientSecret: String, redirectURI: String) {
        
        shared.clientId = clientId
        shared.clientSecret = clientSecret
        shared.redirectURI = redirectURI
    }
    
    init() { }
    
}
