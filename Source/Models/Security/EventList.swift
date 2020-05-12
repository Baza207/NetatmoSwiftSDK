//
//  EventList.swift
//  NetatmoSwiftSDK
//
//  Created by James Barrow on 2020-02-27.
//  Copyright © 2020 Pig on a Hill Productions. All rights reserved.
//

import Foundation

public extension NetatmoSecurity {
    
    struct EventListBase: Decodable, CustomStringConvertible {
        
        // MARK: - Properties
        
        /// The body of the result.
        public let body: EventList?
        /// The status of the result.
        public let status: String?
        /// The error if the request errors.
        internal let error: NetatmoManager.RequestError?
        
        public var description: String {
            if let status = self.status, let body = self.body {
                return "EventListBase(status: \(status), body: \(body))"
            } else if let error = self.error {
                return "EventListBase(errorCode: \(error.code), body: \(error.message))"
            }
            return "EventListBase()"
        }
        
    }
    
    struct EventList: Decodable, CustomStringConvertible {
        
        // MARK: - Properties
        
        public let eventsList: [Event]
        
        public var description: String {
            "EventList(eventsList: \(eventsList))"
        }
        
        // MARK: - Coding
        
        private enum CodingKeys: String, CodingKey {
            case eventsList = "events_list"
        }
        
        // MARK: - Init
        
        public init(eventsList: [Event]) {
            
            self.eventsList = eventsList
        }
        
    }
    
}
