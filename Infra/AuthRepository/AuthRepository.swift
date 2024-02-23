//
//  AuthRepository.swift
//  Infra
//
//  Created by Moyses Miranda do Vale Azevedo on 21/02/24.
//

import Foundation
import Domain
import FirebaseAuth
import FirebaseAuthCombineSwift


public enum AuthRepositoryError: Error {
    case anyExpected
}

public class AuthRepository: AuthRepositoryInterface {
    private let share: Auth = Auth.auth()

    public func createUser(email: String,
                           password: String,
                           completion: @escaping (Result<Bool, Error>) -> Void) {
        
        share.createUser(withEmail: email, password: password) { result, error in
            if error != nil {
                completion(.failure(AuthRepositoryError.anyExpected))
            } else {
                completion(.success(true))
            }
        }

    }
    
    public func login(email: String,
                      password: String,
                      completion: @escaping (Result<AuthEntity, Error>) -> Void) {

        share.signIn(withEmail: email, password: password) { result, error in
            if error != nil {
                completion(.failure(AuthRepositoryError.anyExpected))
            } else {
                let auth = AuthEntity(name: result!.user.uid, token: result!.user.refreshToken!)
                completion(.success(auth))
            }
        }

    }



    required public init() {}
}

