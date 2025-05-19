// swift-tools-version:6.1

import PackageDescription


let swiftSettings: [SwiftSetting] = [
    .enableUpcomingFeature("ExistentialAny")
]

let package = Package(
    name: "xccovPretty",
    platforms: [
        .macOS(.v12)
    ],
    products: [
        .executable(name: "xccovPretty", targets: ["xccovPretty"])
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-argument-parser.git", from: "1.5.0"),
    ],
    targets: [
        .executableTarget(
            name: "xccovPretty",
            dependencies: [
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
            ],
            swiftSettings: swiftSettings
        )
    ]
)
