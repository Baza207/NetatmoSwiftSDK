//
//  Dashboard.swift
//  NetatmoSwiftSDK
//
//  Created by James Barrow on 2019-10-23.
//  Copyright © 2019 Pig on a Hill Productions. All rights reserved.
//

import Foundation

public extension NetatmoWeather {
    
    struct Dashboard: Decodable, CustomStringConvertible {
        
        // MARK: - Properties
        
        /// Date when data was measured in UTC.
        public let date: Date
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
        /// Minimum temperature date masured.
        public let minTemperatureDate: Date?
        /// Maximum temperature date masured.
        public let maxTemperatureDate: Date?
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
        /// Maximum wind strength date masured.
        public let maxWindStrengthDate: Date?
        
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
            case date = "time_utc"
            case temperature = "Temperature"
            case co2 = "CO2"
            case humidity = "Humidity"
            case noise = "Noise"
            case pressure = "Pressure"
            case absolutePressure = "AbsolutePressure"
            case minTemperature = "min_temp"
            case maxTemperature = "max_temp"
            case minTemperatureDate = "date_min_temp"
            case maxTemperatureDate = "date_max_temp"
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
            case maxWindStrengthDate = "date_max_wind_str"
        }
        
        // MARK: - Init
        
        public init(date: Date, temperature: Double? = nil, co2: Int? = nil, humidity: Int? = nil, noise: Int? = nil, pressure: Double? = nil, absolutePressure: Double? = nil, minTemperature: Double? = nil, maxTemperature: Double? = nil, minTemperatureDate: Date? = nil, maxTemperatureDate: Date? = nil, temperatureTrend: Trend? = nil, pressureTrend: Trend? = nil, rain: Double? = nil, rain24HourSummary: Double? = nil, rain1HourSummary: Double? = nil, windStrength: Double? = nil, windAngle: Double? = nil, gustStrength: Double? = nil, gustAngle: Double? = nil, maxWindStrength: Double? = nil, maxWindAngle: Double? = nil, maxWindStrengthDate: Date? = nil) {
            
            self.date = date
            self.temperature = temperature
            self.co2 = co2
            self.humidity = humidity
            self.noise = noise
            self.pressure = pressure
            self.absolutePressure = absolutePressure
            self.minTemperature = minTemperature
            self.maxTemperature = maxTemperature
            self.minTemperatureDate = minTemperatureDate
            self.maxTemperatureDate = maxTemperatureDate
            self.temperatureTrend = temperatureTrend
            self.pressureTrend = pressureTrend
            self.rain = rain
            self.rain24HourSummary = rain24HourSummary
            self.rain1HourSummary = rain1HourSummary
            self.windStrength = windStrength
            self.windAngle = windAngle
            self.gustStrength = gustStrength
            self.gustAngle = gustAngle
            self.maxWindStrength = maxWindStrength
            self.maxWindAngle = maxWindAngle
            self.maxWindStrengthDate = maxWindStrengthDate
        }
        
    }
    
}
