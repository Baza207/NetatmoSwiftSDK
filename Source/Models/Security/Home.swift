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
        public let people: [Person]
        public let place: NetatmoManager.Place
        public let cameras: [Camera]
        public let smokeDetectors: [SmokeDetector]
        public let events: [Event]
        
        public var description: String {
            "Home(identifier: \(identifier), name: \(name), peopleCount: \(people.count), place: \(place), cameras: \(cameras), smokeDetectors: \(smokeDetectors), eventsCount: \(events.count))"
        }
        
        // MARK: - Coding
        
        private enum CodingKeys: String, CodingKey {
            case identifier = "id"
            case name
            case people = "persons"
            case place
            case cameras
            case smokeDetectors = "smokedetectors"
            case events
        }
        
        // MARK: - Init
        
        public init(identifier: String, name: String, people: [Person], place: NetatmoManager.Place, cameras: [Camera], smokeDetectors: [SmokeDetector], events: [Event]) {
            
            self.identifier = identifier
            self.name = name
            self.people = people
            self.place = place
            self.cameras = cameras
            self.smokeDetectors = smokeDetectors
            self.events = events
        }
        
    }
    
}
