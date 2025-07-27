// swift-tools-version:6.0

import Foundation
import PackageDescription

extension String {
    static let authentication: Self = "Authentication"
    static let authenticationURLRouting: Self = "AuthenticationURLRouting"
    static let authenticationEmailAddress: Self = "AuthenticationEmailAddress"
}

extension Target.Dependency {
    static var authentication: Self { .target(name: .authentication) }
//    static var authenticationURLRouting: Self { .target(name: .authenticationURLRouting) }
//    static var authenticationEmailAddress: Self { .target(name: .authenticationEmailAddress) }
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
//                .authenticationURLRouting,
//                .authenticationEmailAddress,
                .rfc6750,
                .rfc7617,
                .urlRouting,
                .emailaddress
            ]
        ),
//        .target(
//            name: .authenticationURLRouting,
//            dependencies: [
//                .rfc6750,
//                .rfc7617,
//                .urlRouting
//            ]
//        ),
//        .testTarget(
//            name: .authenticationURLRouting.tests,
//            dependencies: [
//                .authenticationURLRouting
//            ]
//        ),
//        .target(
//            name: .authenticationEmailAddress,
//            dependencies: [
//                .rfc6750,
//                .rfc7617,
//                .emailaddress
//            ]
//        ),
//        .testTarget(
//            name: .authenticationEmailAddress.tests,
//            dependencies: [
//                .authenticationEmailAddress
//            ]
//        ),
    ],
    swiftLanguageModes: [.v6]
)

extension String { var tests: Self { self + " Tests" } }
