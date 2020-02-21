//
//  StationMeasure.swift
//  NetatmoSwiftAPI
//
//  Created by James Barrow on 2020-02-19.
//  Copyright © 2020 Pig on a Hill Productions. All rights reserved.
//

import Foundation

public extension Weather {
    
    struct StationMeasureBase: Decodable, CustomStringConvertible {
        
        // MARK: - Properties
        
        /// The body of the result.
        public let body: [StationMeasure]
        /// The status of the result.
        public let status: String
        
        public var description: String {
            "StationMeasureBase(status: \(status), body: \(body))"
        }
        
    }
    
    struct StationMeasure: Decodable, CustomStringConvertible {
        
        // MARK: - Properties
        
        internal let beginTime: TimeInterval // UTC
        /// The begining date of the mesurements.
        public var beginDate: Date { Date(timeIntervalSince1970: beginTime) }
        /// The step interval between measurements.
        public let stepTimeInterval: TimeInterval
        /// The values of the mesurements.
        public let values: [[Double]]
        
        public var description: String {
            "StationMeasure(beginDate: \(beginDate), stepTimeInterval: \(stepTimeInterval), values: \(values))"
        }
        
        // MARK: - Coding
        
        private enum CodingKeys: String, CodingKey {
            case beginTime = "beg_time"
            case stepTimeInterval = "step_time"
            case values = "value"
        }
    }
    
}
