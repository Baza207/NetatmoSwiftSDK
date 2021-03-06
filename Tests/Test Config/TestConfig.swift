//
//  TestConfig.swift
//  NetatmoSwiftSDKTests
//
//  Created by James Barrow on 2020-02-11.
//  Copyright © 2020 Pig on a Hill Productions. All rights reserved.
//

import Foundation

private class TestConfigBundleClass { }

struct TestConfig: Decodable {
    
    // MARK: - Properties
    
    let clientId: String
    let clientSecret: String
    let username: String
    let password: String
    let redirectURI: String
    let homeId: String
    let eventId: String
    let personId: String
    let personId2: String
    let faceId: String
    let faceKey: String
    let snapshotId: String
    let snapshotKey: String
    let vignetteId: String
    let vignetteKey: String
    let neLatitude: Double
    let neLongitude: Double
    let swLatitude: Double
    let swLongitude: Double
    let weatherDeviceId: String
    
    static func load(_ overrideUrl: URL? = nil) throws -> TestConfig? {
        
        let url: URL
        if let overrideUrl = overrideUrl {
            url = overrideUrl
        } else if let defaultUrl = Bundle(for: TestConfigBundleClass.self).url(forResource: "TestConfig", withExtension: "json") {
            url = defaultUrl
        } else {
            return nil
        }
        
        let data = try Data(contentsOf: url)
        
        let decoder = JSONDecoder()
        return try decoder.decode(TestConfig.self, from: data)
    }
    
}
