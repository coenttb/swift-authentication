//
//  File.swift
//  swift-authentication
//
//  Created by Coen ten Thije Boonkkamp on 03/01/2025.
//

import Foundation
import URLRouting

extension BearerAuth {
    public struct Router: ParserPrinter {
        
        public init() {}
        
        public var body: some URLRouting.Router<BearerAuth> {
            Parse(.memberwise(BearerAuth.init)) {
                Headers {
                    Field("Authorization") {
                        "Bearer "
                        Parse(.string)
                    }
                }
            }
        }
    }
}
