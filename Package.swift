// swift-tools-version: 5.6
import PackageDescription

let package = Package(
    name: "UIKitLayout",
    platforms: [
        .iOS(.v11),
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
