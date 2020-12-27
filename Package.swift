// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "AWSDeployPublishPlugin",
    products: [
        .library(
            name: "AWSDeployPublishPlugin",
            targets: ["AWSDeployPublishPlugin"]),
    ],
    dependencies: [
      .package(name: "Publish", url: "https://github.com/johnsundell/publish.git", from: "0.5.0"),
    ],
    targets: [
        .target(
            name: "AWSDeployPublishPlugin",
            dependencies: [
          .product(name: "Publish", package: "Publish")
        ]),
        .testTarget(
            name: "AWSDeployPublishPluginTests",
            dependencies: ["AWSDeployPublishPlugin"]
        ),
    ]
)
