// swift-tools-version: 6.0

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
        .package(url: "https://github.com/orchetect/swift-process", from: "0.2.0"),
        .package(url: "https://github.com/orchetect/swift-testing-extensions", from: "0.3.0"),
        .package(url: "https://github.com/orchetect/swift-unit-interval", from: "1.0.2")
    ],
    targets: [
        .target(
            name: "SwiftCoreAudio",
            dependencies: [
                .product(name: "SwiftProcess", package: "swift-process"),
                .product(name: "SwiftUnitInterval", package: "swift-unit-interval")
            ]
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
