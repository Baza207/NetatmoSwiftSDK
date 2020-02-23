//
//  Place.swift
//  NetatmoSwiftAPI
//
//  Created by James Barrow on 2019-10-23.
//  Copyright © 2019 Pig on a Hill Productions. All rights reserved.
//

import Foundation
import CoreLocation

public extension NetatmoWeather {
    
    struct Place: Decodable, CustomStringConvertible {
        
        // MARK: - Properties
        
        /// The time zone of the weather station is in.
        public let timeZone: String
        /// The city the weather station is in.
        public let city: String?
        /// The country the weather station is in.
        public let country: String
        /// The altitude the weather station is at.
        public let altitude: Int
        private let location: [Double]
        /// The latitude and longitude coordinate the weather station is at.
        public var coordinate: CLLocationCoordinate2D {
            CLLocationCoordinate2D(latitude: location[0], longitude: location[1])
        }
        
        public var description: String {
            if let city = self.city {
                return "Place(city: \(city), country: \(country), timeZone: \(timeZone), altitude: \(altitude), coordinate: \(coordinate))"
            }
            return "Place(country: \(country), timeZone: \(timeZone), altitude: \(altitude), coordinate: \(coordinate))"
        }
        
        // MARK: - Coding
        
        private enum CodingKeys: String, CodingKey {
            case timeZone = "timezone"
            case city
            case country
            case altitude
            case location
        }
    }
    
}
