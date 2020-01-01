//
//  AuthScope.swift
//  NetatmoSwiftAPI
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
    
    internal static func string(from scope: [AuthScope]) -> String {
        guard scope.count > 0 else {
            return AuthScope.readStation.rawValue
        }
        return scope.map { $0.rawValue }.joined(separator: " ")
    }
    
    internal static func scopes(from string: String) -> [AuthScope] {
        guard string.isEmpty == false else {
            return [.readStation]
        }
        return string.split(separator: " ").compactMap { AuthScope(rawValue: "\($0)") }
    }
}
