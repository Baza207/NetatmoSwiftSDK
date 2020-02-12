//
//  PlaceData.swift
//  NetatmoSwiftAPI
//
//  Created by James Barrow on 2019-10-23.
//  Copyright © 2019 Pig on a Hill Productions. All rights reserved.
//

import Foundation

public struct PlaceData: Decodable, CustomStringConvertible {
    public let altitude: Int
    public let city: String
    public let country: String
    public let timeZone: String
    public let location: [Double]
    public var description: String {
        "<PlaceData - \(city) - \(country) - \(timeZone) - \(location)>"
    }
    
    private enum CodingKeys: String, CodingKey {
        case altitude
        case city
        case country
        case timeZone = "timezone"
        case location
    }
}