//
//  NetatmoError.swift
//  NetatmoSwiftAPI
//
//  Created by James Barrow on 2019-10-23.
//  Copyright © 2019 Pig on a Hill Productions. All rights reserved.
//

import Foundation

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
