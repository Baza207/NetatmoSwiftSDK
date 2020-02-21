//
//  Weather.swift
//  NetatmoSwiftAPI
//
//  Created by James Barrow on 2020-02-20.
//  Copyright © 2020 Pig on a Hill Productions. All rights reserved.
//

import Foundation

public struct Weather {
    
    // MARK: - Types
    
    public enum Unit: Int, Decodable, CustomStringConvertible {
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
    
    public enum WindUnit: Int, Decodable, CustomStringConvertible {
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
    
    public enum PressureUnit: Int, Decodable, CustomStringConvertible {
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
    
    public enum FeelsLikeAlgorithm: Int, Decodable, CustomStringConvertible {
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

    public enum Trend: String, Decodable, CustomStringConvertible {
        case up
        case down
        case stable
        
        public var description: String {
            rawValue
        }
    }
    
}
