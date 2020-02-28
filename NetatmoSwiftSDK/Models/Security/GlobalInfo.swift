//
//  GlobalInfo.swift
//  NetatmoSwiftSDK
//
//  Created by James Barrow on 2020-02-27.
//  Copyright © 2020 Pig on a Hill Productions. All rights reserved.
//

import Foundation

public extension NetatmoSecurity {
    
    struct GlobalInfo: Decodable, CustomStringConvertible {
        
        // MARK: - Properties
        
        public let showTags: Bool
        
        public var description: String {
            "GlobalInfo(showTags: \(showTags))"
        }
        
        // MARK: - Coding
        
        private enum CodingKeys: String, CodingKey {
            case showTags = "show_tags"
        }
    }
    
}
