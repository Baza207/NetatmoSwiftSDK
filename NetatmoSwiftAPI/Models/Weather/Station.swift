//
//  Station.swift
//  NetatmoSwiftAPI
//
//  Created by James Barrow on 2019-10-23.
//  Copyright © 2019 Pig on a Hill Productions. All rights reserved.
//

import Foundation

public extension NetatmoWeather {
    
    struct StationBase: Decodable, CustomStringConvertible {
        
        // MARK: - Properties
        
        /// The body of the result.
        public let body: Station?
        /// The status of the result.
        public let status: String?
        /// The error if the request errors.
        internal let error: NetatmoManager.RequestError?
        
        public var description: String {
            if let status = self.status, let body = self.body {
                return "StationBase(status: \(status), body: \(body))"
            } else if let error = self.error {
                return "StationBase(errorCode: \(error.code), body: \(error.message))"
            }
            return "StationBase()"
        }
        
    }
    
    struct Station: Decodable, CustomStringConvertible {
        
        // MARK: - Properties
        
        /// The user of the weather station.
        public let user: User
        /// The devices part of the weather station.
        public let devices: [Device]
        
        public var description: String {
            "Station(user: \(user), devices: \(devices))"
        }
    }
    
}
