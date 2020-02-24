// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "DataSource",
    platforms: [
        .iOS(.v10),
        .tvOS(.v10),
    ],
    products: [
        .library(
            name: "DataSource",
            targets: ["DataSource"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "DataSource",
            dependencies: []),
        .testTarget(
            name: "DataSourceTests",
            dependencies: ["DataSource"]),
    ]
)
