//
//  NetatmoWeatherTests.swift
//  NetatmoSwiftSDKTests
//
//  Created by James Barrow on 2020-02-28.
//  Copyright © 2020 Pig on a Hill Productions. All rights reserved.
//

import XCTest
import CoreLocation
@testable import NetatmoSwiftSDK

class NetatmoWeatherTests: XCTestCase {
    
    var config = try? TestConfig.load()
    
    override func setUp() {
        
        guard let config = config else {
            return
        }
        NetatmoManager.configure(clientId: config.clientId, clientSecret: config.clientSecret, redirectURI: config.redirectURI)
    }
    
    func testGetPublicData() {
        
        guard let config = self.config else {
            XCTAssertFalse(true, "Requires a test config to be setup before calling login!")
            return
        }
        
        let expectation = self.expectation(description: #function)
        
        NetatmoManager.login(username: config.username, password: config.password, scope: []) { (result) in
            
            switch result {
            case .success(let authState):
                XCTAssertTrue(authState == .authorized)
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
            
            let ne = CLLocationCoordinate2D(latitude: config.neLatitude, longitude: config.neLongitude)
            let sw = CLLocationCoordinate2D(latitude: config.swLatitude, longitude: config.swLongitude)
            NetatmoWeather.fetchPublicData(northEast: ne, southWest: sw) { (result) in
                
                switch result {
                case .success(let publicData):
                    XCTAssertNotNil(publicData)
                case .failure(let error):
                    XCTFail(error.localizedDescription)
                }
                
                try? NetatmoManager.logout()
                
                expectation.fulfill()
            }
        }
        
        waitForExpectations(timeout: 30)
    }
    
    func testGetWeatherStationData() {
        
        guard let config = self.config else {
            XCTAssertFalse(true, "Requires a test config to be setup before calling login!")
            return
        }
        
        let expectation = self.expectation(description: #function)
        
        let scope: [AuthScope] = [.readStation]
        NetatmoManager.login(username: config.username, password: config.password, scope: scope) { (result) in
            
            switch result {
            case .success(let authState):
                XCTAssertTrue(authState == .authorized)
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
            
            NetatmoWeather.fetchWeatherStationData { (result) in
                
                switch result {
                case .success(let stationData):
                    XCTAssertNotNil(stationData)
                case .failure(let error):
                    XCTFail(error.localizedDescription)
                }
                
                try? NetatmoManager.logout()
                
                expectation.fulfill()
            }
        }
        
        waitForExpectations(timeout: 30)
    }
    
    func testGetMeasure() {
        
        guard let config = self.config else {
            XCTAssertFalse(true, "Requires a test config to be setup before calling login!")
            return
        }
        
        let expectation = self.expectation(description: #function)
        
        let scope: [AuthScope] = [.readStation]
        NetatmoManager.login(username: config.username, password: config.password, scope: scope) { (result) in
            
            switch result {
            case .success(let authState):
                XCTAssertTrue(authState == .authorized)
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
            
            NetatmoWeather.fetchMeasure(deviceId: config.weatherDeviceId, scale: .thirtyMin, type: .temperature, limit: 32) { (result) in
                
                switch result {
                case .success(let measureData):
                    XCTAssertNotNil(measureData)
                case .failure(let error):
                    XCTFail(error.localizedDescription)
                }
                
                try? NetatmoManager.logout()
                
                expectation.fulfill()
            }
        }
        
        waitForExpectations(timeout: 30)
    }
    
}
