//
//  Timetable.swift
//  NetatmoSwiftSDK
//
//  Created by James Barrow on 2020-08-01.
//  Copyright © 2020 Pig on a Hill Productions. All rights reserved.
//

import Foundation

public extension NetatmoEnergy {
    
    struct Timetable: Decodable, CustomStringConvertible {
        
        // MARK: - Properties
        
        /// ID of the zone.
        public let identifier: String
        /// Offset in minutes since Monday 00:00:01.
        public let offset: Int
        public var description: String {
            "Timetable(identifier: \(identifier), offset: \(offset))"
        }
        
        // MARK: - Coding
        
        private enum CodingKeys: String, CodingKey {
            case identifier = "zone_id"
            case offset = "m_offset"
        }
        
        // MARK: - Init
        
        public init(identifier: String, offset: Int) {
            
            self.identifier = identifier
            self.offset = offset
        }
        
    }
    
}
