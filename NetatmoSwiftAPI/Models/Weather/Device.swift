//
//  Device.swift
//  NetatmoSwiftAPI
//
//  Created by James Barrow on 2019-10-23.
//  Copyright © 2019 Pig on a Hill Productions. All rights reserved.
//

import Foundation

public extension NetatmoWeather {
    
    struct Device: Decodable, CustomStringConvertible {
        
        // MARK: - Properties
        
        /// MAC address of the device.
        public let identifier: String
        private let setup: TimeInterval
        /// Date when the weather station was set up.
        public var setupDate: Date { Date(timeIntervalSince1970: setup) }
        private let lastSetup: TimeInterval
        /// Date of the last installation.
        public var lastSetupDate: Date { Date(timeIntervalSince1970: lastSetup) }
        /// Type of the device.
        public let type: String
        private let lastStatusStore: TimeInterval
        /// Date of the last status update.
        public var lastStatusStoreDate: Date { Date(timeIntervalSince1970: lastStatusStore) }
        /// Name of the module.
        public let name: String
        /// Version of the software.
        public let firmware: Int
        private let lastUpgrade: TimeInterval
        /// Date of the last upgrade.
        public var lastUpgradeDate: Date { Date(timeIntervalSince1970: lastUpgrade) }
        /// WiFi status per Base station. (86=bad, 56=good)
        public let wifiStatus: Int
        /// `true` if the station connected to Netatmo cloud within the last 4 hours.
        public let reachable: Bool
        /// `true` if the station is calibrating.
        public let co2Calibrating: Bool
        /// Name of the station.
        public let stationName: String
        /// Array of data measured by the device (e.g. "Temperature", "Humidity").
        public let dataType: [String]
        /// Describes the place where the weather station is.
        public let place: Place
        /// `true` if the user owns the station, `false` if he is invited to a station.
        public let readOnly: Bool?
        public let dashboard: Dashboard
        public let modules: [Module]
        
        public var description: String {
            "Device(name: \(name), stationName: \(stationName), place: \(place), dashboard: \(dashboard), modules: \(modules))"
        }
        
        // MARK: - Coding
        
        private enum CodingKeys: String, CodingKey {
            case identifier = "_id"
            case setup = "date_setup"
            case lastSetup = "last_setup"
            case type
            case lastStatusStore = "last_status_store"
            case name = "module_name"
            case firmware
            case lastUpgrade = "last_upgrade"
            case wifiStatus = "wifi_status"
            case reachable
            case co2Calibrating = "co2_calibrating"
            case stationName = "station_name"
            case dataType = "data_type"
            case place
            case readOnly = "read_only"
            case dashboard = "dashboard_data"
            case modules
        }
    }
    
}
