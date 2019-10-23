//
//  BaseResult.swift
//  NetatmoSwiftAPI
//
//  Created by James Barrow on 2019-10-23.
//  Copyright © 2019 Pig on a Hill Productions. All rights reserved.
//

import Foundation

public struct BaseResult: Decodable {
    public let body: WeatherStationResult
    public let status: String
}
