//
//  User.swift
//  NetatmoSwiftSDK
//
//  Created by James Barrow on 2019-10-23.
//  Copyright © 2019 Pig on a Hill Productions. All rights reserved.
//

import Foundation

public extension NetatmoWeather {
    
    struct User: Decodable, CustomStringConvertible {
        
        // MARK: - Properties
        
        public let mail: String
        public let administrative: Administrative
        
        public var description: String {
            "User(mail: \(mail), administrative: \(administrative))"
        }
        
        // MARK: - Init
        
        public init(mail: String, administrative: Administrative) {
            
            self.mail = mail
            self.administrative = administrative
        }
        
    }
    
}
