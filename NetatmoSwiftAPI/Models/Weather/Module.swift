//
//  Module.swift
//  NetatmoSwiftAPI
//
//  Created by James Barrow on 2019-10-23.
//  Copyright © 2019 Pig on a Hill Productions. All rights reserved.
//

import Foundation

public extension Weather {
    
    struct Module: Decodable, CustomStringConvertible {
        
        // MARK: - Properties
        
        /// MAC address of the module.
        public let identifier: String
        /// Type of the device.
        public let type: String
        /// Name of the module.
        public let name: String
        /// Array of data measured by the device (e.g. "Temperature", "Humidity").
        public let dataType: [String]
        private let lastSetup: TimeInterval
        /// Date of the last installation.
        public var lastSetupDate: Date { Date(timeIntervalSince1970: lastSetup) }
        /// `true` if the station connected to Netatmo cloud within the last 4 hours.
        public let reachable: Bool
        /// Version of the software.
        public let firmware: Int
        private let lastMessage: TimeInterval
        /// Date of the last measure update.
        public var lastMessageDate: Date { Date(timeIntervalSince1970: lastMessage) }
        private let lastSeen: TimeInterval
        /// Date of the last status update.
        public var lastSeenDate: Date { Date(timeIntervalSince1970: lastSeen) }
        /// Current radio status per module. (90=low, 60=highest).
        public let rfStatus: Int
        /// Current battery status per module/
        public let batteryVp: Int
        /// Percentage of battery remaining (10=low).
        public let batteryPercent: Int
        public let dashboard: Dashboard
        
        public var description: String {
            "Module(name: \(name), dashboard: \(dashboard))"
        }
        
        // MARK: - Coding
        
        private enum CodingKeys: String, CodingKey {
            case identifier = "_id"
            case type
            case name = "module_name"
            case dataType = "data_type"
            case lastSetup = "last_setup"
            case reachable
            case firmware
            case lastMessage = "last_message"
            case lastSeen = "last_seen"
            case rfStatus = "rf_status"
            case batteryVp = "battery_vp"
            case batteryPercent = "battery_percent"
            case dashboard = "dashboard_data"
        }
    }
}
