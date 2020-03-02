//
//  Package.swift
//  NetatmoSwiftSDK
//
//  Created by James Barrow on 2020-02-29.
//  Copyright © 2020 Pig on a Hill Productions. All rights reserved.
//

import PackageDescription

let package = Package(
    name: "NetatmoSwiftSDK",
    platforms: [
        .iOS(.v12)
    ],
    products: [
        .library(
            name: "NetatmoSwiftSDK",
            targets: ["NetatmoSwiftSDK"])
    ],
    targets: [
        .target(
            name: "NetatmoSwiftSDK",
            path: "Source")
    ],
    swiftLanguageVersions: [.v5]
)
