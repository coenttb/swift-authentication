// swift-tools-version:6.0

import Foundation
import PackageDescription

extension String {
    static let authentication: Self = "Authentication"
    static let basicAuth: Self = "BasicAuth"
    static let bearerAuth: Self = "BearerAuth"
}

extension Target.Dependency {
    static var basicAuth: Self { .target(name: .basicAuth) }
    static var bearerAuth: Self { .target(name: .bearerAuth) }
}

extension Target.Dependency {
    static var urlRouting: Self { .product(name: "URLRouting", package: "swift-url-routing") }
}

let package = Package(
    name: "swift-authentication",
    platforms: [
        .macOS(.v14),
        .iOS(.v17)
    ],
    products: [
        .library(name: .authentication, targets: [.basicAuth, .bearerAuth]),
        .library(name: .basicAuth, targets: [.basicAuth]),
        .library(name: .bearerAuth, targets: [.bearerAuth]),
    ],
    dependencies: [
        .package(url: "https://github.com/pointfreeco/swift-url-routing", from: "0.6.0"),
    ],
    targets: [
        .target(
            name: .basicAuth,
            dependencies: [
                .urlRouting
            ]
        ),
        .target(
            name: .bearerAuth,
            dependencies: [
                .urlRouting
            ]
        ),
        .testTarget(
            name: .basicAuth + " Tests",
            dependencies: [
                .basicAuth,
                .urlRouting
            ]
        ),
        .testTarget(
            name: .bearerAuth + " Tests",
            dependencies: [
                .bearerAuth,
                .urlRouting
            ]
        ),
    ],
    swiftLanguageModes: [.v6]
)
