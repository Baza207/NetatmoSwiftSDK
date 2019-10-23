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
    
    func getWeatherStationData(deviceId: String = "", completed: @escaping (Result<WeatherStationResult?, Error>) -> Void) {
        
        guard let accessToken = self.accessToken, accessToken.isEmpty == false else {
            completed(Result.failure(NetatmoError.noAccessToken))
            return
        }
        
        // TODO: Check to see if token has expired, if so, refresh the token
        
        guard let url = URL(string: "https://api.netatmo.com/api/getstationsdata") else {
            completed(Result.failure(NetatmoError.badURL))
            return
        }
        
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
