//
//  File.swift
//  swift-basic-auth
//
//  Created by Coen ten Thije Boonkkamp on 20/12/2024.
//

import AuthenticationTypes
import EmailAddress

extension BasicAuth {
    public init(
        emailAddress: EmailAddress,
        password: String
    ){
        self = .init(
            username: emailAddress.description,
            password: password
        )
    }
}
