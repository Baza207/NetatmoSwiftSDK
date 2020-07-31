//
//  EnergyModule.swift
//  NetatmoSwiftSDK
//
//  Created by James Barrow on 2020-07-31.
//  Copyright © 2020 Pig on a Hill Productions. All rights reserved.
//

import Foundation

public extension NetatmoEnergy {
    
    struct Module: Decodable, CustomStringConvertible {
        
        // MARK: - Properties
        
        public let identifier: String
        private let rawType: String
        public var type: ProductType { ProductType(rawValue: rawType) }
        public let name: String?
        public let setupDate: Date?
        private let rawModuleBridged: [String]?
        public var moduleBridged: [String] { rawModuleBridged ?? [] }
        
        public var description: String {
            "Module(identifier: \(identifier)), type: \(type), moduleBridged: \(moduleBridged))"
        }
        
        // MARK: - Coding
        
        private enum CodingKeys: String, CodingKey {
            case identifier = "id"
            case rawType = "type"
            case name
            case setupDate = "setup_date"
            case rawModuleBridged = "module_bridged"
        }
        
        // MARK: - Init
        
        public init(identifier: String, type: ProductType, name: String? = nil, setupDate: Date? = nil, moduleBridged: [String] = []) {
            
            self.identifier = identifier
            self.rawType = type.rawValue
            self.name = name
            self.setupDate = setupDate
            self.rawModuleBridged = moduleBridged
        }
        
    }
    
}
