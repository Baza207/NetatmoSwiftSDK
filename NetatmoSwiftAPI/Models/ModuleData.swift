//
//  ModuleData.swift
//  NetatmoSwiftAPI
//
//  Created by James Barrow on 2019-10-23.
//  Copyright © 2019 Pig on a Hill Productions. All rights reserved.
//

import Foundation

public struct ModuleData: Decodable {
    public let identifier: String
    public let type: String
    public let moduleName: String
    public let dataType: [String]
    public let batteryPercent: Int
    public let reachable: Bool
    public let firmware: Int
    private let lastSeen: TimeInterval
    public var lastSeenDate: Date { Date(timeIntervalSince1970: lastSeen) }
    public let rfStatus: Int
    public let batteryVp: Int
    public let dashboardData: DashboardData
    
    private enum CodingKeys: String, CodingKey {
        case identifier = "_id"
        case type
        case moduleName = "module_name"
        case dataType = "data_type"
        case batteryPercent = "battery_percent"
        case reachable
        case firmware
        case lastSeen = "last_seen"
        case rfStatus = "rf_status"
        case batteryVp = "battery_vp"
        case dashboardData = "dashboard_data"
    }
}
