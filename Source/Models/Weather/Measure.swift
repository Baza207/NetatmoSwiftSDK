//
//  Measure.swift
//  NetatmoSwiftSDK
//
//  Created by James Barrow on 2020-03-08.
//  Copyright © 2020 Pig on a Hill Productions. All rights reserved.
//

import Foundation

public extension NetatmoWeather {
    
    struct Measure: Decodable, CustomStringConvertible {

        // MARK: - Properties
        
        public let res: [String: [Double]]?
        public let type: [String]?
        /// Rain measured for the last hour in mm.
        public let rain1HourSummary: Double?
        /// Rain measured for past 24 hours in mm.
        public let rain24HourSummary: Double?
        /// Current rain in mm.
        public let rainLive: Double?
        /// Date when rain data was measured in UTC.
        public let rainDate: Date?
        /// Wind strength in km/h.
        public let windStrength: Double?
        /// Wind angle.
        public let windAngle: Double?
        /// Gust strengh in km/h.
        public let gustStrength: Double?
        /// Gust angle.
        public let gustAngle: Double?
        /// Date when wind data was measured in UTC.
        public let windDate: Date?
        
        public var description: String {
            if let res = self.res, let type = self.type {
                return "Measure(res: \(res), type: \(type))"
            } else if let rainLive = self.rainLive, let rainDate = self.rainDate, let rain1HourSummary = self.rain1HourSummary, let rain24HourSummary = self.rain24HourSummary {
                return "Measure(rainLive: \(rainLive), rainDate: \(rainDate), rain1HourSummary: \(rain1HourSummary), rain24HourSummary: \(rain24HourSummary))"
            } else if let windStrength = self.windStrength, let windAngle = self.windAngle, let gustStrength = self.gustStrength, let gustAngle = self.gustAngle {
                return "Measure(windStrength: \(windStrength), windAngle: \(windAngle), gustStrength: \(gustStrength), gustAngle: \(gustAngle))"
            }
            return "Measure()"
        }
        
        // MARK: - Coding
        
        private enum CodingKeys: String, CodingKey {
            case res
            case type
            case rain1HourSummary = "rain_60min"
            case rain24HourSummary = "rain_24h"
            case rainLive = "rain_live"
            case rainDate = "rain_timeutc"
            case windStrength = "wind_strengh"
            case windAngle = "wind_angle"
            case gustStrength = "gust_strenght"
            case gustAngle = "gust_angle"
            case windDate = "wind_timeutc"
        }
        
        // MARK: - Init
        
        public init(res: [String: [Double]]? = nil, type: [String]? = nil, rain1HourSummary: Double? = nil, rain24HourSummary: Double? = nil, rainLive: Double? = nil, rainDate: Date? = nil, windStrength: Double? = nil, windAngle: Double? = nil, gustStrength: Double? = nil, gustAngle: Double? = nil, windDate: Date? = nil) {
            
            self.res = res
            self.type = type
            self.rain1HourSummary = rain1HourSummary
            self.rain24HourSummary = rain24HourSummary
            self.rainLive = rainLive
            self.rainDate = rainDate
            self.windStrength = windStrength
            self.windAngle = windAngle
            self.gustStrength = gustStrength
            self.gustAngle = gustAngle
            self.windDate = windDate
        }
        
    }
    
}
