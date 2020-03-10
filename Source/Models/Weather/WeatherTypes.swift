//
//  WeatherTypes.swift
//  NetatmoSwiftSDK
//
//  Created by James Barrow on 2020-02-20.
//  Copyright © 2020 Pig on a Hill Productions. All rights reserved.
//

import Foundation

public extension NetatmoWeather {
    
    // MARK: - Types
    
    enum ProductType: CustomStringConvertible {
        case baseStation
        case outdoorModule
        case rainModule
        case windModule
        case indoorModule
        case other(String)
        
        init(rawValue: String) {
            switch rawValue {
            case "NAMain":
                self = .baseStation
            case "NAModule1":
                self = .outdoorModule
            case "NAModule2":
                self = .rainModule
            case "NAModule3":
                self = .windModule
            case "NAModule4":
                self = .indoorModule
            default:
                self = .other(rawValue)
            }
        }
        
        var rawValue: String {
            switch self {
            case .baseStation:
                return "NAMain"
            case .outdoorModule:
                return "NAModule1"
            case .rainModule:
                return "NAModule2"
            case .windModule:
                return "NAModule3"
            case .indoorModule:
                return "NAModule4"
            case .other(let rawValue):
                return rawValue
            }
        }
        
        public var description: String {
            switch self {
            case .baseStation:
                return "Base Station"
            case .outdoorModule:
                return "Outdoor Module"
            case .rainModule:
                return "Rain Module"
            case .windModule:
                return "Wind Module"
            case .indoorModule:
                return "Indoor Module"
            case .other(let rawValue):
                return "Other [\(rawValue)]"
            }
        }
    }
    
    enum TimeScale: String {
        case thirtyMin = "30min"
        case oneHour = "1hour"
        case threeHours = "3hours"
        case oneDay = "1day"
        case oneWeek = "1week"
        case oneMonth = "1month"
    }
    
    enum MeasureType: String {
        case temperature
        case humidity
        case datemaxCO2 = "date_max_co2"
        case dateMinCO2 = "date_min_co2"
        case dateMaxNoise = "date_max_noise"
        case dateMinNoise = "date_min_noise"
        case dateMaxPressure = "date_max_pressure"
        case dateMinPressure = "date_min_pressure"
        case dateMaxHumidity = "date_max_hum"
        case dateMaxGust = "date_max_gust"
        case sumRain = "sum_rain"
        case minNoise = "min_noise"
        case maxNoise = "max_noise"
        case maxPressure = "max_pressure"
        case minPressure = "min_pressure"
        case maxHumidity = "max_hum"
        case minHumidity = "min_hum"
        case dateMaxTemp = "date_max_temp"
        case dateMinTemp = "date_min_temp"
        case maxTemp = "max_temp"
        case minTemp = "min_temp"
        case gustAngle = "gustangle"
        case gustStrength = "guststrength"
        case windAngle = "windangle"
        case windStrenght = "windstrenght"
        case noise
        case rain
        case co2
        case pressure
    }
    
    enum Unit: Int, Decodable, CustomStringConvertible {
        case metric = 0
        case imperial = 1
        
        public var description: String {
            switch self {
            case .metric:
                return "metric"
            case .imperial:
                return "imperial"
            }
        }
    }
    
    enum WindUnit: Int, Decodable, CustomStringConvertible {
        case kph = 0
        case mph = 1
        case ms = 2
        case beaufort = 3
        case knot = 4
        
        public var description: String {
            switch self {
            case .kph:
                return "kph"
            case .mph:
                return "mph"
            case .ms:
                return "ms"
            case .beaufort:
                return "beaufort"
            case .knot:
                return "knot"
            }
        }
    }
    
    enum PressureUnit: Int, Decodable, CustomStringConvertible {
        case mbar = 0
        case inHg = 1
        case mmHg = 2
        
        public var description: String {
            switch self {
            case .mbar:
                return "mbar"
            case .inHg:
                return "inHg"
            case .mmHg:
                return "mmHg"
            }
        }
    }
    
    enum FeelsLikeAlgorithm: Int, Decodable, CustomStringConvertible {
        case humidex = 0
        case heatIndex = 1
        
        public var description: String {
            switch self {
            case .humidex:
                return "humidex"
            case .heatIndex:
                return "heatIndex"
            }
        }
    }

    enum Trend: String, Decodable, CustomStringConvertible {
        case up
        case down
        case stable
        
        public var description: String {
            rawValue
        }
    }
    
}
