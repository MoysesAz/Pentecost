//
//  File.swift
//  Infra
//
//  Created by Moyses Miranda do Vale Azevedo on 17/03/24.
//

import Foundation
import Firebase
import Domain

public class FirebaseErrorHandler: RegisterUserErrorsInterface {
    public init() {}
    public func handleError(_ error: Error) -> RegisterUserErrors {
        if let error = error as NSError? {
            switch AuthErrorCode.Code(rawValue: error.code) {
            case .invalidEmail:
                return .invalidEmail
            case .emailAlreadyInUse:
                return .emailAlreadyInUse
            case .operationNotAllowed:
                return .operationNotAllowed
            case .weakPassword:
                return .weakPassword
            default:
                return .anyExpected
            }
        } else {
            fatalError("The error must be able to be transformed into a FIRAuthErrorDomain")
        }
    }
}
