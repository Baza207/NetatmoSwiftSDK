//
//  Place.swift
//  NetatmoSwiftSDK
//
//  Created by James Barrow on 2019-10-23.
//  Copyright © 2019 Pig on a Hill Productions. All rights reserved.
//

import Foundation
import CoreLocation

public extension NetatmoManager {
    
    struct Place: Decodable, CustomStringConvertible {
        
        // MARK: - Properties
        
        /// The time zone of the weather station is in.
        public let timeZone: String
        /// The city the weather station is in.
        public let city: String?
        /// The country the weather station is in.
        public let country: String
        /// The altitude the weather station is at.
        public let altitude: Int?
        private let location: [Double]?
        /// The latitude and longitude coordinate the weather station is at.
        public var coordinate: CLLocationCoordinate2D? {
            guard let location = self.location, location.count == 2 else { return nil }
            return CLLocationCoordinate2D(latitude: location[0], longitude: location[1])
        }
        
        public var description: String {
            var description = "Place(timeZone: \(timeZone), country: \(country)"
            
            if let city = self.city {
                description += ", city: \(city)"
            }
            
            if let altitude = self.altitude {
                description += ", altitude: \(altitude)"
            }
            
            if let coordinate = self.coordinate {
                description += ", coordinate: \(coordinate)"
            }
            
            return description + ")"
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
