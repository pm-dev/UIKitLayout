// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "UIKitLayout",
    platforms: [
        .iOS(.v12),
    ],
    products: [
        .library(
            name: "UIKitLayout",
            targets: ["UIKitLayout"]),
    ],
    targets: [
        .target(
            name: "UIKitLayout",
            dependencies: [],
            path: "Sources"),
        .testTarget(
            name: "UIKitLayoutTests",
            dependencies: ["UIKitLayout"],
            path: "Tests"),
    ]
)
