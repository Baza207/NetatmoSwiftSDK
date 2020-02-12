//
//  NetatmoManagerTests.swift
//  NetatmoSwiftAPITests
//
//  Created by James Barrow on 2020-02-11.
//  Copyright © 2020 Pig on a Hill Productions. All rights reserved.
//

import XCTest
@testable import NetatmoSwiftAPI

class NetatmoManagerTests: XCTestCase {
    
    var config = try? TestConfig.load()
    
    override func setUp() {
        
        guard let config = config else {
            return
        }
        NetatmoManager.configure(clientId: config.clientId, clientSecret: config.clientSecret, redirectURI: config.redirectURI)
    }
    
    func testLogin() {
        
        guard let config = self.config else {
            XCTAssertFalse(true, "Requires a test config to be setup before calling login!")
            return
        }
        
        let expectation = self.expectation(description: #function)
        var accessToken: String?
        var resultError: Error?
        
        NetatmoManager.shared.login(username: config.username, password: config.password) { (result) in
            
            switch result {
            case .success(let authResult):
                print(authResult)
                accessToken = authResult.accessToken
            case .failure(let error):
                resultError = error
            }
            
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 10)
        XCTAssertNotNil(accessToken, resultError?.localizedDescription ?? "A successfuly logged in manager should have an access token!")
    }
    
}
