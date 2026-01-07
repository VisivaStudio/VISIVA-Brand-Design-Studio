// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "VisivaProjectTools",
    platforms: [
        .macOS(.v13)
    ],
    products: [
        .executable(name: "FixCopyBundleResources", targets: ["FixCopyBundleResources"])
    ],
    dependencies: [
        .package(url: "https://github.com/tuist/XcodeProj.git", from: "8.21.0")
    ],
    targets: [
        .executableTarget(
            name: "FixCopyBundleResources",
            dependencies: [
                .product(name: "XcodeProj", package: "XcodeProj")
            ]
        )
    ]
)
