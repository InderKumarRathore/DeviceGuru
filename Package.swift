// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "DeviceGuru",
    platforms: [
        .iOS(.v8),
        .tvOS(.v9),
        .watchOS(.v2)
    ],
    products: [
        .library(
            name: "DeviceGuru", 
            targets: ["DeviceGuru"]
        )
    ],
    targets: [
        .target(
            name: "DeviceGuru", 
            dependencies: [], 
            path: "Sources",
            exclude: ["Example"],
            resources: [.copy("DeviceList.plist")]
        )
    ]
)
