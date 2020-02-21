//
//  Dashboard.swift
//  NetatmoSwiftAPI
//
//  Created by James Barrow on 2019-10-23.
//  Copyright © 2019 Pig on a Hill Productions. All rights reserved.
//

import Foundation

public extension Weather {
    
    struct Dashboard: Decodable, CustomStringConvertible {
        
        // MARK: - Properties
        
        private let time: TimeInterval // UTC
        /// Date when data was measured in UTC.
        public var date: Date { Date(timeIntervalSince1970: time) }
        /// Temperature in °C.
        public let temperature: Double?
        /// CO2 level in ppm.
        public let co2: Int?
        /// Humidity in %.
        public let humidity: Int?
        /// Noise level in dB.
        public let noise: Int?
        /// Surface pressure in mbar.
        public let pressure: Double?
        /// Sea-level pressure in mbar.
        public let absolutePressure: Double?
        /// Minimum temperature in °C.
        public let minTemperature: Double?
        /// Maximum temperature in °C.
        public let maxTemperature: Double?
        private let minTemperatureTime: TimeInterval?
        /// Minimum temperature date masured.
        public var minTemperatureDate: Date? {
            guard let minTemperatureTime = self.minTemperatureTime else { return nil }
            return Date(timeIntervalSince1970: minTemperatureTime)
        }
        private let maxTemperatureTime: TimeInterval?
        /// Maximum temperature date masured.
        public var maxTemperatureDate: Date? {
            guard let maxTemperatureTime = self.maxTemperatureTime else { return nil }
            return Date(timeIntervalSince1970: maxTemperatureTime)
        }
        /// Trend for the last 12 hours (up, down, stable).
        public let temperatureTrend: Trend?
        /// Trend for the last 12 hours (up, down, stable).
        public let pressureTrend: Trend?
        /// Rain in mm.
        public let rain: Double?
        /// Rain measured for past 24 hours in mm.
        public let rain24HourSummary: Double?
        /// Rain measured for the last hour in mm.
        public let rain1HourSummary: Double?
        /// Wind strength in km/h.
        public let windStrength: Double?
        /// Wind angle.
        public let windAngle: Double?
        /// Gust strengh in km/h.
        public let gustStrength: Double?
        /// Gust angle.
        public let gustAngle: Double?
        /// Maximum wind strength.
        public let maxWindStrength: Double?
        /// Maximum wind angle.
        public let maxWindAngle: Double?
        private let maxWindStrengthTime: TimeInterval?
        /// Maximum wind strength date masured.
        public var maxWindStrengthDate: Date? {
            guard let maxWindStrengthTime = self.maxWindStrengthTime else { return nil }
            return Date(timeIntervalSince1970: maxWindStrengthTime)
        }
        
        public var description: String {
            if let temperature = self.temperature {
                return "Dashboard(date: \(date), temperature: \(temperature))"
            } else if let rain = self.rain {
                return "Dashboard(date: \(date), rain: \(rain))"
            } else if let windStrength = self.windStrength {
                return "Dashboard(date: \(date), windStrength: \(windStrength))"
            }
            return "Dashboard(date: \(date))"
        }
        
        // MARK: - Coding
        
        private enum CodingKeys: String, CodingKey {
            case time = "time_utc"
            case temperature = "Temperature"
            case co2 = "CO2"
            case humidity = "Humidity"
            case noise = "Noise"
            case pressure = "Pressure"
            case absolutePressure = "AbsolutePressure"
            case minTemperature = "min_temp"
            case maxTemperature = "max_temp"
            case minTemperatureTime = "date_min_temp"
            case maxTemperatureTime = "date_max_temp"
            case temperatureTrend = "temp_trend"
            case pressureTrend = "pressure_trend"
            case rain = "Rain"
            case rain24HourSummary = "sum_rain_24"
            case rain1HourSummary = "sum_rain_1"
            case windStrength = "WindStrength"
            case windAngle = "WindAngle"
            case gustStrength = "GustStrength"
            case gustAngle = "GustAngle"
            case maxWindStrength = "max_wind_str"
            case maxWindAngle = "max_wind_angle"
            case maxWindStrengthTime = "date_max_wind_str"
        }
    }
    
}
