//
//  Home.swift
//  NetatmoSwiftSDK
//
//  Created by James Barrow on 2020-02-27.
//  Copyright © 2020 Pig on a Hill Productions. All rights reserved.
//

import Foundation

public extension NetatmoSecurity {
    
    struct Home: Decodable, CustomStringConvertible {
        
        // MARK: - Properties
        
        /// ID of the home.
        public let identifier: String
        /// Name of the home.
        public let name: String
        private let rawPeople: [Person]?
        public var people: [Person] { rawPeople ?? [] }
        public let place: NetatmoManager.Place
        private let rawCameras: [Camera]?
        public var cameras: [Camera] { rawCameras ?? [] }
        private let rawSmokeDetectors: [SmokeDetector]?
        public var smokeDetectors: [SmokeDetector] { rawSmokeDetectors ?? [] }
        private let rawEvents: [Event]?
        public var events: [Event] { rawEvents ?? [] }
        
        public var description: String {
            "Home(identifier: \(identifier), name: \(name), peopleCount: \(people.count), place: \(place), cameras: \(cameras), smokeDetectors: \(smokeDetectors), eventsCount: \(events.count))"
        }
        
        // MARK: - Coding
        
        private enum CodingKeys: String, CodingKey {
            case identifier = "id"
            case name
            case rawPeople = "persons"
            case place
            case rawCameras = "cameras"
            case rawSmokeDetectors = "smokedetectors"
            case rawEvents = "events"
        }
        
        // MARK: - Init
        
        public init(identifier: String, name: String, people: [Person], place: NetatmoManager.Place, cameras: [Camera], smokeDetectors: [SmokeDetector], events: [Event]) {
            
            self.identifier = identifier
            self.name = name
            self.rawPeople = people
            self.place = place
            self.rawCameras = cameras
            self.rawSmokeDetectors = smokeDetectors
            self.rawEvents = events
        }
        
    }
    
}
