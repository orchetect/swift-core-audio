// swift-tools-version: 6.0

import Foundation
import PackageDescription

let package = Package(
    name: "swift-core-audio",
    platforms: [
        .macOS(.v10_15),
        .iOS(.v13),
        .tvOS(.v13),
        .watchOS(.v6),
        .visionOS(.v1)
    ],
    products: [
        .library(
            name: "SwiftCoreAudio",
            targets: ["SwiftCoreAudio"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/orchetect/swift-process", from: "0.2.1"),
        .package(url: "https://github.com/orchetect/swift-testing-extensions", from: "0.3.1"),
        .package(url: "https://github.com/orchetect/swift-unit-interval", from: "1.0.2")
    ],
    targets: [
        .target(
            name: "SwiftCoreAudio",
            dependencies: [
                .product(name: "SwiftProcess", package: "swift-process"),
                .product(name: "SwiftUnitInterval", package: "swift-unit-interval")
            ],
            swiftSettings: [.define("DEBUG", .when(configuration: .debug))]
        ),
        .testTarget(
            name: "SwiftCoreAudioTests",
            dependencies: [
                "SwiftCoreAudio",
                .product(name: "TestingExtensions", package: "swift-testing-extensions")
            ]
        )
    ],
    swiftLanguageModes: [.v6]
)

// MARK: - Utilities

func hasEnvironmentVariable(_ name: String) -> Bool {
    ProcessInfo.processInfo.environment[name] != nil
}

// MARK: - CI Pipeline

if hasEnvironmentVariable("GITHUB_ACTIONS") {
    for target in package.targets.filter(\.isTest) {
        if target.swiftSettings == nil { target.swiftSettings = [] }
        target.swiftSettings? += [.define("GITHUB_ACTIONS", .when(configuration: .debug))]
    }
}
