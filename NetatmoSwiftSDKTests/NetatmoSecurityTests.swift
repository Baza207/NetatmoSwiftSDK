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
                case .success(let events):
                    XCTAssertNotNil(events)
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
                case .success(let events):
                    XCTAssertNotNil(events)
                case .failure(let error):
                    XCTFail(error.localizedDescription)
                }
                
                try? NetatmoManager.logout()
                
                expectation.fulfill()
            }
        }
        
        waitForExpectations(timeout: 30)
    }
    
    func testGetNextEvents() {
        
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
            
            NetatmoSecurity.getNextEvents(homeId: config.homeId, eventId: config.eventId) { (result) in
                
                switch result {
                case .success(let events):
                    XCTAssertNotNil(events)
                case .failure(let error):
                    XCTFail(error.localizedDescription)
                }
                
                try? NetatmoManager.logout()
                
                expectation.fulfill()
            }
        }
        
        waitForExpectations(timeout: 30)
    }
    
    func testGetFaceCameraPicture() {
        
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
            
            NetatmoSecurity.getCameraPicture(imageId: config.faceId, key: config.faceKey) { (result) in
                
                switch result {
                case .success(let data):
                    XCTAssertNotNil(data)
                case .failure(let error):
                    XCTFail(error.localizedDescription)
                }
                
                try? NetatmoManager.logout()
                
                expectation.fulfill()
            }
        }
        
        waitForExpectations(timeout: 30)
    }
    
    func testGetFaceCameraUIImage() {
        
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
            
            NetatmoSecurity.getCameraUIImage(imageId: config.faceId, key: config.faceKey) { (result) in
                
                switch result {
                case .success(let image):
                    XCTAssertNotNil(image)
                case .failure(let error):
                    XCTFail(error.localizedDescription)
                }
                
                try? NetatmoManager.logout()
                
                expectation.fulfill()
            }
        }
        
        waitForExpectations(timeout: 30)
    }
    
    func testGetSnapshotCameraPicture() {
        
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
            
            NetatmoSecurity.getCameraPicture(imageId: config.snapshotId, key: config.snapshotKey) { (result) in
                
                switch result {
                case .success(let data):
                    XCTAssertNotNil(data)
                case .failure(let error):
                    XCTFail(error.localizedDescription)
                }
                
                try? NetatmoManager.logout()
                
                expectation.fulfill()
            }
        }
        
        waitForExpectations(timeout: 30)
    }
    
    func testGetSnapshotCameraUIImage() {
        
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
            
            NetatmoSecurity.getCameraUIImage(imageId: config.snapshotId, key: config.snapshotKey) { (result) in
                
                switch result {
                case .success(let image):
                    XCTAssertNotNil(image)
                case .failure(let error):
                    XCTFail(error.localizedDescription)
                }
                
                try? NetatmoManager.logout()
                
                expectation.fulfill()
            }
        }
        
        waitForExpectations(timeout: 30)
    }
    
    func testGetVignetteCameraPicture() {
        
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
            
            NetatmoSecurity.getCameraPicture(imageId: config.vignetteId, key: config.vignetteKey) { (result) in
                
                switch result {
                case .success(let data):
                    XCTAssertNotNil(data)
                case .failure(let error):
                    XCTFail(error.localizedDescription)
                }
                
                try? NetatmoManager.logout()
                
                expectation.fulfill()
            }
        }
        
        waitForExpectations(timeout: 30)
    }
    
    func testGetVignetteCameraUIImage() {
        
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
            
            NetatmoSecurity.getCameraUIImage(imageId: config.vignetteId, key: config.vignetteKey) { (result) in
                
                switch result {
                case .success(let image):
                    XCTAssertNotNil(image)
                case .failure(let error):
                    XCTFail(error.localizedDescription)
                }
                
                try? NetatmoManager.logout()
                
                expectation.fulfill()
            }
        }
        
        waitForExpectations(timeout: 30)
    }
    
    func testSetPersonAway() {
        
        guard let config = self.config else {
            XCTAssertFalse(true, "Requires a test config to be setup before calling login!")
            return
        }
        
        let expectation = self.expectation(description: #function)
        
        NetatmoManager.login(username: config.username, password: config.password, scope: [.writeCamera]) { (result) in
            
            switch result {
            case .success(let authState):
                XCTAssertTrue(authState == .authorized)
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
            
            NetatmoSecurity.setPersonAway(homeId: config.homeId, personId: config.personId) { (result) in
                
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
    
    func testSetAllPeopleAway() {
        
        guard let config = self.config else {
            XCTAssertFalse(true, "Requires a test config to be setup before calling login!")
            return
        }
        
        let expectation = self.expectation(description: #function)
        
        NetatmoManager.login(username: config.username, password: config.password, scope: [.writeCamera]) { (result) in
            
            switch result {
            case .success(let authState):
                XCTAssertTrue(authState == .authorized)
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
            
            NetatmoSecurity.setPersonAway(homeId: config.homeId) { (result) in
                
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
    
    func testSetPersonHome() {
        
        guard let config = self.config else {
            XCTAssertFalse(true, "Requires a test config to be setup before calling login!")
            return
        }
        
        let expectation = self.expectation(description: #function)
        
        NetatmoManager.login(username: config.username, password: config.password, scope: [.writeCamera]) { (result) in
            
            switch result {
            case .success(let authState):
                XCTAssertTrue(authState == .authorized)
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
            
            NetatmoSecurity.setPersonHome(homeId: config.homeId, personIds: [config.personId]) { (result) in
                
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
    
    func testSetPeopleHome() {
        
        guard let config = self.config else {
            XCTAssertFalse(true, "Requires a test config to be setup before calling login!")
            return
        }
        
        let expectation = self.expectation(description: #function)
        
        NetatmoManager.login(username: config.username, password: config.password, scope: [.writeCamera]) { (result) in
            
            switch result {
            case .success(let authState):
                XCTAssertTrue(authState == .authorized)
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
            
            NetatmoSecurity.setPersonHome(homeId: config.homeId, personIds: [config.personId, config.personId2]) { (result) in
                
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
