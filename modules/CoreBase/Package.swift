// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "CoreBase",
  defaultLocalization: "en",
  platforms: [
    .iOS(.v17)
  ],
  products: [
    .library(
      name: "CoreBase",
      targets: ["CoreBase"]
    )
  ],
  dependencies: [
    .package(url: "https://github.com/hmlongco/Factory.git", from: "2.5.0"),
    .package(url: "https://github.com/evgenyneu/keychain-swift.git", from: "24.0.0"),
    .package(url: "https://github.com/SnapKit/SnapKit.git", from: "5.7.0"),
    .package(url: "https://github.com/kevinwu352/SwiftEntryKit.git", branch: "dev"),
    .package(url: "https://github.com/psharanda/Atributika.git", from: "5.0.0"),
  ],
  targets: [
    .target(
      name: "CoreBase",
      dependencies: [
        .product(name: "Factory", package: "Factory"),
        .product(name: "KeychainSwift", package: "keychain-swift"),
        .product(name: "SnapKit", package: "SnapKit"),
        .product(name: "SwiftEntryKit", package: "SwiftEntryKit"),
        .product(name: "Atributika", package: "Atributika"),
        .product(name: "AtributikaViews", package: "Atributika"),
      ],
      // swiftSettings: [.defaultIsolation(MainActor.self)],
    ),
    .testTarget(
      name: "CoreBaseTests",
      dependencies: ["CoreBase"]
    ),
  ]
)
