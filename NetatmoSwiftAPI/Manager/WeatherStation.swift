//
//  WeatherStation.swift
//  NetatmoSwiftAPI
//
//  Created by James Barrow on 2019-10-23.
//  Copyright © 2019 Pig on a Hill Productions. All rights reserved.
//

import Foundation

public extension NetatmoManager {
    
    // MARK: - Weather Station
    
    /// Returns data from a user Weather Stations (measures and device specific data).
    /// - Parameters:
    ///   - deviceId: Weather station mac address.
    ///   - favorites: To retrieve user's favorite weather stations. Default is false.
    ///   - completed: The result of the request as `WeatherStationResult` or `Error` on failure.
    func getWeatherStationData(deviceId: String? = nil, favorites: Bool = false, completed: @escaping (Result<WeatherStationResult, Error>) -> Void) {
        
        guard let accessToken = self.accessToken, accessToken.isEmpty == false else {
            completed(Result.failure(NetatmoError.noAccessToken))
            return
        }
        
        guard var urlComponents = URLComponents(string: "https://api.netatmo.com/api/getstationsdata") else {
            completed(Result.failure(NetatmoError.badURL))
            return
        }
        
        urlComponents.queryItems = [
            URLQueryItem(name: "get_favorites", value: "\(favorites)")
        ]
        
        if let deviceId = deviceId {
            urlComponents.queryItems?.append(URLQueryItem(name: "device_id", value: deviceId))
        }
        
        guard let url = urlComponents.url else {
            completed(Result.failure(NetatmoError.badURL))
            return
        }
        
        guard isValid == false else {
            NetatmoManager.getWeatherStationData(accessToken: accessToken, url: url, completed: completed)
            return
        }
        
        // Attempt tokenn refresh
        refreshToken { (result) in
            
            switch result {
            case .success:
                NetatmoManager.getWeatherStationData(accessToken: accessToken, url: url, completed: completed)
            case .failure(let error):
                completed(Result.failure(error))
            }
        }
    }
    
    private static func getWeatherStationData(accessToken: String, url: URL, completed: @escaping (Result<WeatherStationResult, Error>) -> Void) {
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        
        let body = "access_token=\(accessToken)"
        urlRequest.httpBody = body.data(using: .utf8)!
        
        let downloadTask = URLSession.shared.dataTask(with: urlRequest) { (data, _, error) in
            
            if let error = error {
                print(error)
                completed(Result.failure(error))
                return
            }
            
            guard let data = data else {
                completed(Result.failure(NetatmoError.noData))
                return
            }
            
            let decoder = JSONDecoder()
            let result: BaseResult?
            do {
              result = try decoder.decode(BaseResult.self, from: data)
            } catch {
              completed(Result.failure(error))
              return
            }

            guard let baseResult = result else {
              completed(Result.failure(NetatmoError.generalError))
              return
            }
            completed(Result.success(baseResult.body))
        }
        downloadTask.resume()
    }
    
}
