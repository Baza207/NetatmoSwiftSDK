//
//  Module.swift
//  NetatmoSwiftSDK
//
//  Created by James Barrow on 2020-02-27.
//  Copyright © 2020 Pig on a Hill Productions. All rights reserved.
//

import Foundation

public extension NetatmoSecurity {
    
    struct Module: Decodable, CustomStringConvertible {
        
        // MARK: - Properties
        
        public let identifier: String
        private let rawType: String
        public var type: ProductType { ProductType(rawValue: rawType) }
        public let batteryPercent: Int
        public let rfStatus: Int
        public let status: String
        public let monitoring: String?
        public let alimSource: String?
        private let rawTamperDetectionEnabled: Bool?
        public var tamperDetectionEnabled: Bool { rawTamperDetectionEnabled ?? false }
        public let name: String?
        public let category: String?
        public let room: String?
        public let lastActivityDate: Date?
        
        public var description: String {
            var description = "Module(identifier: \(identifier)), type: \(type), batteryPercent: \(batteryPercent), rfStatus: \(rfStatus), status: \(status)"
            
            if let monitoring = self.monitoring {
                description += ", monitoring: \(monitoring)"
            }
            
            if let alimSource = self.alimSource {
                description += ", alimSource: \(alimSource)"
            }
            
            description += ", tamperDetectionEnabled: \(tamperDetectionEnabled)"
            
            if let name = self.name {
                description += ", name: \(name)"
            }
            
            if let category = self.category {
                description += ", category: \(category)"
            }
            
            if let room = self.room {
                description += ", room: \(room)"
            }
            
            if let lastActivityDate = self.lastActivityDate {
                description += ", lastActivityDate: \(lastActivityDate)"
            }
            
            return description + ")"
        }
        
        // MARK: - Coding
        
        private enum CodingKeys: String, CodingKey {
            case identifier = "id"
            case rawType = "type"
            case batteryPercent = "battery_percent"
            case rfStatus = "rf"
            case status
            case monitoring
            case alimSource = "alim_source"
            case rawTamperDetectionEnabled = "tamper_detection_enabled"
            case name
            case category
            case room
            case lastActivityDate = "last_activity"
        }
        
        // MARK: - Init
        
        init(identifier: String, type: ProductType, batteryPercent: Int, rfStatus: Int, status: String, monitoring: String? = nil, alimSource: String? = nil, tamperDetectionEnabled: Bool, name: String? = nil, category: String? = nil, room: String? = nil, lastActivityDate: Date? = nil) {
            
            self.identifier = identifier
            self.rawType = type.rawValue
            self.batteryPercent = batteryPercent
            self.rfStatus = rfStatus
            self.status = status
            self.monitoring = monitoring
            self.alimSource = alimSource
            self.rawTamperDetectionEnabled = tamperDetectionEnabled
            self.name = name
            self.category = category
            self.room = room
            self.lastActivityDate = lastActivityDate
        }
        
    }
    
}
