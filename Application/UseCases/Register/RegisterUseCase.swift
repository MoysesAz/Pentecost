//
//  RegisterUseCase.swift
//  Application
//
//  Created by Moyses Miranda do Vale Azevedo on 22/02/24.
//

import Foundation
import Domain

public struct RegisterUseCase {
    private let repository: AuthRepositoryInterface

    public init(repository: AuthRepositoryInterface) {
        self.repository = repository
    }

    public func register(_ input: LoginInput,
                      completion: @escaping (Result<Bool, Error>) -> Void) {

        repository.createUser(email: input.email, password: input.password) { result in
            switch result {
            case .success(let value):
                completion(.success(value))
            case .failure(let error):
                completion(.failure(error))
            }
        }

    }
}
