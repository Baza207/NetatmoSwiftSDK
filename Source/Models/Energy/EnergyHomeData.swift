//
//  HomeData.swift
//  NetatmoSwiftSDK
//
//  Created by James Barrow on 2020-07-31.
//  Copyright © 2020 Pig on a Hill Productions. All rights reserved.
//

import Foundation

public extension NetatmoEnergy {
    
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
        
        private let rawHomes: [Home]?
        public var homes: [Home] { rawHomes ?? [] }
        public let user: User
        
        public var description: String {
            "HomeData(homes: \(homes), user: \(user)"
        }
        
        // MARK: - Coding
        
        private enum CodingKeys: String, CodingKey {
            case rawHomes = "homes"
            case user
        }
        
        // MARK: - Init
        
        public init(homes: [Home], user: User) {
            
            self.rawHomes = homes
            self.user = user
        }
        
    }
    
}
