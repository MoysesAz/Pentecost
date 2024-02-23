//
//  InputLogin.swift
//  Application
//
//  Created by Moyses Miranda do Vale Azevedo on 21/02/24.
//

import Foundation

public struct LoginInput {
    public let email: String
    public let password: String

    public init(email: String, password: String) {
        self.email = email
        self.password = password
    }
}
