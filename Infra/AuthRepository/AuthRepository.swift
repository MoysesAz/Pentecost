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

public class AuthRepository: AuthRepositoryInterface {
    private let share: Auth = Auth.auth()

    public func registerUser(email: String,
                           password: String,
                           completion: @escaping (Result<Bool, Error>) -> Void) {
        
        share.createUser(withEmail: email, password: password) { result, error in
            if error != nil {
                let translateError = self.signInErrors(error: error!)
                completion(.failure(translateError))
            } else {
                completion(.success(true))
            }
        }

    }
    
    public func signIn(email: String,
                      password: String,
                      completion: @escaping (Result<AuthEntity, Error>) -> Void) {

        share.signIn(withEmail: email, password: password) { result, error in
            if error != nil {
                let translateError = self.signInErrors(error: error!)
                completion(.failure(translateError))
            } else {
                let auth = AuthEntity(name: result!.user.uid, token: result!.user.refreshToken!)

                completion(.success(auth))
            }
        }
    }

    required public init() {}
}



