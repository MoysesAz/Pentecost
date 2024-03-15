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

final public class AuthRepository: AuthRepositoryInterface {
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
                return
            }

            completion(.success(true))
            return
        }
    }

    public func signIn(_ token: String, completion: @escaping (Result<Domain.AuthEntity, Error>) -> Void) {
        share.signIn(withCustomToken: token) { result, error in
            if error != nil {
                let translateError = self.signInErrors(error: error!)
                completion(.failure(translateError))
                return
            }

            guard let refreshToken = result?.user.refreshToken else {
                completion(.failure(SignInRepositoryErrors.anyExpected))
                return
            }
            self.saveRefreshToken(refreshToken)
            let auth = AuthEntity(email: result!.user.email!, uuid: result!.user.uid)

            if self.saveUserKeychain(auth) {
                completion(.success(auth))
                return
            }

            completion(.failure(SignInRepositoryErrors.anyExpected))
        }
    }

    public func signIn(email: String,
                      password: String,
                      completion: @escaping (Result<AuthEntity, Error>) -> Void) {

        share.signIn(withEmail: email, password: password) { result, error in
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
                    self.saveAuthToken(token!)
                }

                completion(.failure(SignInRepositoryErrors.tokenDisabled))
                return
            }

            guard let refreshToken = result?.user.refreshToken else {return }

            self.saveRefreshToken(refreshToken)

            let auth = AuthEntity(email: result!.user.email!, uuid: result!.user.uid)

            if self.saveUserKeychain(auth) {
                completion(.success(auth))
                return
            }

            completion(.failure(SignInRepositoryErrors.anyExpected))
        }
    }

    public func getAuthenticatedUser() -> Domain.AuthEntity? {
        guard let user = share.currentUser else { return nil }
        let auth = AuthEntity(email: user.email!, uuid: user.uid)

        if self.saveUserKeychain(auth) {
            return AuthEntity(email: user.email!,
                              uuid: user.uid)
        }

        return nil
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

            let auth = AuthEntity(email: user.email!,
                                    uuid: user.uid)

            completion(.success(auth))
            return
        }
    }

    public func logout() {
        do {
            try share.signOut()
            clearKeychain()

        } catch let signOutError as NSError {
          print("Error signing out: %@", signOutError)
        }
    }
    
    private func saveUserKeychain(_ user: AuthEntity) -> Bool {
        do {
            let jsonData = try JSONEncoder().encode(user)
            let jsonString = String(data: jsonData, encoding: .utf8)
            if jsonString != "" {
                keychain.set(jsonData, forKey: "user")
                return true
            }
            return false
        } catch {
            print("Erro ao codificar objeto em JSON: \(error)")
            return false
        }

    }

    private func saveAuthToken(_ token: String) {
        self.keychain.set(token, forKey: "authToken")
    }

    private func saveRefreshToken(_ token: String) {
        self.keychain.set(token, forKey: "refreshToken")
    }

    private func clearKeychain() {
        keychain.clear()
    }
}



