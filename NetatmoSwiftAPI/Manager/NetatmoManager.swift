//
//  NetatmoManager.swift
//  NetatmoSwiftAPI
//
//  Created by James Barrow on 2019-10-23.
//  Copyright © 2019 Pig on a Hill Productions. All rights reserved.
//

import Foundation

public class NetatmoManager {
    
    // MARK: - Properties
    
    let clientId: String
    let clientSecret: String
    let redirectURI: String
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
    
    // MARK: - Lifecycle
    
    public init(clientId: String, clientSecret: String, redirectURI: String) {
        
        self.clientId = clientId
        self.clientSecret = clientSecret
        self.redirectURI = redirectURI
    }
    
}
