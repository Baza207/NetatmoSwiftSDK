//
//  EnergyTypes.swift
//  NetatmoSwiftSDK
//
//  Created by James Barrow on 2020-07-31.
//  Copyright © 2020 Pig on a Hill Productions. All rights reserved.
//

import Foundation

public extension NetatmoEnergy {
    
    enum ProductType: CustomStringConvertible {
        case relay
        case smartThermostat
        case smartValves
        case other(String)
        
        init(rawValue: String) {
            switch rawValue {
            case "NAPlug":
                self = .relay
            case "NATherm1":
                self = .smartThermostat
            case "NRV":
                self = .smartValves
            default:
                self = .other(rawValue)
            }
        }
        
        var rawValue: String {
            switch self {
            case .relay:
                return "NAPlug"
            case .smartThermostat:
                return "NATherm1"
            case .smartValves:
                return "NRV"
            case .other(let rawValue):
                return rawValue
            }
        }
        
        public var description: String {
            switch self {
            case .relay:
                return "Relay"
            case .smartThermostat:
                return "Smart Thermostat"
            case .smartValves:
                return "Smart Valves"
            case .other(let rawValue):
                return "Other [\(rawValue)]"
            }
        }
    }
    
    enum ThermalMode: CustomStringConvertible {
        case schedule
        case away
        case frostGuard
        case other(String)
        
        init(rawValue: String) {
            switch rawValue {
            case "schedule":
                self = .schedule
            case "away":
                self = .away
            case "frost_guard":
                self = .frostGuard
            default:
                self = .other(rawValue)
            }
        }
        
        var rawValue: String {
            switch self {
            case .schedule:
                return "schedule"
            case .away:
                return "away"
            case .frostGuard:
                return "frost_guard"
            case .other(let rawValue):
                return rawValue
            }
        }
        
        public var description: String {
            switch self {
            case .schedule:
                return "Schedule"
            case .away:
                return "Away"
            case .frostGuard:
                return "Frost Guard"
            case .other(let rawValue):
                return "Other [\(rawValue)]"
            }
        }
    }
    
    enum ZoneType: Int {
        case unknown = -1
        case day = 0
        case night = 1
        case away = 2
        case frostGuard = 3
        case custom = 4
        case eco = 5
        case comfort = 6
        
        public var description: String {
            switch self {
            case .unknown:
                return "Unknown"
            case .day:
                return "Day"
            case .night:
                return "Night"
            case .away:
                return "Away"
            case .frostGuard:
                return "Frost Guard"
            case .custom:
                return "Custom"
            case .eco:
                return "Eco"
            case .comfort:
                return "Comfort"
            }
        }
    }
    
}
