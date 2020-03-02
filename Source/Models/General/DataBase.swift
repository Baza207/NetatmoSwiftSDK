//
//  DataBase.swift
//  NetatmoSwiftSDK
//
//  Created by James Barrow on 2020-02-28.
//  Copyright © 2020 Pig on a Hill Productions. All rights reserved.
//

import Foundation

public extension NetatmoManager {
    
    struct DataBase: Decodable, CustomStringConvertible {
        
        // MARK: - Properties
        
        /// The status of the result.
        public let status: String?
        /// The error if the request errors.
        internal let error: NetatmoManager.RequestError?
        
        public var description: String {
            if let status = self.status {
                return "DataBase(status: \(status))"
            } else if let error = self.error {
                return "DataBase(errorCode: \(error.code), body: \(error.message))"
            }
            return "DataBase()"
        }
        
    }
    
}
