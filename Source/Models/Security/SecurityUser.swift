//
//  User.swift
//  NetatmoSwiftSDK
//
//  Created by James Barrow on 2020-02-27.
//  Copyright © 2020 Pig on a Hill Productions. All rights reserved.
//

import Foundation

public extension NetatmoSecurity {
    
    struct User: Decodable, CustomStringConvertible {
        
        // MARK: - Properties
        
        public let regionLocale: String
        public let language: String
        public let country: String?
        public let mail: String
        
        public var description: String {
            if let country = self.country {
                return "User(regionLocale: \(regionLocale), language: \(language), country: \(country), mail: \(mail))"
            }
            return "User(regionLocale: \(regionLocale), language: \(language), mail: \(mail))"
        }
        
        // MARK: - Coding
        
        private enum CodingKeys: String, CodingKey {
            case regionLocale = "reg_locale"
            case language = "lang"
            case country
            case mail
        }
    }
    
}
