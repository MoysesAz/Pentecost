//
//  LoginEntity.swift
//  Domain
//
//  Created by Moyses Miranda do Vale Azevedo on 21/02/24.
//

import SwiftUI

public struct AuthEntity {
    public let name: String
    public let token: String

    public init(name: String, token: String) {
        self.name = name
        self.token = token
    }
}

