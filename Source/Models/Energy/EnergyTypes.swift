//
//  EnergyTypes.swift
//  NetatmoSwiftSDK
//
//  Created by James Barrow on 2020-07-31.
//  Copyright © 2020 Pig on a Hill Productions. All rights reserved.
//

import Foundation

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
}
