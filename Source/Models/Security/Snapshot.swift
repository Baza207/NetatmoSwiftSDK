//
//  Snapshot.swift
//  NetatmoSwiftSDK
//
//  Created by James Barrow on 2020-02-27.
//  Copyright © 2020 Pig on a Hill Productions. All rights reserved.
//

import Foundation

public extension NetatmoSecurity {
    
    struct Snapshot: Decodable, CustomStringConvertible {
        
        // MARK: - Properties
        
        public let identifier: String?
        public let version: Int?
        public let key: String?
        public let url: String?
        public let filename: String?
        
        public var description: String {
            if let identifier = self.identifier, let version = self.version, let key = self.key {
                return "Snapshot(identifier: \(identifier), version: \(version), key: \(key))"
            } else if let filename = self.filename {
                return "Snapshot(filename: \(filename))"
            }
            return "Snapshot()"
        }
        
        // MARK: - Coding
        
        private enum CodingKeys: String, CodingKey {
            case identifier = "id"
            case version
            case key
            case url
            case filename
        }
    }
    
}
