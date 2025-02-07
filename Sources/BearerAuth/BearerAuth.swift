//
//  File.swift
//  swift-authentication
//
//  Created by Coen ten Thije Boonkkamp on 03/01/2025.
//

import Foundation
import URLRouting

public struct BearerAuth: Codable, Hashable, Sendable {
    public let token: String
    
    public init(token: String) {
        self.token = token
    }
    
    public enum CodingKeys: CodingKey {
        case token
    }
}

extension BearerAuth: ExpressibleByStringLiteral {
    public init(stringLiteral value: StringLiteralType) {
        self.token = value
    }
}

