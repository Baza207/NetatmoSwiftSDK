//
//  iOSAuthentication.swift
//  NetatmoSwiftSDK
//
//  Created by James Barrow on 2020-02-11.
//  Copyright © 2020 Pig on a Hill Productions. All rights reserved.
//

import Foundation
import SafariServices

@available(iOS 9.0, *)
public extension NetatmoManager {
    
    static func authorize(scope: [AuthScope] = [.readStation]) throws -> SFSafariViewController {
        
        let url = try NetatmoManager.authorizeURL()
        return SFSafariViewController(url: url)
    }
    
}
