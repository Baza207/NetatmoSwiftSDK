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
    
    internal let clientId: String
    internal let clientSecret: String
    internal var accessToken: String?
    internal var refreshToken: String?
    internal var expires: Date?
    internal var scope: [String]?
    internal var authResultBuilder: AuthenticationResult? {
        
        guard let accessToken = self.accessToken, let refreshToken = self.refreshToken, let expires = self.expires, let scope = self.scope else {
            return nil
        }
        return AuthenticationResult(accessToken: accessToken, refreshToken: refreshToken, scope: scope, exires: expires)
    }
    
    // MARK: - Lifecycle
    
    public init(clientId: String, clientSecret: String) {
        
        self.clientId = clientId
        self.clientSecret = clientSecret
    }
    
}
