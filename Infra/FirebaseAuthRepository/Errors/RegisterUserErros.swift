//
//  RegisterUserErros.swift
//  Infra
//
//  Created by Moyses Miranda do Vale Azevedo on 23/02/24.
//

import Foundation

public enum RegisterUserErros: Error {
    case invalidEmail
    case emailAlreadyInUse
    case operationNotAllowed
    case weakPassword
    case anyExpected
}
