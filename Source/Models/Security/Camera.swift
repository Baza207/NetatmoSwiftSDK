//
//  Camera.swift
//  NetatmoSwiftSDK
//
//  Created by James Barrow on 2020-02-27.
//  Copyright © 2020 Pig on a Hill Productions. All rights reserved.
//

import Foundation

public extension NetatmoSecurity {
    
    struct Camera: Decodable, CustomStringConvertible {
        
        // MARK: - Properties
        
        public let identifier: String
        private let rawType: String
        public var type: ProductType { ProductType(rawValue: rawType) }
        public let status: String
        public let vpnURL: String?
        public let isLocal: Bool
        public let sdCardStatus: String
        public let alimStatus: String
        public let name: String
        private let rawModules: [Module]?
        public var modules: [Module] { rawModules ?? [] }
        private let rawUsePinCode: Bool?
        public var usePinCode: Bool { rawUsePinCode ?? false }
        public let lastSetupDate: Date
        
        public var description: String {
            "Camera(identifier: \(identifier), type: \(type), status: \(status), isLocal: \(isLocal), sdCardStatus: \(sdCardStatus), alimentationStatus: \(alimStatus), name: \(name), modules: \(modules), usePinCode: \(usePinCode), lastSetupDate: \(lastSetupDate))"
        }
        
        // MARK: - Coding
        
        private enum CodingKeys: String, CodingKey {
            case identifier = "id"
            case rawType = "type"
            case status
            case vpnURL = "vpn_url"
            case isLocal = "is_local"
            case sdCardStatus = "sd_status"
            case alimStatus = "alim_status"
            case name
            case rawModules = "modules"
            case rawUsePinCode = "use_pin_code"
            case lastSetupDate = "last_setup"
        }
        
        // MARK: - Init
        
        public init(identifier: String, type: ProductType, status: String, vpnURL: String? = nil, isLocal: Bool, sdCardStatus: String, alimStatus: String, name: String, modules: [Module]? = nil, usePinCode: Bool, lastSetupDate: Date) {
            
            self.identifier = identifier
            self.rawType = type.rawValue
            self.status = status
            self.vpnURL = vpnURL
            self.isLocal = isLocal
            self.sdCardStatus = sdCardStatus
            self.alimStatus = alimStatus
            self.name = name
            self.rawModules = modules
            self.rawUsePinCode = usePinCode
            self.lastSetupDate = lastSetupDate
        }
        
    }
    
}
