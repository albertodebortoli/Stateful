// swift-tools-version: 6.2

import PackageDescription

let package = Package(
    name: "StatefulDemo",
    platforms: [
        .iOS(.v13),
        .macOS(.v10_15)
    ],
    dependencies: [
        .package(name: "Stateful", path: "../")
    ],
    targets: [
        .executableTarget(
            name: "Demo",
            dependencies: [
                .product(name: "Stateful", package: "Stateful"),
            ]
        )
    ]
)
