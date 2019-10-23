//
//  Administrative.swift
//  NetatmoSwiftAPI
//
//  Created by James Barrow on 2019-10-23.
//  Copyright © 2019 Pig on a Hill Productions. All rights reserved.
//

import Foundation

public struct Administrative: Decodable {
    public let languageCode: String
    public let localeCode: String
    public let unit: Int
    public let windUnit: Int
    public let pressureUnit: Int
    public let feelsLikeAlgorithm: Int
    
    private enum CodingKeys: String, CodingKey {
        case languageCode = "lang"
        case localeCode = "reg_locale"
        case unit
        case windUnit = "windunit"
        case pressureUnit = "pressureunit"
        case feelsLikeAlgorithm = "feel_like_algo"
    }
}
