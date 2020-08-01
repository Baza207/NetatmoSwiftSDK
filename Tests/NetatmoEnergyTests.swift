//
//  NetatmoEnergyTests.swift
//  NetatmoSwiftSDKTests
//
//  Created by James Barrow on 2020-08-01.
//  Copyright © 2020 Pig on a Hill Productions. All rights reserved.
//

import XCTest
@testable import NetatmoSwiftSDK

class NetatmoEnergyTests: XCTestCase {
    
    var config = try? TestConfig.load()
    
    override func setUp() {
        
        guard let config = config else {
            return
        }
        NetatmoManager.configure(clientId: config.clientId, clientSecret: config.clientSecret, redirectURI: config.redirectURI)
    }
    
    func testGetHomeData() {
        
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
            
            NetatmoEnergy.getHomeData(homeId: config.homeId) { (result) in
                
                switch result {
                case .success(let homeData):
                    XCTAssertNotNil(homeData)
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
