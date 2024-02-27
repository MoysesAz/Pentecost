//
//  SignInToken.swift
//  Application
//
//  Created by Moyses Miranda do Vale Azevedo on 24/02/24.
//

import Foundation
import Domain

public struct SignInTokenUseCase {
    private let repository: AuthRepositoryInterface

    public init(repository: AuthRepositoryInterface) {
        self.repository = repository
    }

    public func handler(_ token: String,
                      completion: @escaping (Result<AuthEntity, Error>) -> Void) {

        repository.signIn(token) { result in
            switch result {
            case .success(let value):
                print("deu certo")
                completion(.success(value))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
