//
//  KeychainError.swift
//  NetatmoSwiftAPI
//
//  Created by James Barrow on 2020-02-13.
//  Copyright © 2020 Pig on a Hill Productions. All rights reserved.
//

import Foundation

public enum KeychainError: Error {
    case passwordError
    case keychainError(errorString: String)
}
