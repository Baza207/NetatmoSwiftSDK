//
//  Administrative.swift
//  NetatmoSwiftSDK
//
//  Created by James Barrow on 2019-10-23.
//  Copyright © 2019 Pig on a Hill Productions. All rights reserved.
//

import Foundation

public extension NetatmoWeather {
    
    struct Administrative: Decodable, CustomStringConvertible {
        
        // MARK: - Properties
        
        /// User regional preferences (used for displaying date). E.g. `fr-FR`.
        public let localeCode: String
        /// User locale. E.g. `fr-FR`.
        public let languageCode: String
        /// Country. E.g. `FR`.
        public let country: String?
        /// Metric system or imperial system.
        public let unit: Unit
        /// The unit for wind values.
        public let windUnit: WindUnit
        /// The unit for pressure values.
        public let pressureUnit: PressureUnit
        /// Algorithm used to compute feel like temperature.
        public let feelsLikeAlgorithm: FeelsLikeAlgorithm
        
        public var description: String {
            "Administrative(localeCode: \(localeCode), unit: \(unit), windUnit: \(windUnit), pressureUnit: \(pressureUnit), feelsLikeAlgorithm: \(feelsLikeAlgorithm))"
        }
        
        // MARK: - Coding
        
        private enum CodingKeys: String, CodingKey {
            case localeCode = "reg_locale"
            case languageCode = "lang"
            case country
            case unit
            case windUnit = "windunit"
            case pressureUnit = "pressureunit"
            case feelsLikeAlgorithm = "feel_like_algo"
        }
    }
    
}
