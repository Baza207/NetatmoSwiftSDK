//
//  AuthResult.swift
//  NetatmoSwiftSDK
//
//  Created by James Barrow on 2019-10-23.
//  Copyright © 2019 Pig on a Hill Productions. All rights reserved.
//

import Foundation

public struct AuthResult: Decodable, CustomStringConvertible {
    public let accessToken: String
    public let refreshToken: String
    private let expiresIn: TimeInterval
    public var description: String {
        "<AuthResult - \(accessToken) - \(refreshToken) - \(expiresIn)>"
    }
    
    private enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case refreshToken = "refresh_token"
        case expiresIn = "expires_in"
    }
    
    public func expiresInDate(from date: Date) -> Date {
        date + expiresIn
    }
    
    init(accessToken: String, refreshToken: String, exires: Date) {
        
        self.accessToken = accessToken
        self.refreshToken = refreshToken
        self.expiresIn = exires.timeIntervalSinceNow
    }
    
}
