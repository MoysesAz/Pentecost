//
//  LoginEntity.swift
//  Domain
//
//  Created by Moyses Miranda do Vale Azevedo on 21/02/24.
//

import SwiftUI

public struct AuthEntity: Codable {
    public let email: String
    public let uuid: String

    public init(email: String, uuid: String) {
        self.email = email
        self.uuid = uuid
    }
}

