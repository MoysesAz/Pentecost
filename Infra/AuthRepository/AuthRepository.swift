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
import KeychainSwift

public class AuthRepository: AuthRepositoryInterface {
    private let share: Auth = Auth.auth()
    private let keychain: KeychainSwift = KeychainSwift()

    public func registerUser(email: String,
                           password: String,
                           completion: @escaping (Result<Bool, Error>) -> Void) {
        
        share.createUser(withEmail: email, password: password) { result, error in
            if error != nil {
                let translateError = self.registerUserErrors(error: error!)
                completion(.failure(translateError))
            } else {
                completion(.success(true))
            }
        }

    }

    public func getAuthenticatedUser() -> Domain.AuthEntity? {
        guard let user = share.currentUser else { return nil }
        return AuthEntity(email: user.email!,
                          password: user.uid)
    }

    public func signIn(_ token: String, completion: @escaping (Result<Domain.AuthEntity, Error>) -> Void) {
        share.signIn(withCustomToken: token) { result, error in
            if error != nil {
                let translateError = self.signInErrors(error: error!)
                completion(.failure(translateError))

            } else {
                guard let refreshToken = result?.user.refreshToken else {
                    completion(.failure(SignInRepositoryErrors.anyExpected))
                    return
                }
                self.keychain.set(refreshToken, forKey: "refreshToken")
                let auth = AuthEntity(email: result!.user.email!, password: result!.user.uid)
                completion(.success(auth))
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

                result?.user.getIDToken() { token, tokenError  in
                    if tokenError != nil {
                        completion(.failure(SignInRepositoryErrors.anyExpected))
                    } else {
                        if token != nil {
                            self.keychain.set(token!, forKey: "authToken")
                        }
                        completion(.failure(SignInRepositoryErrors.tokenDisabled))
                    }
                }

                guard let refreshToken = result?.user.refreshToken else {return }

                self.keychain.set(refreshToken, forKey: "refreshToken")

                let auth = AuthEntity(email: result!.user.email!, password: result!.user.uid)

                completion(.success(auth))
            }
        }
    }

    required public init() {}
    
    private func saveTokens(_ token: String, refreshToken: String) {
        let keychain = KeychainSwift()
        keychain.set("token", forKey: token)
        keychain.set("refreshToken", forKey: refreshToken)
    }

}



