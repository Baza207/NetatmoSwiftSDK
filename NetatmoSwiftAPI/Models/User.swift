//
//  User.swift
//  NetatmoSwiftAPI
//
//  Created by James Barrow on 2019-10-23.
//  Copyright © 2019 Pig on a Hill Productions. All rights reserved.
//

import Foundation

public struct User: Decodable {
    public let mail: String
    public let administrative: Administrative
}
