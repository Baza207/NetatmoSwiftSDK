//
//  OAuthState.swift
//  NetatmoSwiftSDK
//
//  Created by James Barrow on 2020-02-17.
//  Copyright © 2020 Pig on a Hill Productions. All rights reserved.
//

import Foundation

struct OAuthState: Codable {
    
    var accessToken: String
    var refreshToken: String
    var expires: Date
    
    var isValid: Bool {
        return Date() < expires
    }
    
}
