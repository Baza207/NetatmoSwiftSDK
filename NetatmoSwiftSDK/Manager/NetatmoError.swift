//
//  NetatmoError.swift
//  NetatmoSwiftSDK
//
//  Created by James Barrow on 2020-02-23.
//  Copyright © 2020 Pig on a Hill Productions. All rights reserved.
//

import Foundation

public enum NetatmoError: Error, LocalizedError {
    case badURL
    case noData
    case generalError
    case noRefreshToken
    case noAccessToken
    case noCallbackCode
    case noScope
    case stateMismatch
    case noImage
    case error(code: Int, message: String)
    
    public var errorDescription: String? {
        
        switch self {
        case .badURL:
            return "Bad URL"
        case .noData:
            return "No Data"
        case .generalError:
            return "General Error"
        case .noRefreshToken:
            return "No Refresh Token"
        case .noAccessToken:
            return "No Access Token"
        case .noCallbackCode:
            return "No Callback Code"
        case .noScope:
            return "No Scope"
        case .stateMismatch:
            return "State Mismatch"
        case .noImage:
            return "No Image"
        case .error(let code, let message):
            return "\(message) [\(code)]"
        }
    }
}
