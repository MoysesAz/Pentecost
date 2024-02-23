//
//  SignInErros.swift
//  Infra
//
//  Created by Moyses Miranda do Vale Azevedo on 23/02/24.
//

import Foundation

public enum SignInRepositoryErrors: Error {
    case operationNotAllowed
    case invalidEmail
    case userDisabled
    case wrongPassword
    case anyExpected
}
