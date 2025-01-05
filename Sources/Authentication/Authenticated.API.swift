//
//  File.swift
//  coenttb-stripe
//
//  Created by Coen ten Thije Boonkkamp on 05/01/2025.
//

import BearerAuth
import BasicAuth
import URLRouting
import Foundation
import Dependencies
import Coenttb_Web

#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

public struct API<
    Auth: Equatable & Sendable,
    OtherAPI: Equatable & Sendable
> {
    let auth: Auth
    let api: OtherAPI
    
    public init(auth: Auth, api: OtherAPI) {
        self.auth = auth
        self.api = api
    }
}

extension API where Auth == BearerAuth {
    public init(apiKey: String, api: OtherAPI) {
        self.auth = .init(token: apiKey)
        self.api = api
    }
}

extension Authentication.API {
    public struct Router<
        AuthRouter: ParserPrinter & Sendable,
        OtherAPIRouter: ParserPrinter & Sendable
    >: ParserPrinter, Sendable
    where
    OtherAPIRouter.Input == URLRequestData,
    OtherAPIRouter.Output == OtherAPI,
    AuthRouter.Input == URLRequestData,
    AuthRouter.Output == Auth
    {
        
        let baseURL: URL
        let authRouter: AuthRouter
        let router: OtherAPIRouter
        
        public init(
            baseURL: URL,
            authRouter: AuthRouter,
            router: OtherAPIRouter
        ) {
            self.baseURL = baseURL
            self.authRouter = authRouter
            self.router = router
        }
        
        public var body: some URLRouting.Router<Authentication.API<Auth, OtherAPI>> {
            Parse(.memberwise(Authentication.API<Auth, OtherAPI>.init)) {
                authRouter
                
                router
            }
            .baseURL(self.baseURL.absoluteString)
        }
    }
}

