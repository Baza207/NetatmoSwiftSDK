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
        private let lastSetup: TimeInterval
        public var lastSetupDate: Date { Date(timeIntervalSince1970: lastSetup) }
        public let name: String
        
        public var description: String {
            "SmokeDetector(identifier: \(identifier), type: \(type), lastSetupDate: \(lastSetupDate), name: \(name))"
        }
        
        // MARK: - Coding
        
        private enum CodingKeys: String, CodingKey {
            case identifier = "id"
            case rawType = "type"
            case lastSetup = "last_setup"
            case name
        }
    }
    
}
