//
//  Home.swift
//  NetatmoSwiftSDK
//
//  Created by James Barrow on 2020-07-31.
//  Copyright © 2020 Pig on a Hill Productions. All rights reserved.
//

import Foundation
import CoreLocation

public extension NetatmoEnergy {
    
    struct Home: Decodable, CustomStringConvertible {
        
        // MARK: - Properties
        
        /// ID of the home.
        public let identifier: String
        /// Name of the home.
        public let name: String
        /// The altitude the home is at.
        public let altitude: Int?
        private let location: [Double]?
        /// The latitude and longitude coordinate the home is at.
        public var coordinate: CLLocationCoordinate2D? {
            guard let location = self.location, location.count == 2 else { return nil }
            return CLLocationCoordinate2D(latitude: location[0], longitude: location[1])
        }
        /// The time zone of the home is in.
        public let timeZone: String
        /// The country the home is in.
        public let country: String
        private let rawRooms: [Room]?
        /// The rooms in the home.
        public var rooms: [Room] { rawRooms ?? [] }
        private let rawModules: [Module]?
        /// The modules in the home.
        public var modules: [Module] { rawModules ?? [] }
        /// Default duration for a set point.
        public let thermalSetPointDefaultDuration: Int?
        private let rawSchedules: [Schedule]?
        /// The schedules for the home.
        public var schedules: [Schedule] { rawSchedules ?? [] }
        private let rawThermalMode: String?
        /// The thermal mode of the home.
        public var thermalMode: ThermalMode? {
            guard let rawThermalMode = self.rawThermalMode else { return nil }
            return ThermalMode(rawValue: rawThermalMode)
        }
        
        public var description: String {
            var description = "Home(identifier: \(identifier), name: \(name), timeZone: \(timeZone), country: \(country)"
            
            if let altitude = self.altitude {
                description += ", altitude: \(altitude)"
            }
            
            if let coordinate = self.coordinate {
                description += ", coordinate: \(coordinate)"
            }
            
            if let thermalSetPointDefaultDuration = self.thermalSetPointDefaultDuration {
                description += ", thermalSetPointDefaultDuration: \(thermalSetPointDefaultDuration)"
            }
            
            if let thermalMode = self.thermalMode {
                description += ", thermalMode: \(thermalMode)"
            }
            
            return description + ")"
        }
        
        // MARK: - Coding
        
        private enum CodingKeys: String, CodingKey {
            case identifier = "id"
            case name
            case altitude
            case location = "coordinates"
            case timeZone = "timezone"
            case country
            case rawRooms = "room"
            case rawModules = "modules"
            case thermalSetPointDefaultDuration = "therm_set_point_default_duration"
            case rawSchedules = "schedules"
            case rawThermalMode = "therm_mode"
        }
        
        // MARK: - Init
        
        public init(identifier: String, name: String, timeZone: String, country: String, altitude: Int? = nil, coordinate: CLLocationCoordinate2D? = nil, rooms: [Room] = [], modules: [Module] = [], thermalSetPointDefaultDuration: Int? = nil, schedules: [Schedule] = [], thermalMode: ThermalMode? = nil) {
            
            self.identifier = identifier
            self.name = name
            self.timeZone = timeZone
            self.country = country
            self.altitude = altitude
            self.rawRooms = rooms
            self.rawModules = modules
            self.thermalSetPointDefaultDuration = thermalSetPointDefaultDuration
            self.rawSchedules = schedules
            self.rawThermalMode = thermalMode?.rawValue
            
            if let coordinate = coordinate {
                location = [coordinate.latitude, coordinate.longitude]
            } else {
                location = nil
            }
        }
        
    }
    
}
