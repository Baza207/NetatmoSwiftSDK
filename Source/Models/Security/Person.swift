//
//  Person.swift
//  NetatmoSwiftSDK
//
//  Created by James Barrow on 2020-02-27.
//  Copyright © 2020 Pig on a Hill Productions. All rights reserved.
//

import Foundation

public extension NetatmoSecurity {
    
    struct Person: Decodable, CustomStringConvertible {
        
        // MARK: - Properties
        
        public let identifier: String
        public let lastSeenDate: Date
        public let outOfSight: Bool
        public let face: Face
        /// If pseudo is missing, the person is unknown
        public let pseudo: String?
        public var isKnown: Bool { pseudo != nil }
        
        public var description: String {
            "Person(identifier: \(identifier), lastSeenDate: \(lastSeenDate), outOfSight: \(outOfSight), face: \(face), pseudo: \(pseudo ?? "Unknown"))"
        }
        
        // MARK: - Coding
        
        private enum CodingKeys: String, CodingKey {
            case identifier = "id"
            case lastSeenDate = "last_seen"
            case outOfSight = "out_of_sight"
            case face
            case pseudo
        }
        
        // MARK: - Init
        
        public init(identifier: String, lastSeenDate: Date, outOfSight: Bool, face: Face, pseudo: String? = nil) {
            
            self.identifier = identifier
            self.lastSeenDate = lastSeenDate
            self.outOfSight = outOfSight
            self.face = face
            self.pseudo = pseudo
        }
        
    }
    
}
