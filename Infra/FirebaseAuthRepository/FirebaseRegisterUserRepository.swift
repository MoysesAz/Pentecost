//
//  teste.swift
//  Infra
//
//  Created by Moyses Miranda do Vale Azevedo on 18/03/24.
//

import Foundation
import Domain
import FirebaseAuth

public struct FirebaseRegisterUserRepository: RegisterUserAuthRepositoryInterface {
    public init() {}
    public func registerUser(email: String, password: String, completion: @escaping (Result<Bool, any Error>) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                completion(.failure(error))
            }
            completion(.success(true))
        }
    }
}
