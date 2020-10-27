// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "DeviceGuru",
    products: [
        .library(
            name: "DeviceGuru", 
            targets: ["DeviceGuru"]
        )
    ],
    dependencies: [],
    targets: [
        .target(
            name: "DeviceGuru", 
            dependencies: [], 
            resources: [.copy("DeviceList.plist")]
        )
    ]
)
