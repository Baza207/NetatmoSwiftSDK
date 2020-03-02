//
//  URLRequestExtensions.swift
//  NetatmoSwiftSDK
//
//  Created by James Barrow on 2020-02-28.
//  Copyright © 2020 Pig on a Hill Productions. All rights reserved.
//

import Foundation

extension URLRequest {
    
    internal static func jsonRequest(url: URL, accessToken: String, httpMethod: String? = nil) -> URLRequest {
        
        var urlRequest = URLRequest(url: url)
        if let httpMethod = httpMethod {
            urlRequest.httpMethod = httpMethod
        }
        urlRequest.setValue("application/json", forHTTPHeaderField: "accept")
        urlRequest.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        return urlRequest
    }
    
}
