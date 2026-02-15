// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "Auth",
  defaultLocalization: "en",
  platforms: [
    .iOS(.v17),
  ],
  products: [
    .library(
      name: "Auth",
      targets: ["Auth"]
    ),
  ],
  dependencies: [
    .package(url: "https://github.com/SimplyDanny/SwiftLintPlugins.git", from: "0.63.0"),
    .package(name: "CoreBase", path: "../CoreBase"),
    .package(url: "https://github.com/hmlongco/Factory.git", from: "2.5.0"),
    .package(url: "https://github.com/SnapKit/SnapKit.git", from: "5.7.0"),
  ],
  targets: [
    .target(
      name: "Auth",
      dependencies: [
        .product(name: "CoreBase", package: "CoreBase"),
        .product(name: "Factory", package: "Factory"),
        .product(name: "SnapKit", package: "SnapKit"),
      ],
      plugins: [.plugin(name: "SwiftLintBuildToolPlugin", package: "SwiftLintPlugins")]
    ),
    .testTarget(
      name: "AuthTests",
      dependencies: ["Auth"]
    ),
  ]
)
