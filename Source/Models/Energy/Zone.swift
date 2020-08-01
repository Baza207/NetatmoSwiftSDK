//
//  Zone.swift
//  NetatmoSwiftSDK
//
//  Created by James Barrow on 2020-08-01.
//  Copyright © 2020 Pig on a Hill Productions. All rights reserved.
//

import Foundation

public extension NetatmoEnergy {
    
    struct Zone: Decodable, CustomStringConvertible {
        
        // MARK: - Properties
        
        /// ID of the zone.
        public let identifier: String
        /// Name of the zone.
        public let name: String
        /// Type of the zone.
        private let rawType: Int
        /// Type of the zone (day, night, away, frost guard, custom, eco, comfort).
        public var type: ZoneType { ZoneType(rawValue: rawType) ?? .unknown }
        private let rawRooms: [Room]?
        public var rooms: [Room] { rawRooms ?? [] }
        public var description: String {
            "Zone(identifier: \(identifier), name: \(name), type: \(type), rooms: \(rooms))"
        }
        
        // MARK: - Coding
        
        private enum CodingKeys: String, CodingKey {
            case identifier = "id"
            case name
            case rawType = "type"
            case rawRooms = "rooms"
        }
        
        // MARK: - Init
        
        public init(identifier: String, name: String, type: ZoneType, rooms: [Room]) {
            
            self.identifier = identifier
            self.name = name
            self.rawType = type.rawValue
            self.rawRooms = rooms
        }
        
    }
    
}
