//
//  WeatherStationResult.swift
//  NetatmoSwiftAPI
//
//  Created by James Barrow on 2019-10-23.
//  Copyright © 2019 Pig on a Hill Productions. All rights reserved.
//

import Foundation

public struct WeatherStationResult: Decodable {
    public let user: User
    public let devices: [DeviceResult]
}
