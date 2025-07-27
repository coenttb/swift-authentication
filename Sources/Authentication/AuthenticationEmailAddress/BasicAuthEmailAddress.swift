//
//  File.swift
//  swift-basic-auth
//
//  Created by Coen ten Thije Boonkkamp on 20/12/2024.
//

import RFC_7617
import EmailAddress

extension RFC_7617.Basic {
    public init(
        emailAddress: EmailAddress,
        password: String
    ) throws {
        self = try .init(
            username: emailAddress.description,
            password: password
        )
    }
}
