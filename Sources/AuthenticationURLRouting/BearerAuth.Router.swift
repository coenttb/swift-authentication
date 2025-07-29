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
    public struct Router: ParserPrinter, Sendable {
        
        public init() {}
        
        public var body: some ParserPrinter<URLRequestData, RFC_6750.Bearer> {
            Parse(.memberwise(RFC_6750.Bearer.init(token:))) {
                URLRouting.Headers {
                    URLRouting.Field("Authorization") {
                        "Bearer "
                        Parse(.string)
                    }
                }
            }
        }
    }
}

