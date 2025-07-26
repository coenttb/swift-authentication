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
    static var dependencies: Self { .product(name: "Dependencies", package: "swift-dependencies") }
    static var emailaddress: Self { .product(name: "EmailAddress", package: "swift-emailaddress-type") }
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
            targets: [
                .authentication,
                .authenticationTypes,
                .authenticationTypesURLRouting
            ]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/pointfreeco/swift-url-routing", from: "0.6.0"),
        .package(url: "https://github.com/pointfreeco/swift-dependencies", from: "1.6.0"),
        .package(url: "https://github.com/coenttb/swift-emailaddress-type", from: "0.0.1"),
    ],
    targets: [
        .target(
            name: .authentication,
            dependencies: [
                .authenticationTypes,
                .authenticationTypesURLRouting,
                .authenticationTypesEmailAddress,
            ]
        ),
        .target(
            name: .authenticationTypes,
            dependencies: []
        ),
        .testTarget(
            name: .authenticationTypes.tests,
            dependencies: [
                .authenticationTypes
            ]
        ),
        .target(
            name: .authenticationTypesURLRouting,
            dependencies: [
                .authenticationTypes,
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
                .authenticationTypes,
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
