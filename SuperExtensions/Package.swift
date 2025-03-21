// swift-tools-version:5.9
import PackageDescription

let package = Package(
    name: "SuperExtensions",
    platforms: [.iOS(.v17)],
    products: [
        .library(name: "SuperExtensions", targets: ["SuperExtensions"])
    ],
    targets: [
        .target(
            name: "SuperExtensions",
            path: "Sources"
        ),
        .testTarget(
            name: "SuperExtensionsTests",
            dependencies: ["SuperExtensions"],
            path: "Tests"
        )
    ]
)
