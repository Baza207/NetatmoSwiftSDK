//
//  PublicData.swift
//  NetatmoSwiftAPI
//
//  Created by James Barrow on 2020-02-19.
//  Copyright © 2020 Pig on a Hill Productions. All rights reserved.
//

import Foundation

public extension NetatmoWeather {
    
    struct PublicDataBase: Decodable, CustomStringConvertible {
        
        // MARK: - Properties
        
        /// The body of the result.
        public let body: [PublicData]?
        /// The status of the result.
        public let status: String?
        /// The error if the request errors.
        internal let error: NetatmoManager.RequestError?
        
        public var description: String {
            if let status = self.status, let body = self.body {
                return "PublicDataBase(status: \(status), body: \(body))"
            } else if let error = self.error {
                return "PublicDataBase(errorCode: \(error.code), body: \(error.message))"
            }
            return "PublicDataBase()"
        }
        
    }
    
    struct PublicData: Decodable, CustomStringConvertible {
        
        // MARK: - Properties
        
        /// MAC address of the device.
        public let identifier: String
        /// Describes the place where the weather station is.
        public let place: Place
        public let mark: Int
        public let measures: [String: Measure]
        public let modules: [String]
        public let moduleTypes: [String: String]
        
        public var description: String {
            "PublicData(identifier: \(identifier), place: \(place), mark: \(mark), measures: \(measures), modules: \(modules), moduleTypes: \(moduleTypes))"
        }
        
        // MARK: - Coding
        
        private enum CodingKeys: String, CodingKey {
            case identifier = "_id"
            case place
            case mark
            case measures
            case modules
            case moduleTypes = "module_types"
        }
    }
    
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
        private let rainTime: TimeInterval?
        /// Date when rain data was measured in UTC.
        public var rainDate: Date? {
            guard let rainTime = self.rainTime else { return nil }
            return Date(timeIntervalSince1970: rainTime)
        }
        /// Wind strength in km/h.
        public let windStrength: Double?
        /// Wind angle.
        public let windAngle: Double?
        /// Gust strengh in km/h.
        public let gustStrength: Double?
        /// Gust angle.
        public let gustAngle: Double?
        private let windTime: TimeInterval?
        /// Date when wind data was measured in UTC.
        public var windDate: Date? {
            guard let windTime = self.windTime else { return nil }
            return Date(timeIntervalSince1970: windTime)
        }
        
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
            case rainTime = "rain_timeutc"
            case windStrength = "wind_strengh"
            case windAngle = "wind_angle"
            case gustStrength = "gust_strenght"
            case gustAngle = "gust_angle"
            case windTime = "wind_timeutc"
        }
    }
    
}
