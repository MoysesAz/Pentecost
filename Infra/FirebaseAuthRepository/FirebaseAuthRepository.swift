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

final public class FirebaseAuthRepository: AuthRepositoryInterface {
    private let keychain: KeychainRepositoryInterface

    public init(_ keychain: Domain.KeychainRepositoryInterface = KeychainRepository()) {
        self.keychain = keychain
    }
    

    public func registerUser(email: String,
                           password: String,
                           completion: @escaping (Result<Bool, Error>) -> Void) {

        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                completion(.failure(error))
            }
            completion(.success(true))
        }
    }

    public func signIn(_ token: String, completion: @escaping (Result<Domain.AuthEntity, Error>) -> Void) {
        Auth.auth().signIn(withCustomToken: token) { result, error in
            if error != nil {
                let translateError = self.signInErrors(error: error!)
                completion(.failure(translateError))
                return
            }

            guard let refreshToken = result?.user.refreshToken else {
                completion(.failure(SignInRepositoryErrors.anyExpected))
                return
            }
            self.keychain.saveRefreshToken(refreshToken)
            let auth = AuthEntity(email: result!.user.email!, uuid: result!.user.uid)

            if self.keychain.saveUserKeychain(auth) {
                completion(.success(auth))
                return
            }

            completion(.failure(SignInRepositoryErrors.anyExpected))
        }
    }

    public func signIn(email: String,
                      password: String,
                      completion: @escaping (Result<AuthEntity, Error>) -> Void) {

        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if error != nil {
                let translateError = self.signInErrors(error: error!)
                completion(.failure(translateError))
                return
            }

            result?.user.getIDToken() { token, tokenError  in
                if tokenError != nil {
                    completion(.failure(SignInRepositoryErrors.anyExpected))
                    return
                }
                
                if token != nil {
                    self.keychain.saveAuthToken(token!)
                }

                completion(.failure(SignInRepositoryErrors.tokenDisabled))
                return
            }

            guard let refreshToken = result?.user.refreshToken else {return }

            self.keychain.saveRefreshToken(refreshToken)

            let auth = AuthEntity(email: result!.user.email!, uuid: result!.user.uid)

            if self.keychain.saveUserKeychain(auth) {
                completion(.success(auth))
                return
            }

            completion(.failure(SignInRepositoryErrors.anyExpected))
        }
    }

    public func getAuthenticatedUser() -> Domain.AuthEntity? {
        guard let user = Auth.auth().currentUser else { return nil }
        let auth = AuthEntity(email: user.email!, uuid: user.uid)

        if self.keychain.saveUserKeychain(auth) {
            return AuthEntity(email: user.email!,
                              uuid: user.uid)
        }

        return nil
    }

    public func getAuthenticatedUserObserver(completion: @escaping (Result<Domain.AuthEntity, Error>) -> Void) {
        Auth.auth().addStateDidChangeListener { auth, user in
            guard auth != nil else {
                completion(.failure(AuthRepositoryError.userNotFound))
                return
            }

            guard let user = user  else {
                completion(.failure(AuthRepositoryError.userNotFound))
                return
            }

            let auth = AuthEntity(email: user.email!,
                                    uuid: user.uid)

            completion(.success(auth))
            return
        }
    }

    public func logout() {
        do {
            try Auth.auth().signOut()
            keychain.clearKeychain()

        } catch let signOutError as NSError {
          print("Error signing out: %@", signOutError)
        }
    }
}
