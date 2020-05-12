//
//  NetatmoManagerTests.swift
//  NetatmoSwiftSDKTests
//
//  Created by James Barrow on 2020-02-11.
//  Copyright © 2020 Pig on a Hill Productions. All rights reserved.
//

import XCTest
@testable import NetatmoSwiftSDK

class NetatmoManagerTests: XCTestCase {
    
    var config = try? TestConfig.load()
    
    override func setUp() {
        
        guard let config = config else {
            return
        }
        NetatmoManager.configure(clientId: config.clientId, clientSecret: config.clientSecret, redirectURI: config.redirectURI)
    }
    
    func testUnauthedListener() {
        
        let expectation = self.expectation(description: #function)
        
        let listener = NetatmoManager.addAuthStateDidChangeListener { (authState) in
            
            switch authState {
            case .unauthorized:
                XCTAssertTrue(authState == .unauthorized)
                expectation.fulfill()
            default:
                break
            }
        }
        
        waitForExpectations(timeout: 30) { (error) in
            
            XCTAssertNil(error, error?.localizedDescription ?? "")
            NetatmoManager.removeAuthStateDidChangeListener(with: listener)
        }
    }
    
    func testLogin() {
        
        guard let config = self.config else {
            XCTAssertFalse(true, "Requires a test config to be setup before calling login!")
            return
        }
        
        let expectation = self.expectation(description: #function)
        
        NetatmoManager.login(username: config.username, password: config.password) { (result) in
            
            switch result {
            case .success(let authState):
                XCTAssertTrue(authState == .authorized)
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
            
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 30)
    }
    
}
