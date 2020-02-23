//
//  SecurityAPI.swift
//  NetatmoSwiftAPI
//
//  Created by James Barrow on 2020-02-23.
//  Copyright © 2020 Pig on a Hill Productions. All rights reserved.
//

import Foundation

public extension NetatmoManager {
    
    /// Retrieve user's homes and their topology.
    ///
    /// Scope required: `read_camera`, `acces_camera`, `read_presence`, `access_presence` and `read_smokedetector`.
    ///
    func getHomeData(homeId: String? = nil, numberOfEvents size: Int? = nil, completed: @escaping (Result<[Any], Error>) -> Void) {
        
    }
    
    private static func getHomeData(accessToken: String, url: URL, completed: @escaping (Result<[Any], Error>) -> Void) {
        
    }
    
    /// Returns all the events until the one specified in the request.
    ///
    /// Scope required: `read_camera`, `acces_camera`, `read_presence`, `access_presence` and `read_smokedetector`.
    ///
    ///  - Note: This method is available for Welcome (Indoor Camera), Presence (Outdoor Camera) and the Smart Smoke Alarm
    ///
    func getEventsUntil(homeId: String, eventId: String, completed: @escaping (Result<[Any], Error>) -> Void) {
        
    }
    
    private static func getEventsUntil(accessToken: String, url: URL, completed: @escaping (Result<[Any], Error>) -> Void) {
        
    }
    
    /// Returns most recent events.
    ///
    /// Scope required: `read_camera` and `acces_camera`
    ///
    /// - Note: This method is only available for Welcome (Indoor Camera).
    ///
    func getLatestEventsOfPerson(homeId: String, personId: String, numberOfEvents size: Int? = nil, completed: @escaping (Result<[Any], Error>) -> Void) {
        
    }
    
    private static func getLatestEventsOfPerson(accessToken: String, url: URL, completed: @escaping (Result<[Any], Error>) -> Void) {
        
    }
    
    /// Returns previous events.
    ///
    /// Scope required: `read_camera`, `acces_camera`, `read_presence`, `access_presence` and `read_smokedetector`.
    ///
    /// - Note: This method is available for Welcome (Indoor Camera), Presence (Outdoor Camera) and the Smart Smoke Alarm
    ///
    func getNextEvents(homeId: String, eventId: String, numberOfEvents size: Int? = nil, completed: @escaping (Result<[Any], Error>) -> Void) {
        
    }
    
    private static func getNextEvents(accessToken: String, url: URL, completed: @escaping (Result<[Any], Error>) -> Void) {
        
    }
    
    /// Returns the snapshot associated to an event.
    ///
    /// No scope required.
    ///
    func getCameraPicture(imageId: String, key: String, completed: @escaping (Result<[Any], Error>) -> Void) {
        
    }
    
    private static func getCameraPicture(accessToken: String, url: URL, completed: @escaping (Result<[Any], Error>) -> Void) {
        
    }
    
    /// Sets a person as "Away" or the Home as "Empty". The event will be added to the user’s timeline.
    ///
    /// Scope required: `write_camera`.
    ///
    /// - Note: This method is only available for Welcome.
    ///
    func setPersonAway(homeId: String, personId: String? = nil, completed: @escaping (Result<[Any], Error>) -> Void) {
        
    }
    
    private static func setPersonAway(accessToken: String, url: URL, completed: @escaping (Result<[Any], Error>) -> Void) {
        
    }
    
    /// Sets a person or a group of person "at home". The event will be added to the user’s timeline.
    ///
    /// Scope required: `write_camera`.
    ///
    /// - Note: This method is only available for Welcome.
    ///
    func setPersonHome(homeId: String, personIds: [String], completed: @escaping (Result<[Any], Error>) -> Void) {
        
    }
    
    private static func setPersonHome(accessToken: String, url: URL, completed: @escaping (Result<[Any], Error>) -> Void) {
        
    }
    
}
