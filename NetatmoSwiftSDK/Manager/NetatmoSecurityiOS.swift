//
//  NetatmoSecurityiOS.swift
//  NetatmoSwiftSDK
//
//  Created by James Barrow on 2020-02-27.
//  Copyright © 2020 Pig on a Hill Productions. All rights reserved.
//

import UIKit

// swiftlint:disable deployment_target
@available(iOS 2, *)
public extension NetatmoSecurity {
    
    /// Returns the snapshot associated to an event.
    ///
    /// No scope required.
    ///
    static func getCameraUIImage(imageId: String, key: String, completed: @escaping (Result<UIImage, Error>) -> Void) {
        
        NetatmoSecurity.getCameraPicture(imageId: imageId, key: key) { (result) in
            switch result {
            case .success(let data):
                if let image = UIImage(data: data) {
                    completed(Result.success(image))
                    return
                }
                completed(Result.failure(NetatmoError.noImage))
            case .failure(let error):
                completed(Result.failure(error))
            }
        }
    }
    
}
// swiftlint:enable deployment_target
