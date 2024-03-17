//
//  AuthRepository+.swift
//  Infra
//
//  Created by Moyses Miranda do Vale Azevedo on 23/02/24.
//

import Foundation
import Firebase

extension FirebaseAuthRepository {

    public func signInErrors(error: Error) -> SignInRepositoryErrors {
        if let error = error as NSError? {
            switch AuthErrorCode.Code(rawValue: error.code) {
            case .operationNotAllowed:
                return .operationNotAllowed
            case .invalidEmail:
                return .invalidEmail
            case .userDisabled:
                return .userDisabled
            case .wrongPassword:
                return .wrongPassword
            default:
                return .anyExpected
            }
        }
        return .anyExpected
    }

}
