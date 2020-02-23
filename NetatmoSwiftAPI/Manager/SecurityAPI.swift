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
        
        guard let accessToken = self.accessToken, accessToken.isEmpty == false else {
            completed(Result.failure(NetatmoError.noAccessToken))
            return
        }
        
        guard var urlComponents = URLComponents(string: "https://api.netatmo.com/api/gethomedata") else {
            completed(Result.failure(NetatmoError.badURL))
            return
        }
        
        var queryItems = [URLQueryItem]()
        
        if let homeId = homeId {
            queryItems.append(URLQueryItem(name: "home_id", value: homeId))
        }
        
        if let size = size {
            queryItems.append(URLQueryItem(name: "size", value: "\(size)"))
        }
        
        urlComponents.queryItems = queryItems
        
        guard let url = urlComponents.url else {
            completed(Result.failure(NetatmoError.badURL))
            return
        }
        
        guard isValid == false else {
            NetatmoManager.getHomeData(accessToken: accessToken, url: url, completed: completed)
            return
        }
        
        // Attempt tokenn refresh
        refreshToken { (result) in
            
            switch result {
            case .success:
                NetatmoManager.getHomeData(accessToken: accessToken, url: url, completed: completed)
            case .failure(let error):
                completed(Result.failure(error))
            }
        }
    }
    
    private static func getHomeData(accessToken: String, url: URL, completed: @escaping (Result<[Any], Error>) -> Void) {
        
        var urlRequest = URLRequest(url: url)
        urlRequest.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        
        let downloadTask = URLSession.shared.dataTask(with: urlRequest) { (data, _, error) in
            
            if let error = error {
                completed(Result.failure(error))
                return
            }
            
            guard let data = data else {
                completed(Result.failure(NetatmoError.noData))
                return
            }
            
//            let decoder = JSONDecoder()
//            let result: Weather.PublicDataBase?
//            do {
//                result = try decoder.decode(Weather.PublicDataBase.self, from: data)
//            } catch {
//                completed(Result.failure(error))
//                return
//            }
//
//            guard let baseResult = result else {
//                completed(Result.failure(NetatmoError.generalError))
//                return
//            }
//
//            if let body = baseResult.body {
//                completed(Result.success(body))
//            } else if let error = baseResult.error {
//                completed(Result.failure(NetatmoError.error(code: error.code, message: error.message)))
//            } else {
//                completed(Result.failure(NetatmoError.noData))
//            }
        }
        downloadTask.resume()
    }
    
    /// Returns all the events until the one specified in the request.
    ///
    /// Scope required: `read_camera`, `acces_camera`, `read_presence`, `access_presence` and `read_smokedetector`.
    ///
    ///  - Note: This method is available for Welcome (Indoor Camera), Presence (Outdoor Camera) and the Smart Smoke Alarm
    ///
    func getEventsUntil(homeId: String, eventId: String, completed: @escaping (Result<[Any], Error>) -> Void) {
        
        guard let accessToken = self.accessToken, accessToken.isEmpty == false else {
            completed(Result.failure(NetatmoError.noAccessToken))
            return
        }
        
        guard var urlComponents = URLComponents(string: "https://api.netatmo.com/api/geteventsuntil") else {
            completed(Result.failure(NetatmoError.badURL))
            return
        }
        
        urlComponents.queryItems = [
            URLQueryItem(name: "home_id", value: homeId),
            URLQueryItem(name: "event_id", value: eventId)
        ]
        
        guard let url = urlComponents.url else {
            completed(Result.failure(NetatmoError.badURL))
            return
        }
        
        guard isValid == false else {
            NetatmoManager.getEventsUntil(accessToken: accessToken, url: url, completed: completed)
            return
        }
        
        // Attempt tokenn refresh
        refreshToken { (result) in
            
            switch result {
            case .success:
                NetatmoManager.getEventsUntil(accessToken: accessToken, url: url, completed: completed)
            case .failure(let error):
                completed(Result.failure(error))
            }
        }
    }
    
    private static func getEventsUntil(accessToken: String, url: URL, completed: @escaping (Result<[Any], Error>) -> Void) {
        
        var urlRequest = URLRequest(url: url)
        urlRequest.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        
        let downloadTask = URLSession.shared.dataTask(with: urlRequest) { (data, _, error) in
            
            if let error = error {
                completed(Result.failure(error))
                return
            }
            
            guard let data = data else {
                completed(Result.failure(NetatmoError.noData))
                return
            }
            
//            let decoder = JSONDecoder()
//            let result: Weather.PublicDataBase?
//            do {
//                result = try decoder.decode(Weather.PublicDataBase.self, from: data)
//            } catch {
//                completed(Result.failure(error))
//                return
//            }
//
//            guard let baseResult = result else {
//                completed(Result.failure(NetatmoError.generalError))
//                return
//            }
//
//            if let body = baseResult.body {
//                completed(Result.success(body))
//            } else if let error = baseResult.error {
//                completed(Result.failure(NetatmoError.error(code: error.code, message: error.message)))
//            } else {
//                completed(Result.failure(NetatmoError.noData))
//            }
        }
        downloadTask.resume()
    }
    
    /// Returns most recent events.
    ///
    /// Scope required: `read_camera` and `acces_camera`
    ///
    /// - Note: This method is only available for Welcome (Indoor Camera).
    ///
    func getLatestEventsOfPerson(homeId: String, personId: String, numberOfEvents size: Int? = nil, completed: @escaping (Result<[Any], Error>) -> Void) {
        
        guard let accessToken = self.accessToken, accessToken.isEmpty == false else {
            completed(Result.failure(NetatmoError.noAccessToken))
            return
        }
        
        guard var urlComponents = URLComponents(string: "https://api.netatmo.com/api/getlasteventof") else {
            completed(Result.failure(NetatmoError.badURL))
            return
        }
        
        urlComponents.queryItems = [
            URLQueryItem(name: "home_id", value: homeId),
            URLQueryItem(name: "person_id", value: personId)
        ]
        
        guard let url = urlComponents.url else {
            completed(Result.failure(NetatmoError.badURL))
            return
        }
        
        guard isValid == false else {
            NetatmoManager.getLatestEventsOfPerson(accessToken: accessToken, url: url, completed: completed)
            return
        }
        
        // Attempt tokenn refresh
        refreshToken { (result) in
            
            switch result {
            case .success:
                NetatmoManager.getLatestEventsOfPerson(accessToken: accessToken, url: url, completed: completed)
            case .failure(let error):
                completed(Result.failure(error))
            }
        }
    }
    
    private static func getLatestEventsOfPerson(accessToken: String, url: URL, completed: @escaping (Result<[Any], Error>) -> Void) {
        
        var urlRequest = URLRequest(url: url)
        urlRequest.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        
        let downloadTask = URLSession.shared.dataTask(with: urlRequest) { (data, _, error) in
            
            if let error = error {
                completed(Result.failure(error))
                return
            }
            
            guard let data = data else {
                completed(Result.failure(NetatmoError.noData))
                return
            }
            
//            let decoder = JSONDecoder()
//            let result: Weather.PublicDataBase?
//            do {
//                result = try decoder.decode(Weather.PublicDataBase.self, from: data)
//            } catch {
//                completed(Result.failure(error))
//                return
//            }
//
//            guard let baseResult = result else {
//                completed(Result.failure(NetatmoError.generalError))
//                return
//            }
//
//            if let body = baseResult.body {
//                completed(Result.success(body))
//            } else if let error = baseResult.error {
//                completed(Result.failure(NetatmoError.error(code: error.code, message: error.message)))
//            } else {
//                completed(Result.failure(NetatmoError.noData))
//            }
        }
        downloadTask.resume()
    }
    
    /// Returns previous events.
    ///
    /// Scope required: `read_camera`, `acces_camera`, `read_presence`, `access_presence` and `read_smokedetector`.
    ///
    /// - Note: This method is available for Welcome (Indoor Camera), Presence (Outdoor Camera) and the Smart Smoke Alarm
    ///
    func getNextEvents(homeId: String, eventId: String, numberOfEvents size: Int? = nil, completed: @escaping (Result<[Any], Error>) -> Void) {
        
        guard let accessToken = self.accessToken, accessToken.isEmpty == false else {
            completed(Result.failure(NetatmoError.noAccessToken))
            return
        }
        
        guard var urlComponents = URLComponents(string: "https://api.netatmo.com/api/getnextevents") else {
            completed(Result.failure(NetatmoError.badURL))
            return
        }
        
        urlComponents.queryItems = [
            URLQueryItem(name: "home_id", value: homeId),
            URLQueryItem(name: "event_id", value: eventId)
        ]
        
        guard let url = urlComponents.url else {
            completed(Result.failure(NetatmoError.badURL))
            return
        }
        
        guard isValid == false else {
            NetatmoManager.getNextEvents(accessToken: accessToken, url: url, completed: completed)
            return
        }
        
        // Attempt tokenn refresh
        refreshToken { (result) in
            
            switch result {
            case .success:
                NetatmoManager.getNextEvents(accessToken: accessToken, url: url, completed: completed)
            case .failure(let error):
                completed(Result.failure(error))
            }
        }
    }
    
    private static func getNextEvents(accessToken: String, url: URL, completed: @escaping (Result<[Any], Error>) -> Void) {
        
        var urlRequest = URLRequest(url: url)
        urlRequest.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        
        let downloadTask = URLSession.shared.dataTask(with: urlRequest) { (data, _, error) in
            
            if let error = error {
                completed(Result.failure(error))
                return
            }
            
            guard let data = data else {
                completed(Result.failure(NetatmoError.noData))
                return
            }
            
//            let decoder = JSONDecoder()
//            let result: Weather.PublicDataBase?
//            do {
//                result = try decoder.decode(Weather.PublicDataBase.self, from: data)
//            } catch {
//                completed(Result.failure(error))
//                return
//            }
//
//            guard let baseResult = result else {
//                completed(Result.failure(NetatmoError.generalError))
//                return
//            }
//
//            if let body = baseResult.body {
//                completed(Result.success(body))
//            } else if let error = baseResult.error {
//                completed(Result.failure(NetatmoError.error(code: error.code, message: error.message)))
//            } else {
//                completed(Result.failure(NetatmoError.noData))
//            }
        }
        downloadTask.resume()
    }
    
    /// Returns the snapshot associated to an event.
    ///
    /// No scope required.
    ///
    func getCameraPicture(imageId: String, key: String, completed: @escaping (Result<[Any], Error>) -> Void) {
        
        guard let accessToken = self.accessToken, accessToken.isEmpty == false else {
            completed(Result.failure(NetatmoError.noAccessToken))
            return
        }
        
        guard var urlComponents = URLComponents(string: "https://api.netatmo.com/api/getcamerapicture") else {
            completed(Result.failure(NetatmoError.badURL))
            return
        }
        
        urlComponents.queryItems = [
            URLQueryItem(name: "image_id", value: imageId),
            URLQueryItem(name: "key", value: key)
        ]
        
        guard let url = urlComponents.url else {
            completed(Result.failure(NetatmoError.badURL))
            return
        }
        
        guard isValid == false else {
            NetatmoManager.getCameraPicture(accessToken: accessToken, url: url, completed: completed)
            return
        }
        
        // Attempt tokenn refresh
        refreshToken { (result) in
            
            switch result {
            case .success:
                NetatmoManager.getCameraPicture(accessToken: accessToken, url: url, completed: completed)
            case .failure(let error):
                completed(Result.failure(error))
            }
        }
    }
    
    private static func getCameraPicture(accessToken: String, url: URL, completed: @escaping (Result<[Any], Error>) -> Void) {
        
        var urlRequest = URLRequest(url: url)
        urlRequest.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        
        let downloadTask = URLSession.shared.dataTask(with: urlRequest) { (data, _, error) in
            
            if let error = error {
                completed(Result.failure(error))
                return
            }
            
            guard let data = data else {
                completed(Result.failure(NetatmoError.noData))
                return
            }
            
//            let decoder = JSONDecoder()
//            let result: Weather.PublicDataBase?
//            do {
//                result = try decoder.decode(Weather.PublicDataBase.self, from: data)
//            } catch {
//                completed(Result.failure(error))
//                return
//            }
//
//            guard let baseResult = result else {
//                completed(Result.failure(NetatmoError.generalError))
//                return
//            }
//
//            if let body = baseResult.body {
//                completed(Result.success(body))
//            } else if let error = baseResult.error {
//                completed(Result.failure(NetatmoError.error(code: error.code, message: error.message)))
//            } else {
//                completed(Result.failure(NetatmoError.noData))
//            }
        }
        downloadTask.resume()
    }
    
    /// Sets a person as "Away" or the Home as "Empty". The event will be added to the user’s timeline.
    ///
    /// Scope required: `write_camera`.
    ///
    /// - Note: This method is only available for Welcome.
    ///
    func setPersonAway(homeId: String, personId: String? = nil, completed: @escaping (Result<[Any], Error>) -> Void) {
        
        guard let accessToken = self.accessToken, accessToken.isEmpty == false else {
            completed(Result.failure(NetatmoError.noAccessToken))
            return
        }
        
        guard var urlComponents = URLComponents(string: "https://api.netatmo.com/api/setpersonsaway") else {
            completed(Result.failure(NetatmoError.badURL))
            return
        }
        
        var queryItems = [
            URLQueryItem(name: "home_id", value: homeId)
        ]
        
        if let personId = personId {
            queryItems.append(URLQueryItem(name: "person_id", value: "\(personId)"))
        }
        
        urlComponents.queryItems = queryItems
        
        guard let url = urlComponents.url else {
            completed(Result.failure(NetatmoError.badURL))
            return
        }
        
        guard isValid == false else {
            NetatmoManager.setPersonAway(accessToken: accessToken, url: url, completed: completed)
            return
        }
        
        // Attempt tokenn refresh
        refreshToken { (result) in
            
            switch result {
            case .success:
                NetatmoManager.setPersonAway(accessToken: accessToken, url: url, completed: completed)
            case .failure(let error):
                completed(Result.failure(error))
            }
        }
    }
    
    private static func setPersonAway(accessToken: String, url: URL, completed: @escaping (Result<[Any], Error>) -> Void) {
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        
        let body = "access_token=\(accessToken)"
        urlRequest.httpBody = body.data(using: .utf8)!
        
        let downloadTask = URLSession.shared.dataTask(with: urlRequest) { (data, _, error) in
            
            if let error = error {
                completed(Result.failure(error))
                return
            }
            
            guard let data = data else {
                completed(Result.failure(NetatmoError.noData))
                return
            }
            
//            let decoder = JSONDecoder()
//            let result: Weather.PublicDataBase?
//            do {
//                result = try decoder.decode(Weather.PublicDataBase.self, from: data)
//            } catch {
//                completed(Result.failure(error))
//                return
//            }
//
//            guard let baseResult = result else {
//                completed(Result.failure(NetatmoError.generalError))
//                return
//            }
//
//            if let body = baseResult.body {
//                completed(Result.success(body))
//            } else if let error = baseResult.error {
//                completed(Result.failure(NetatmoError.error(code: error.code, message: error.message)))
//            } else {
//                completed(Result.failure(NetatmoError.noData))
//            }
        }
        downloadTask.resume()
    }
    
    /// Sets a person or a group of person "at home". The event will be added to the user’s timeline.
    ///
    /// Scope required: `write_camera`.
    ///
    /// - Note: This method is only available for Welcome.
    ///
    func setPersonHome(homeId: String, personIds: [String], completed: @escaping (Result<[Any], Error>) -> Void) {
        
        guard let accessToken = self.accessToken, accessToken.isEmpty == false else {
            completed(Result.failure(NetatmoError.noAccessToken))
            return
        }
        
        guard var urlComponents = URLComponents(string: "https://api.netatmo.com/api/setpersonshome") else {
            completed(Result.failure(NetatmoError.badURL))
            return
        }
        
        var queryItems = [
            URLQueryItem(name: "home_id", value: homeId)
        ]
        
        personIds.enumerated().forEach { (index, personId) in
            queryItems.append(URLQueryItem(name: "person_ids[\(index)]", value: "\(personId)"))
        }
        
        urlComponents.queryItems = queryItems
        
        guard let url = urlComponents.url else {
            completed(Result.failure(NetatmoError.badURL))
            return
        }
        
        guard isValid == false else {
            NetatmoManager.setPersonHome(accessToken: accessToken, url: url, completed: completed)
            return
        }
        
        // Attempt tokenn refresh
        refreshToken { (result) in
            
            switch result {
            case .success:
                NetatmoManager.setPersonHome(accessToken: accessToken, url: url, completed: completed)
            case .failure(let error):
                completed(Result.failure(error))
            }
        }
    }
    
    private static func setPersonHome(accessToken: String, url: URL, completed: @escaping (Result<[Any], Error>) -> Void) {
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        
        let body = "access_token=\(accessToken)"
        urlRequest.httpBody = body.data(using: .utf8)!
        
        let downloadTask = URLSession.shared.dataTask(with: urlRequest) { (data, _, error) in
            
            if let error = error {
                completed(Result.failure(error))
                return
            }
            
            guard let data = data else {
                completed(Result.failure(NetatmoError.noData))
                return
            }
            
//            let decoder = JSONDecoder()
//            let result: Weather.PublicDataBase?
//            do {
//                result = try decoder.decode(Weather.PublicDataBase.self, from: data)
//            } catch {
//                completed(Result.failure(error))
//                return
//            }
//
//            guard let baseResult = result else {
//                completed(Result.failure(NetatmoError.generalError))
//                return
//            }
//
//            if let body = baseResult.body {
//                completed(Result.success(body))
//            } else if let error = baseResult.error {
//                completed(Result.failure(NetatmoError.error(code: error.code, message: error.message)))
//            } else {
//                completed(Result.failure(NetatmoError.noData))
//            }
        }
        downloadTask.resume()
    }
    
}
