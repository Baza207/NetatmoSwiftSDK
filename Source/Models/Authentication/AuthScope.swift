//
//  AuthScope.swift
//  NetatmoSwiftSDK
//
//  Created by James Barrow on 2020-01-01.
//  Copyright © 2020 Pig on a Hill Productions. All rights reserved.
//

import Foundation

/// If no scope is provided during the token request, the default is "read_station"
public enum AuthScope: String, Decodable {
    /// To retrieve weather station data (Getstationsdata, Getmeasure)
    case readStation = "read_station"
    /// To retrieve thermostat data ( Homestatus, Getroommeasure)
    case readThermostat = "read_thermostat"
    /// To set up the thermostat (Synchomeschedule, Setroomthermpoint)
    case writeThermostat = "write_thermostat"
    /// To retrieve Welcome data (Gethomedata, Getcamerapicture)
    case readCamera = "read_camera"
    /// To tell Welcome a specific person or everybody has left the Home (Setpersonsaway, Setpersonshome)
    case writeCamera = "write_camera"
    /// To access the camera, the videos and the live stream *
    case accessCamera = "access_camera"
    /// To retrieve Presence data (Gethomedata, Getcamerapicture)
    case readPresence = "read_presence"
    /// To access the camera, the videos and the live stream *
    case accessPresence = "access_presence"
    /// To read data coming from Healthy Home Coach (gethomecoachsdata)
    case readHomecoach = "read_homecoach"
    /// To retrieve Smoke Detector data (Gethomedata)
    case readSmokeDetector = "read_smokedetector"
    
    /// The type of seperator used when creating the auth scope string
    enum SeparationType: String {
        case dot = "."
        case space = " "
    }
    
    /// Creates a string from auth scopes
    /// - Parameters:
    ///   - scope: The auth scopes to create a string from
    ///   - separationType: The type of seperator to use when joining the auth scopes into a string
    internal static func string(from scope: [AuthScope], separationType: SeparationType = .dot) -> String {
        guard scope.count > 0 else {
            return AuthScope.readStation.rawValue
        }
        return scope.map { $0.rawValue }.joined(separator: separationType.rawValue)
    }
    
    /// Parses auth scopes out of a string
    /// - Parameters:
    ///   - string: The string that contains the auth scopes
    ///   - separationType: The type of seperator that is used to join auth scopes
    internal static func scopes(from string: String, separationType: SeparationType = .dot) -> [AuthScope] {
        guard string.isEmpty == false else {
            return [.readStation]
        }
        
        return string.components(separatedBy: separationType.rawValue).compactMap { AuthScope(rawValue: "\($0)") }
    }
    
}
