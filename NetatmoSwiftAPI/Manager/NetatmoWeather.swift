//
//  NetatmoWeather.swift
//  NetatmoSwiftAPI
//
//  Created by James Barrow on 2019-10-23.
//  Copyright © 2019 Pig on a Hill Productions. All rights reserved.
//

import Foundation
import CoreLocation

public class NetatmoWeather {
    
    // MARK: - Public Weather Data
    
    /// Retrieves publicly shared weather data from Outdoor Modules within a predefined area.
    ///
    /// No scope required.
    ///
    /// - Parameters:
    ///   - northEast: Coordinates of the north east corner of the requested area. Latitude: `-85 <= neLatitude <= 85 and neLatitude > swLatitude`. Longitude: `-180 <= neLongitude <= 180 and neLongitude > swLongitude`.
    ///   - southWest: Coordinates of the south west corner of the requested area. Latitude: `-85 <= swLatitude <= 85`. Longitude: `-180 <= swLongitude <= 180`.
    ///   - requiredData: To filter stations based on relevant measurements you want (e.g. rain will only return stations with rain gauges). Default is no filter `nil`.
    ///   - filter: `true` to exclude station with abnormal temperature measures. Default is `false`.
    ///   - completed: The result of the request as `Weather.PublicData` or `Error` on failure.
    public static func getPublicData(northEast: CLLocationCoordinate2D, southWest: CLLocationCoordinate2D, requiredData: String? = nil, filter: Bool = false, completed: @escaping (Result<[Weather.PublicData], Error>) -> Void) {
        
        guard let accessToken = NetatmoManager.shared.accessToken, accessToken.isEmpty == false else {
            completed(Result.failure(NetatmoError.noAccessToken))
            return
        }
        
        guard var urlComponents = URLComponents(string: "https://api.netatmo.com/api/getpublicdata") else {
            completed(Result.failure(NetatmoError.badURL))
            return
        }
        
        var queryItems = [
            URLQueryItem(name: "lat_ne", value: "\(northEast.latitude)"),
            URLQueryItem(name: "lon_ne", value: "\(northEast.longitude)"),
            URLQueryItem(name: "lat_sw", value: "\(southWest.latitude)"),
            URLQueryItem(name: "lon_sw", value: "\(southWest.longitude)"),
            URLQueryItem(name: "filter", value: "\(filter)")
        ]
        
        if let requiredData = requiredData {
            queryItems.append(URLQueryItem(name: "required_data", value: requiredData))
        }
        
        urlComponents.queryItems = queryItems
        
        guard let url = urlComponents.url else {
            completed(Result.failure(NetatmoError.badURL))
            return
        }
        
        guard NetatmoManager.shared.isValid == false else {
            NetatmoWeather.getPublicData(accessToken: accessToken, url: url, completed: completed)
            return
        }
        
        // Attempt tokenn refresh
        NetatmoManager.shared.refreshToken { (result) in
            
            switch result {
            case .success:
                NetatmoWeather.getPublicData(accessToken: accessToken, url: url, completed: completed)
            case .failure(let error):
                completed(Result.failure(error))
            }
        }
    }
    
    private static func getPublicData(accessToken: String, url: URL, completed: @escaping (Result<[Weather.PublicData], Error>) -> Void) {
        
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
            
            let decoder = JSONDecoder()
            let result: Weather.PublicDataBase?
            do {
                result = try decoder.decode(Weather.PublicDataBase.self, from: data)
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
    
    // MARK: - Weather Station Data
    
    /// Returns data from a user Weather Stations (measures and device specific data).
    ///
    /// Scope required: `readStation`.
    ///
    /// - Parameters:
    ///   - deviceId: Weather station mac address.
    ///   - favorites: To retrieve user's favorite weather stations. Default is false.
    ///   - completed: The result of the request as `Weather.Station` or `Error` on failure.
    public static func getWeatherStationData(deviceId: String? = nil, favorites: Bool = false, completed: @escaping (Result<Weather.Station, Error>) -> Void) {
        
        guard let accessToken = NetatmoManager.shared.accessToken, accessToken.isEmpty == false else {
            completed(Result.failure(NetatmoError.noAccessToken))
            return
        }
        
        guard var urlComponents = URLComponents(string: "https://api.netatmo.com/api/getstationsdata") else {
            completed(Result.failure(NetatmoError.badURL))
            return
        }
        
        var queryItems = [
            URLQueryItem(name: "get_favorites", value: "\(favorites)")
        ]
        
        if let deviceId = deviceId {
            queryItems.append(URLQueryItem(name: "device_id", value: deviceId))
        }
        
        urlComponents.queryItems = queryItems
        
        guard let url = urlComponents.url else {
            completed(Result.failure(NetatmoError.badURL))
            return
        }
        
        guard NetatmoManager.shared.isValid == false else {
            NetatmoWeather.getWeatherStationData(accessToken: accessToken, url: url, completed: completed)
            return
        }
        
        // Attempt tokenn refresh
        NetatmoManager.shared.refreshToken { (result) in
            
            switch result {
            case .success:
                NetatmoWeather.getWeatherStationData(accessToken: accessToken, url: url, completed: completed)
            case .failure(let error):
                completed(Result.failure(error))
            }
        }
    }
    
    private static func getWeatherStationData(accessToken: String, url: URL, completed: @escaping (Result<Weather.Station, Error>) -> Void) {
        
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
            
            let decoder = JSONDecoder()
            let result: Weather.StationBase?
            do {
                result = try decoder.decode(Weather.StationBase.self, from: data)
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
    
    // MARK: - Weather Station Measurement
    
    /// Retrieve data from a device or module.
    ///
    /// Scope required: `readStation`.
    ///
    /// - Parameters:
    ///   - deviceId: Weather station mac address.
    ///   - moduleId: Module mac address.
    ///   - scale: The time between each measurement.
    ///   - type: The type of measurement to return.
    ///   - beginDate: Date of the first measure to retrieve. Default is `nil`.
    ///   - endDate: Date of the last measure to retrieve. Default is `nil`.
    ///   - limit: Maximum number of measurements (default and max are 1024).
    ///   - optimize: Determines the format of the answer. Default is `true`. For mobile apps we recommend `true` and `false` if bandwidth isn't an issue as it is easier to parse.
    ///   - realTime: If scale different than max, timestamps are by default offset + scale/2. To get exact timestamps, use `true`. Default is `false`.
    ///   - completed: The result of the request as `Weather.StationMeasure` or `Error` on failure.
    public static func getMeasure(deviceId: String, moduleId: String? = nil, scale: Weather.TimeScale, type: Weather.MeasureType, beginDate: Date? = nil, endDate: Date? = nil, limit: Int? = nil, optimize: Bool = true, realTime: Bool = false, completed: @escaping (Result<[Weather.StationMeasure], Error>) -> Void) {
        
        guard let accessToken = NetatmoManager.shared.accessToken, accessToken.isEmpty == false else {
            completed(Result.failure(NetatmoError.noAccessToken))
            return
        }
        
        guard var urlComponents = URLComponents(string: "https://api.netatmo.com/api/getmeasure") else {
            completed(Result.failure(NetatmoError.badURL))
            return
        }
        
        var queryItems = [
            URLQueryItem(name: "device_id", value: "\(deviceId)"),
            URLQueryItem(name: "scale", value: scale.rawValue),
            URLQueryItem(name: "type", value: type.rawValue),
            URLQueryItem(name: "optimize", value: "\(optimize)"),
            URLQueryItem(name: "real_time", value: "\(realTime)")
        ]
        
        if let moduleId = moduleId {
            queryItems.append(URLQueryItem(name: "module_id", value: moduleId))
        }
        
        if let begin = beginDate {
            queryItems.append(URLQueryItem(name: "date_begin", value: "\(begin.timeIntervalSince1970)"))
        }
        
        if let endDate = endDate {
            queryItems.append(URLQueryItem(name: "date_end", value: "\(endDate.timeIntervalSince1970)"))
        }
        
        if let limit = limit {
            queryItems.append(URLQueryItem(name: "limit", value: "\(min(limit, 1024))"))
        }
        
        urlComponents.queryItems = queryItems
        
        guard let url = urlComponents.url else {
            completed(Result.failure(NetatmoError.badURL))
            return
        }
        
        guard NetatmoManager.shared.isValid == false else {
            NetatmoWeather.getMeasure(accessToken: accessToken, url: url, completed: completed)
            return
        }
        
        // Attempt tokenn refresh
        NetatmoManager.shared.refreshToken { (result) in
            
            switch result {
            case .success:
                NetatmoWeather.getMeasure(accessToken: accessToken, url: url, completed: completed)
            case .failure(let error):
                completed(Result.failure(error))
            }
        }
    }
    
    private static func getMeasure(accessToken: String, url: URL, completed: @escaping (Result<[Weather.StationMeasure], Error>) -> Void) {
        
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
            
            let decoder = JSONDecoder()
            let result: Weather.StationMeasureBase?
            do {
                result = try decoder.decode(Weather.StationMeasureBase.self, from: data)
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
