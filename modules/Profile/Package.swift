// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "Profile",
  defaultLocalization: "en",
  platforms: [
    .iOS(.v17)
  ],
  products: [
    .library(
      name: "Profile",
      targets: ["Profile"]
    )
  ],
  dependencies: [
    .package(name: "CoreBase", path: "../CoreBase"),
    .package(url: "https://github.com/hmlongco/Factory.git", from: "2.5.0"),
    .package(url: "https://github.com/SnapKit/SnapKit.git", from: "5.7.0"),
  ],
  targets: [
    .target(
      name: "Profile",
      dependencies: [
        .product(name: "CoreBase", package: "CoreBase"),
        .product(name: "Factory", package: "Factory"),
        .product(name: "SnapKit", package: "SnapKit"),
      ],
    )
  ]
)
