//
//  Device.swift
//  NetatmoSwiftSDK
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
        /// Date when the weather station was set up.
        public let setupDate: Date
        /// Date of the last installation.
        public let lastSetupDate: Date
        /// Type of the device.
        public let type: String
        /// Date of the last status update.
        public let lastStatusStoreDate: Date
        /// Name of the module.
        public let name: String
        /// Version of the software.
        public let firmware: Int
        /// Date of the last upgrade.
        public let lastUpgradeDate: Date
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
        public let place: NetatmoManager.Place
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
            case setupDate = "date_setup"
            case lastSetupDate = "last_setup"
            case type
            case lastStatusStoreDate = "last_status_store"
            case name = "module_name"
            case firmware
            case lastUpgradeDate = "last_upgrade"
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
        
        // MARK: - Init
        
        public init(identifier: String, setupDate: Date, lastSetupDate: Date, type: String, lastStatusStoreDate: Date, name: String, firmware: Int, lastUpgradeDate: Date, wifiStatus: Int, reachable: Bool, co2Calibrating: Bool, stationName: String, dataType: [String], place: NetatmoManager.Place, readOnly: Bool? = nil, dashboard: Dashboard, modules: [Module]) {
            
            self.identifier = identifier
            self.setupDate = setupDate
            self.lastSetupDate = lastSetupDate
            self.type = type
            self.lastStatusStoreDate = lastStatusStoreDate
            self.name = name
            self.firmware = firmware
            self.lastUpgradeDate = lastUpgradeDate
            self.wifiStatus = wifiStatus
            self.reachable = reachable
            self.co2Calibrating = co2Calibrating
            self.stationName = stationName
            self.dataType = dataType
            self.place = place
            self.readOnly = readOnly
            self.dashboard = dashboard
            self.modules = modules
        }
        
    }
    
}
