//
//  File.swift
//  swift-authentication
//
//  Created by Coen ten Thije Boonkkamp on 03/01/2025.
//

import Foundation
import RFC_6750
import URLRouting

extension RFC_6750.Bearer {
    public struct Router: URLRouting.ParserPrinter, Sendable {
        
        public init() {}
        
        public var body: some URLRouting.Router<RFC_6750.Bearer> {
            URLRouting.Headers {
                URLRouting.Field("Authorization") {
                    RFC_6750.Bearer.ParserPrinter()
                }
            }
        }
    }
}

extension RFC_6750.Bearer {
    public struct ParserPrinter: URLRouting.ParserPrinter, Sendable {
        
        public init() {}
        
        public var body: some URLRouting.ParserPrinter<Substring, RFC_6750.Bearer> {
            "Bearer "
            URLRouting.Parse(.string)
                .map(
                    .convert(
                        apply: { try? RFC_6750.Bearer.parse(from: "Bearer \($0)") },
                        unapply: \.token
                    )
                )
            
        }
    }
}

