//
//  File.swift
//  swift-authentication
//
//  Created by Coen ten Thije Boonkkamp on 03/01/2025.
//

import Foundation
import AuthenticationTypes
import URLRouting

extension BearerAuth {
    public struct Router: ParserPrinter, Sendable {
        
        public init() {}
        
        public var body: some ParserPrinter<URLRequestData, BearerAuth> {
            Parse(.memberwise(BearerAuth.init(token:))) {
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
