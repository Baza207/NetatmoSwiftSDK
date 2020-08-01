//
//  Room.swift
//  NetatmoSwiftSDK
//
//  Created by James Barrow on 2020-07-31.
//  Copyright © 2020 Pig on a Hill Productions. All rights reserved.
//

import Foundation

public extension NetatmoEnergy {
    
    struct Room: Decodable, CustomStringConvertible {
        
        // MARK: - Properties
        
        /// ID of the room.
        public let identifier: String
        /// Name of the room.
        public let name: String?
        /// Type of room.
        public let type: String?
        private let rawModuleIds: [String]?
        /// Array of the modules by ID associated to this room.
        public var moduleIds: [String] { rawModuleIds ?? [] }
        /// Set point temperature.
        public let thermalSetPointTemperature: Int?
        public var description: String {
            "Room(identifier: \(identifier), moduleIds: \(moduleIds))"
        }
        
        // MARK: - Coding
        
        private enum CodingKeys: String, CodingKey {
            case identifier = "id"
            case name
            case type
            case rawModuleIds = "module_ids"
            case thermalSetPointTemperature = "therm_setpoint_temperature"
        }
        
        // MARK: - Init
        
        public init(identifier: String, name: String? = nil, type: String? = nil, moduleIds: [String] = [], thermalSetPointTemperature: Int? = nil) {
            
            self.identifier = identifier
            self.name = name
            self.type = type
            self.rawModuleIds = moduleIds
            self.thermalSetPointTemperature = thermalSetPointTemperature
        }
        
    }
}
