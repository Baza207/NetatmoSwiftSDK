//
//  SubEvent.swift
//  NetatmoSwiftSDK
//
//  Created by James Barrow on 2020-02-27.
//  Copyright © 2020 Pig on a Hill Productions. All rights reserved.
//

import Foundation

public extension NetatmoSecurity {
    
    struct SubEvent: Decodable, CustomStringConvertible {
        
        // MARK: - Properties
        
        public let identifier: String
        public let rawType: String
        public var type: SubEventType { SubEventType(rawValue: rawType) }
        private let time: TimeInterval
        public var date: Date { Date(timeIntervalSince1970: time) }
        public let offset: Int
        public let snapshot: Snapshot
        public let vignette: Vignette
        public let message: String
        
        public var description: String {
            "SubEvent(identifier: \(identifier), type: \(type), date: \(date), offset: \(offset), snapshot: \(snapshot), vignette: \(vignette), message: \(message))"
        }
        
        // MARK: - Coding
        
        private enum CodingKeys: String, CodingKey {
            case identifier = "id"
            case rawType = "type"
            case time
            case offset
            case snapshot
            case vignette
            case message
        }
    }
    
}
