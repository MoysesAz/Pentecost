//
//  RegisterUseCase.swift
//  Application
//
//  Created by Moyses Miranda do Vale Azevedo on 22/02/24.
//

import Foundation
import Domain
import Infra

public struct RegisterUserUseCase {
    private let repository: RegisterUserAuthRepositoryInterface
    private let error: RegisterUserErrorsInterface

    public init(repository: RegisterUserAuthRepositoryInterface = FirebaseRegisterUserRepository(), error: RegisterUserErrorsInterface = FirebaseErrorHandler()) {
        self.repository = repository
        self.error = error
    }

    public func handler(_ input: RegisterUseInput,
                      completion: @escaping (Result<Bool, Error>) -> Void) {

        repository.registerUser(email: input.email, password: input.password) { result in
            switch result {
            case .success(let value):
                completion(.success(value))
            case .failure(let error):
                let translateError = self.error.handleError(error)
                completion(.failure(translateError))
            }
        }
    }
}

