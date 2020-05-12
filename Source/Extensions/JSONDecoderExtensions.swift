//
//  JSONDecoderExtensions.swift
//  NetatmoSwiftSDK
//
//  Created by James Barrow on 2020-03-08.
//  Copyright © 2020 Pig on a Hill Productions. All rights reserved.
//

import Foundation

extension JSONDecoder {
    
    internal static var secondsSince1970JSONDecoder: JSONDecoder {
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970
        return decoder
    }
    
}
