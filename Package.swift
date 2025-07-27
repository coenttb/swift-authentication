// swift-tools-version:6.0

import Foundation
import PackageDescription

extension String {
    static let authentication: Self = "Authentication"
    static let authenticationTypes: Self = "AuthenticationTypes"
    static let authenticationTypesURLRouting: Self = "AuthenticationTypesURLRouting"
    static let authenticationTypesEmailAddress: Self = "AuthenticationTypesEmailAddress"
}

extension Target.Dependency {
    static var authentication: Self { .target(name: .authentication) }
    static var authenticationTypes: Self { .target(name: .authenticationTypes) }
    static var authenticationTypesURLRouting: Self { .target(name: .authenticationTypesURLRouting) }
    static var authenticationTypesEmailAddress: Self { .target(name: .authenticationTypesEmailAddress) }
}

extension Target.Dependency {
    static var urlRouting: Self { .product(name: "URLRouting", package: "swift-url-routing") }
    static var emailaddress: Self { .product(name: "EmailAddress", package: "swift-emailaddress-type") }
    static var rfc6750: Self { .product(name: "RFC_6750", package: "swift-rfc-6750") }
    static var rfc7617: Self { .product(name: "RFC_7617", package: "swift-rfc-7617") }
}

let package = Package(
    name: "swift-authentication",
    platforms: [
        .macOS(.v14),
        .iOS(.v17)
    ],
    products: [
        .library(
            name: .authentication,
            targets: [.authentication ]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/pointfreeco/swift-url-routing", from: "0.6.2"),
        .package(url: "https://github.com/coenttb/swift-emailaddress-type", from: "0.0.1"),
        .package(url: "https://github.com/swift-web-standards/swift-rfc-6750", from: "0.0.1"),
        .package(url: "https://github.com/swift-web-standards/swift-rfc-7617", from: "0.0.1"),
    ],
    targets: [
        .target(
            name: .authentication,
            dependencies: [
                .authenticationTypesURLRouting,
                .authenticationTypesEmailAddress,
            ]
        ),
        .target(
            name: .authenticationTypesURLRouting,
            dependencies: [
                .rfc6750,
                .rfc7617,
                .urlRouting
            ]
        ),
        .testTarget(
            name: .authenticationTypesURLRouting.tests,
            dependencies: [
                .authenticationTypesURLRouting
            ]
        ),

        .target(
            name: .authenticationTypesEmailAddress,
            dependencies: [
                .rfc6750,
                .rfc7617,
                .emailaddress
            ]
        ),
        .testTarget(
            name: .authenticationTypesEmailAddress.tests,
            dependencies: [
                .authenticationTypesEmailAddress
            ]
        ),
    ],
    swiftLanguageModes: [.v6]
)

extension String { var tests: Self { self + " Tests" } }
