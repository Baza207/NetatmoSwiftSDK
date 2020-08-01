//
//  Schedule.swift
//  NetatmoSwiftSDK
//
//  Created by James Barrow on 2020-07-31.
//  Copyright © 2020 Pig on a Hill Productions. All rights reserved.
//

import Foundation

public extension NetatmoEnergy {
    
    struct Schedule: Decodable, CustomStringConvertible {
        
        // MARK: - Properties
        
        /// ID of the schedule.
        public let identifier: String
        /// Name of the schedule.
        public let name: String
        /// Type of schedule.
        public let type: String
        /// `true` if the schedule is the default one.
        public let isDefault: Bool
        /// `true` if the schedule is applied.
        public let isSelected: Bool
        /// Away temperature value.
        public let awayTemperature: Int
        /// Frostguard temperature value
        public let frostguardTemperature: Int
        private let rawTimetable: [Timetable]?
        public var timetable: [Timetable] { rawTimetable ?? [] }
        private let rawZones: [Zone]?
        public var zones: [Zone] { rawZones ?? [] }
        public var description: String {
            "Schedule(identifier: \(identifier), name: \(name), type: \(type), type: \(type), isSelected: \(isSelected), awayTemperature: \(awayTemperature), frostguardTemperature: \(frostguardTemperature), timetable: \(timetable), zones: \(zones))"
        }
        
        // MARK: - Coding
        
        private enum CodingKeys: String, CodingKey {
            case identifier = "id"
            case name
            case type
            case isDefault = "default"
            case isSelected = "selected"
            case awayTemperature = "away_temp"
            case frostguardTemperature = "hg_temp"
            case rawTimetable = "timetable"
            case rawZones = "zones"
        }
        
        // MARK: - Init
        
        public init(identifier: String, name: String, type: String, isDefault: Bool, isSelected: Bool, awayTemperature: Int, frostguardTemperature: Int, timetable: [Timetable], zones: [Zone]) {
            
            self.identifier = identifier
            self.name = name
            self.type = type
            self.isDefault = isDefault
            self.isSelected = isSelected
            self.awayTemperature = awayTemperature
            self.frostguardTemperature = frostguardTemperature
            self.rawTimetable = timetable
            self.rawZones = zones
        }
        
    }
    
}
