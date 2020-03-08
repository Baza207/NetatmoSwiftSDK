//
//  PublicData.swift
//  NetatmoSwiftSDK
//
//  Created by James Barrow on 2020-02-19.
//  Copyright © 2020 Pig on a Hill Productions. All rights reserved.
//

import Foundation

public extension NetatmoWeather {
    
    struct PublicDataBase: Decodable, CustomStringConvertible {
        
        // MARK: - Properties
        
        /// The body of the result.
        public let body: [PublicData]?
        /// The status of the result.
        public let status: String?
        /// The error if the request errors.
        internal let error: NetatmoManager.RequestError?
        
        public var description: String {
            if let status = self.status, let body = self.body {
                return "PublicDataBase(status: \(status), body: \(body))"
            } else if let error = self.error {
                return "PublicDataBase(errorCode: \(error.code), body: \(error.message))"
            }
            return "PublicDataBase()"
        }
        
    }
    
    struct PublicData: Decodable, CustomStringConvertible {
        
        // MARK: - Properties
        
        /// MAC address of the device.
        public let identifier: String
        /// Describes the place where the weather station is.
        public let place: NetatmoManager.Place
        public let mark: Int
        public let measures: [String: Measure]
        public let modules: [String]
        public let moduleTypes: [String: String]
        
        public var description: String {
            "PublicData(identifier: \(identifier), place: \(place), mark: \(mark), measures: \(measures), modules: \(modules), moduleTypes: \(moduleTypes))"
        }
        
        // MARK: - Coding
        
        private enum CodingKeys: String, CodingKey {
            case identifier = "_id"
            case place
            case mark
            case measures
            case modules
            case moduleTypes = "module_types"
        }
    }
    
}
