//
//  DeviceResult.swift
//  NetatmoSwiftAPI
//
//  Created by James Barrow on 2019-10-23.
//  Copyright © 2019 Pig on a Hill Productions. All rights reserved.
//

import Foundation

public struct DeviceResult: Decodable, CustomStringConvertible {
    public let identifier: String
    public let type: String
    public let moduleName: String
    public let firmware: Int
    public let wifiStatus: Int
    public let reachable: Bool
    public let co2Calibrating: Bool
    public let stationName: String
    public let dataType: [String]
    public let dashboardData: DashboardData
    public let modules: [ModuleData]
    public var description: String {
        "<DeviceResult - \(moduleName) - \(stationName) - \(dashboardData) - \(modules)>"
    }
    
    private enum CodingKeys: String, CodingKey {
        case identifier = "_id"
        case type
        case moduleName = "module_name"
        case firmware
        case wifiStatus = "wifi_status"
        case reachable
        case co2Calibrating = "co2_calibrating"
        case stationName = "station_name"
        case dataType = "data_type"
        case dashboardData = "dashboard_data"
        case modules
    }
}
