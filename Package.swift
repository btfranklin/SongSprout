// swift-tools-version:5.4
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SongSprout",
    platforms: [
        .macOS(.v11), .iOS(.v14)
    ],
    products: [
        .library(
            name: "SongSprout",
            type: .static,
            targets: ["SongSprout"]),
    ],
    dependencies: [
        .package(name: "ControlledChaos",
                 url: "https://github.com/btfranklin/ControlledChaos.git",
                 from: "1.1.1"),
        .package(name: "AudioKit",
                 url: "https://github.com/AudioKit/AudioKit.git",
                 from: "5.3.0"),
        .package(name: "SoundpipeAudioKit",
                 url: "https://github.com/AudioKit/SoundpipeAudioKit.git",
                 from: "5.3.0"),
    ],
    targets: [
        .target(
            name: "SongSprout",
            dependencies: [
                .product(name: "ControlledChaos",
                         package: "ControlledChaos"),
                .product(name: "AudioKit",
                         package: "AudioKit"),
                .product(name: "SoundpipeAudioKit",
                         package: "SoundpipeAudioKit")
            ],
            resources: [
                .process("Resources/GeneralUser GS v1.471.sf2")
            ]),
        .testTarget(
            name: "SongSproutTests",
            dependencies: ["SongSprout"]),
    ]
)
