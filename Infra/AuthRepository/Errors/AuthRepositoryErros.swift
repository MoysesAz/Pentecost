//
//  AuthRepositoryErros.swift
//  Infra
//
//  Created by Moyses Miranda do Vale Azevedo on 23/02/24.
//

import Foundation

public enum AuthRepositoryError: Error {
    case networkError
    case userNotFound
    case credentialsInvalid
    case anyExpected
}
