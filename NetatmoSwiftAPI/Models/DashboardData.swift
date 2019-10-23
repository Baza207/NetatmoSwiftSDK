//
//  DashboardData.swift
//  NetatmoSwiftAPI
//
//  Created by James Barrow on 2019-10-23.
//  Copyright © 2019 Pig on a Hill Productions. All rights reserved.
//

import Foundation

public struct DashboardData: Decodable {
    private let time: TimeInterval // UTC
    public var date: Date { Date(timeIntervalSince1970: time) }
    public let temperature: Double
    public let co2: Int?
    public let humidity: Int
    public let noise: Int?
    public let pressure: Double?
    public let absolutePressure: Double?
    public let minTemp: Double
    public let maxTemp: Double
    private let maxTempTime: TimeInterval
    public var maxTempDate: Date { Date(timeIntervalSince1970: maxTempTime) }
    private let minTempTime: TimeInterval
    public var minTempDate: Date { Date(timeIntervalSince1970: minTempTime) }
    public let tempTrend: String
    public let pressureTrend: String?
    
    private enum CodingKeys: String, CodingKey {
        case time = "time_utc"
        case temperature = "Temperature"
        case co2 = "CO2"
        case humidity = "Humidity"
        case noise = "Noise"
        case pressure = "Pressure"
        case absolutePressure = "AbsolutePressure"
        case minTemp = "min_temp"
        case maxTemp = "max_temp"
        case maxTempTime = "date_max_temp"
        case minTempTime = "date_min_temp"
        case tempTrend = "temp_trend"
        case pressureTrend = "pressure_trend"
    }
}
