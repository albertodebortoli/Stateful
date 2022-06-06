// swift-tools-version: 5.6

import PackageDescription

let package = Package(
    name: "Stateful",
    platforms: [.iOS(.v13)],
    products: [
        .library(
            name: "Stateful",
            targets: ["Stateful"])
    ],
    targets: [
        .target(
            name: "Stateful",
            path: "Framework/Sources"),
        .testTarget(
            name: "StatefulTests",
            dependencies: ["Stateful"],
            path: "Tests/Sources")
    ]
)
