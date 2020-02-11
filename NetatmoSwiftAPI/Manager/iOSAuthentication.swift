//
//  iOSAuthentication.swift
//  NetatmoSwiftAPI
//
//  Created by James Barrow on 2020-02-11.
//  Copyright © 2020 Pig on a Hill Productions. All rights reserved.
//

import Foundation
import SafariServices

@available(iOS 9.0, *)
extension NetatmoManager {
    
    internal func authorize(scope: [AuthScope] = [.readStation]) throws -> SFSafariViewController {
        
        let url = try authorizeURL()
        return SFSafariViewController(url: url)
    }
    
}
