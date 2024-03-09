//
//  LoginEntity.swift
//  Domain
//
//  Created by Moyses Miranda do Vale Azevedo on 21/02/24.
//

import SwiftUI

public struct AuthEntity {
    public let email: String
    public let password: String

    public init(email: String, password: String) {
        self.email = email
        self.password = password
    }
}

