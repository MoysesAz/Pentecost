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

    required public init() {}

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

    public func getAuthenticatedUser() -> Domain.AuthEntity? {
        guard let user = share.currentUser else { return nil }
        return AuthEntity(email: user.email!,
                          password: user.uid)
    }

    public func getAuthenticatedUserObserver(completion: @escaping (Result<Domain.AuthEntity, Error>) -> Void) {
        share.addStateDidChangeListener { auth, user in
            guard auth != nil else {
                completion(.failure(AuthRepositoryError.userNotFound))
                return
            }

            guard let user = user  else {
                completion(.failure(AuthRepositoryError.userNotFound))
                return
            }

            let result = AuthEntity(email: user.email!,
                              password: user.uid)

            completion(.success(result))
        }
    }

    public func logout() {
        do {
          try share.signOut()
        } catch let signOutError as NSError {
          print("Error signing out: %@", signOutError)
        }
    }

}



