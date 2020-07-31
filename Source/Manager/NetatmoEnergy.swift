//
//  NetatmoEnergy.swift
//  NetatmoSwiftSDK
//
//  Created by James Barrow on 2020-07-31.
//  Copyright © 2020 Pig on a Hill Productions. All rights reserved.
//

import Foundation

public class NetatmoEnergy {
    
    /// Retrieve user's homes and their topology.
    ///
    /// Scope required: `read_thermostat`.
    ///
    public static func getHomeData(homeId: String? = nil, gatewayType type: ProductType? = nil, completed: @escaping (Result<NetatmoEnergy.HomeData, Error>) -> Void) {
        
        guard let accessToken = NetatmoManager.shared.accessToken, accessToken.isEmpty == false else {
            completed(Result.failure(NetatmoError.noAccessToken))
            return
        }
        
        guard var urlComponents = URLComponents(string: "\(NetatmoManager.baseAPIURL)/homesdata") else {
            completed(Result.failure(NetatmoError.badURL))
            return
        }
        
        var queryItems = [URLQueryItem]()
        
        if let homeId = homeId {
            queryItems.append(URLQueryItem(name: "home_id", value: homeId))
        }
        
        if let type = type {
            queryItems.append(URLQueryItem(name: "gateway_types", value: "\(type.rawValue)"))
        }
        
        urlComponents.queryItems = queryItems
        
        guard let url = urlComponents.url else {
            completed(Result.failure(NetatmoError.badURL))
            return
        }
        
        guard NetatmoManager.shared.isValid == false else {
            NetatmoEnergy.getHomeData(accessToken: accessToken, url: url, completed: completed)
            return
        }
        
        // Attempt tokenn refresh
        NetatmoManager.refreshToken { (result) in
            
            switch result {
            case .success:
                NetatmoEnergy.getHomeData(accessToken: accessToken, url: url, completed: completed)
            case .failure(let error):
                completed(Result.failure(error))
            }
        }
    }
    
    private static func getHomeData(accessToken: String, url: URL, completed: @escaping (Result<NetatmoEnergy.HomeData, Error>) -> Void) {
        
        let urlRequest = URLRequest.jsonRequest(url: url, accessToken: accessToken)
        let downloadTask = URLSession.shared.dataTask(with: urlRequest) { (data, _, error) in
            
            if let error = error {
                completed(Result.failure(error))
                return
            }
            
            guard let data = data else {
                completed(Result.failure(NetatmoError.noData))
                return
            }
            
            let decoder = JSONDecoder.secondsSince1970JSONDecoder
            let result: NetatmoEnergy.HomeDataBase?
            do {
                result = try decoder.decode(NetatmoEnergy.HomeDataBase.self, from: data)
            } catch {
                completed(Result.failure(error))
                return
            }
            
            guard let baseResult = result else {
                completed(Result.failure(NetatmoError.generalError))
                return
            }
            
            if let body = baseResult.body {
                completed(Result.success(body))
            } else if let error = baseResult.error {
                completed(Result.failure(NetatmoError.error(code: error.code, message: error.message)))
            } else {
                completed(Result.failure(NetatmoError.noData))
            }
        }
        downloadTask.resume()
    }
}
