//
//  RegisterUserErros.swift
//  Domain
//
//  Created by Moyses Miranda do Vale Azevedo on 17/03/24.
//

import Foundation

public enum RegisterUserErrors: Error {
    case invalidEmail
    case emailAlreadyInUse
    case operationNotAllowed
    case weakPassword
    case anyExpected
}
