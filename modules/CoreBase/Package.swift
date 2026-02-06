// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "CoreBase",
  defaultLocalization: "en",
  platforms: [
    .iOS(.v17),
  ],
  products: [
    .library(
      name: "CoreBase",
      targets: ["CoreBase"]
    ),
  ],
  dependencies: [
    .package(url: "https://github.com/SimplyDanny/SwiftLintPlugins.git", from: "0.63.0"),
    .package(url: "https://github.com/hmlongco/Factory.git", from: "2.5.0"),
    .package(url: "https://github.com/kevinwu352/SwiftEntryKit.git", branch: "dev"),
  ],
  targets: [
    .target(
      name: "CoreBase",
      dependencies: [
        .product(name: "Factory", package: "Factory"),
        .product(name: "SwiftEntryKit", package: "SwiftEntryKit"),
      ],
      // swiftSettings: [.defaultIsolation(MainActor.self)],
      plugins: [.plugin(name: "SwiftLintBuildToolPlugin", package: "SwiftLintPlugins")],
    ),
    .testTarget(
      name: "CoreBaseTests",
      dependencies: ["CoreBase"]
    ),
  ]
)
