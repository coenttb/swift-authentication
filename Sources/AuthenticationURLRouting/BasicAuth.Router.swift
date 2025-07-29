//
//  File.swift
//  swift-basic-auth
//
//  Created by Coen ten Thije Boonkkamp on 20/12/2024.
//

import Foundation
import RFC_7617
import URLRouting

extension RFC_7617.Basic {
    public struct Router: URLRouting.ParserPrinter, Sendable {
        
        public init(){}
        
        public var body: some URLRouting.Router<RFC_7617.Basic> {
            URLRouting.Headers {
                URLRouting.Field("Authorization") {
                    RFC_7617.Basic.ParserPrinter()
                }
            }
        }
    }
}

extension RFC_7617.Basic {
    public struct ParserPrinter: URLRouting.ParserPrinter, Sendable {
        
        public init(){}
        
        public var body: some URLRouting.ParserPrinter<Substring, RFC_7617.Basic> {
            "Basic "
            URLRouting.Parse(.string)
                .map(
                    .convert(
                        apply: { try? RFC_7617.Basic.parse(from: "Basic \($0)") },
                        unapply: { $0.encoded() }
                    )
                )
            
        }
    }
}

