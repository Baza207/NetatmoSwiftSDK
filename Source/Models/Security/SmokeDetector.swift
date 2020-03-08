//
//  SmokeDetector.swift
//  NetatmoSwiftSDK
//
//  Created by James Barrow on 2020-02-27.
//  Copyright © 2020 Pig on a Hill Productions. All rights reserved.
//

import Foundation

public extension NetatmoSecurity {
    
    struct SmokeDetector: Decodable, CustomStringConvertible {
        
        // MARK: - Properties
        
        public let identifier: String
        private let rawType: String
        public var type: ProductType { ProductType(rawValue: rawType) }
        public let lastSetupDate: Date
        public let name: String
        
        public var description: String {
            "SmokeDetector(identifier: \(identifier), type: \(type), lastSetupDate: \(lastSetupDate), name: \(name))"
        }
        
        // MARK: - Coding
        
        private enum CodingKeys: String, CodingKey {
            case identifier = "id"
            case rawType = "type"
            case lastSetupDate = "last_setup"
            case name
        }
        
        // MARK: - Init
        
        init(identifier: String, type: ProductType, lastSetupDate: Date, name: String) {
            
            self.identifier = identifier
            self.rawType = type.rawValue
            self.lastSetupDate = lastSetupDate
            self.name = name
        }
        
    }
    
}
