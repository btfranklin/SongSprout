// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SongSprout",
    platforms: [
        .macOS(.v10_15), .iOS(.v13),
    ],
    products: [
        .library(
            name: "SongSprout",
            targets: ["SongSprout"]),
    ],
    dependencies: [
        .package(name: "Dunesailer Utilities",
                 url: "https://github.com/dunesailer/Utilities.git",
                 from: "1.0.0"),
        .package(name: "AudioKit",
                 url: "https://github.com/AudioKit/AudioKit.git",
                 .branch("v5-develop")),
    ],
    targets: [
        .target(
            name: "SongSprout",
            dependencies: [
                .product(name: "DunesailerUtilities",
                         package: "Dunesailer Utilities"),
                .product(name: "AudioKit",
                         package: "AudioKit"),
            ],
            resources: [
                .process("Resources/GeneralUser GS v1.471.sf2")
            ]),
        .testTarget(
            name: "SongSproutTests",
            dependencies: ["SongSprout"]),
    ]
)
