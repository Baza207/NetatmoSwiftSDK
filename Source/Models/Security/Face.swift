//
//  Face.swift
//  NetatmoSwiftSDK
//
//  Created by James Barrow on 2020-02-27.
//  Copyright © 2020 Pig on a Hill Productions. All rights reserved.
//

import Foundation

public extension NetatmoSecurity {
    
    struct Face: Decodable, CustomStringConvertible {
        
        // MARK: - Properties
        
        public let identifier: String
        public let version: Int
        public let key: String
        public let url: String
        
        public var description: String {
            "Face(identifier: \(identifier), version: \(version), key: \(key))"
        }
        
        // MARK: - Coding
        
        private enum CodingKeys: String, CodingKey {
            case identifier = "id"
            case version
            case key
            case url
        }
    }
    
}
