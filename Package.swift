// swift-tools-version:5.5

import PackageDescription

let package = Package(
    name: "SimpleNetwork",
    platforms: [.iOS(.v15)],
    products: [
        .library(
            name: "SimpleNetwork",
            targets: ["SimpleNetwork"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "SimpleNetwork",
            dependencies: []),
        .testTarget(
            name: "SimpleNetworkTests",
            dependencies: ["SimpleNetwork"]),
    ]
)
