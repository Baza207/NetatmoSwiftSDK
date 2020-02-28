//
//  HomeData.swift
//  NetatmoSwiftSDK
//
//  Created by James Barrow on 2020-02-24.
//  Copyright © 2020 Pig on a Hill Productions. All rights reserved.
//

import Foundation

public extension NetatmoSecurity {
    
    struct HomeDataBase: Decodable, CustomStringConvertible {
        
        // MARK: - Properties
        
        /// The body of the result.
        public let body: HomeData?
        /// The status of the result.
        public let status: String?
        /// The error if the request errors.
        internal let error: NetatmoManager.RequestError?
        
        public var description: String {
            if let status = self.status, let body = self.body {
                return "HomeDataBase(status: \(status), body: \(body))"
            } else if let error = self.error {
                return "HomeDataBase(errorCode: \(error.code), body: \(error.message))"
            }
            return "HomeDataBase()"
        }
        
    }
    
    struct HomeData: Decodable, CustomStringConvertible {
        
        // MARK: - Properties
        
        public let homes: [Home]
        public let user: User
        public let globalInfo: GlobalInfo
        
        public var description: String {
            "HomeData(homes: \(homes), user: \(user), globalInfo: \(globalInfo))"
        }
        
        // MARK: - Coding
        
        private enum CodingKeys: String, CodingKey {
            case homes
            case user
            case globalInfo = "global_info"
        }
    }
    
}
