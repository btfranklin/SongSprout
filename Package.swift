// swift-tools-version:5.4
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SongSprout",
    platforms: [
        .macOS(.v11), .iOS(.v14), .tvOS(.v14), .watchOS(.v7)
    ],
    products: [
        .library(
            name: "SongSprout",
            type: .static,
            targets: ["SongSprout"]),
    ],
    dependencies: [
        .package(name: "Dunesailer Utilities",
                 url: "https://github.com/dunesailer/Utilities.git",
                 from: "2.0.6"),
        .package(name: "AudioKit",
                 url: "https://github.com/AudioKit/AudioKit.git",
                 .branch("main") ),
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
