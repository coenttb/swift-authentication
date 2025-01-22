//
//  File.swift
//  coenttb-mailgun
//
//  Created by Coen ten Thije Boonkkamp on 20/12/2024.
//
import URLRouting
import BearerAuth
import Foundation
import Dependencies

#if canImport(FoundationNetworking)
import FoundationNetworking
#endif


@dynamicMemberLookup
public struct Client<
    Auth: Equatable & Sendable,
    AuthRouter: ParserPrinter & Sendable,
    API: Equatable & Sendable,
    APIRouter: ParserPrinter & Sendable,
    ClientOutput: Sendable
>: Sendable
where
APIRouter.Input == URLRequestData,
APIRouter.Output == API,
AuthRouter.Input == URLRequestData,
AuthRouter.Output == Auth
{
    public typealias AuthenticatedRouter = Authentication.API<Auth, API>.Router<AuthRouter, APIRouter>
    
    private let baseURL: URL
    private let auth: Auth
    
    private let session: @Sendable (URLRequest) async throws -> (Data, URLResponse)
    private let router: APIRouter
    private let buildClient: @Sendable (@escaping @Sendable (API) throws -> URLRequest) -> ClientOutput
    private let authenticatedRouter: Authentication.API<Auth, API>.Router<AuthRouter, APIRouter>
    
    public init(
        baseURL: URL,
        auth: Auth,
        session: @escaping @Sendable (URLRequest) async throws -> (Data, URLResponse) = { request in try await URLSession.shared.data(for: request) },
        router: APIRouter,
        authRouter: AuthRouter,
        buildClient: @escaping @Sendable (@escaping @Sendable (API) throws -> URLRequest) -> ClientOutput
    ) {
        self.baseURL = baseURL
        self.auth = auth
        self.session = session
        self.router = router
        self.buildClient = buildClient
        self.authenticatedRouter = Authentication.API.Router(
            baseURL: baseURL,
            authRouter: authRouter,
            router: router
        )
    }
    
    public subscript<T>(dynamicMember keyPath: KeyPath<ClientOutput, T>) -> T {
        @Sendable
        func makeRequest(for api: API) throws -> URLRequest {
            do {
                let data = try authenticatedRouter.print(.init(auth: auth, api: api))
                
                guard let request = URLRequest(data: data) else {
                    throw Error.requestError
                }
                
                return request
            } catch {
                throw Error.printError
            }
        }
        
        return buildClient(makeRequest)[keyPath: keyPath]
    }
}



public enum Error: Swift.Error {
    case printError
    case requestError
}


