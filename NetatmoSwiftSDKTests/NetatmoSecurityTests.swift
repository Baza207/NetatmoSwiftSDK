//
//  NetatmoSecurityTests.swift
//  NetatmoSwiftSDKTests
//
//  Created by James Barrow on 2020-02-24.
//  Copyright © 2020 Pig on a Hill Productions. All rights reserved.
//

import XCTest
@testable import NetatmoSwiftSDK

class NetatmoSecurityTests: XCTestCase {
    
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
        
        let scope: [AuthScope] = [.readCamera, .accessCamera, .readPresence, .accessPresence, .readSmokeDetector]
        NetatmoManager.login(username: config.username, password: config.password, scope: scope) { (result) in
            
            switch result {
            case .success(let authState):
                XCTAssertTrue(authState == .authorized)
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
            
            NetatmoSecurity.getHomeData { (result) in
                
                switch result {
                case .success:
                    XCTAssertTrue(true)
                case .failure(let error):
                    XCTFail(error.localizedDescription)
                }
                
                try? NetatmoManager.logout()
                
                expectation.fulfill()
            }
        }
        
        waitForExpectations(timeout: 30)
    }
    
    func testGetEventsUntil() {
        
        guard let config = self.config else {
            XCTAssertFalse(true, "Requires a test config to be setup before calling login!")
            return
        }
        
        let expectation = self.expectation(description: #function)
        
        let scope: [AuthScope] = [.readCamera, .accessCamera, .readPresence, .accessPresence, .readSmokeDetector]
        NetatmoManager.login(username: config.username, password: config.password, scope: scope) { (result) in
            
            switch result {
            case .success(let authState):
                XCTAssertTrue(authState == .authorized)
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
            
            NetatmoSecurity.getEventsUntil(homeId: config.homeId, eventId: config.eventId) { (result) in
                
                switch result {
                case .success:
                    XCTAssertTrue(true)
                case .failure(let error):
                    XCTFail(error.localizedDescription)
                }
                
                try? NetatmoManager.logout()
                
                expectation.fulfill()
            }
        }
        
        waitForExpectations(timeout: 30)
    }
    
    func testGetLatestEventsOfPerson() {
        
        guard let config = self.config else {
            XCTAssertFalse(true, "Requires a test config to be setup before calling login!")
            return
        }
        
        let expectation = self.expectation(description: #function)
        
        let scope: [AuthScope] = [.readCamera, .accessCamera, .readPresence, .accessPresence, .readSmokeDetector]
        NetatmoManager.login(username: config.username, password: config.password, scope: scope) { (result) in
            
            switch result {
            case .success(let authState):
                XCTAssertTrue(authState == .authorized)
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
            
            NetatmoSecurity.getLatestEventsOfPerson(homeId: config.homeId, personId: config.personId) { (result) in
                
                switch result {
                case .success:
                    XCTAssertTrue(true)
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
