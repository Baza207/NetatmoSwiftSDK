//
//  User.swift
//  NetatmoSwiftSDK
//
//  Created by James Barrow on 2020-07-31.
//  Copyright © 2020 Pig on a Hill Productions. All rights reserved.
//

import Foundation

public extension NetatmoEnergy {
    
    struct User: Decodable, CustomStringConvertible {
        
        // MARK: - Properties
        
        public let identifier: String
        public let mail: String
        public let language: String
        public let regionLocale: String
        public let feelLikeAlgorithm: Int
        public let unitPressure: Int
        public let unitSystem: Int
        public let unitWind: Int
        
        public var description: String {
            "User(regionLocale: \(regionLocale), language: \(language), mail: \(mail))"
        }
        
        // MARK: - Coding
        
        private enum CodingKeys: String, CodingKey {
            case identifier = "id"
            case mail = "email"
            case language
            case regionLocale = "locale"
            case feelLikeAlgorithm = "feel_like_algorithm"
            case unitPressure = "unit_pressure"
            case unitSystem = "unit_system"
            case unitWind = "unit_wind"
        }
        
        // MARK: - Init
        
        public init(identifier: String, mail: String, language: String, regionLocale: String, feelLikeAlgorithm: Int, unitPressure: Int, unitSystem: Int, unitWind: Int) {
            
            self.identifier = identifier
            self.mail = mail
            self.language = language
            self.regionLocale = regionLocale
            self.feelLikeAlgorithm = feelLikeAlgorithm
            self.unitPressure = unitPressure
            self.unitSystem = unitSystem
            self.unitWind = unitWind
        }
        
    }
    
}
