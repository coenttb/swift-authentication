// swift-tools-version:6.0

import Foundation
import PackageDescription

extension String {
    static let basicAuth: Self = "BasicAuth"
    static let bearerAuth: Self = "BearerAuth"
}

extension Target.Dependency {
    static var basicAuth: Self { .target(name: .basicAuth) }
    static var bearerAuth: Self { .target(name: .bearerAuth) }
}

extension Target.Dependency {
    static var urlRouting: Self { .product(name: "URLRouting", package: "swift-url-routing") }
    static var coenttbWeb: Self { .product(name: "Coenttb Web", package: "coenttb-web") }
    static var dependencies: Self { .product(name: "Dependencies", package: "swift-dependencies") }
}

let package = Package(
    name: "swift-authentication",
    platforms: [
        .macOS(.v14),
        .iOS(.v17)
    ],
    products: [
        .library(name: "Authentication", targets: [.basicAuth, .bearerAuth]),
        .library(name: .basicAuth, targets: [.basicAuth]),
        .library(name: .bearerAuth, targets: [.bearerAuth]),
    ],
    dependencies: [
        .package(url: "https://github.com/pointfreeco/swift-url-routing", from: "0.6.0"),
        .package(url: "https://github.com/pointfreeco/swift-dependencies", from: "1.6.0"),
        .package(url: "https://github.com/coenttb/coenttb-web", branch: "main"),
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
