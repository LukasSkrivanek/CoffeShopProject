// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "CoffeCore",
    platforms: [
        .iOS(.v17),
        .macOS(.v14),
    ],
    products: [
        .library(name: "CoffeCore", targets: ["CoffeCore"]),
    ],
    dependencies: [
        .package(
            url: "https://github.com/pointfreeco/swift-dependencies.git",
            from: "1.0.0"
        ),
    ],
    targets: [
        .target(
            name: "CoffeCore",
            dependencies: [
                .product(name: "Dependencies", package: "swift-dependencies"),
            ],
            path: "CoffeCore"
        ),
        .testTarget(
            name: "CoffeUnitTests",
            dependencies: [
                "CoffeCore",
                .product(name: "DependenciesTestSupport", package: "swift-dependencies"),
            ],
            path: "CoffeUnitTests"
        ),
    ]
)
