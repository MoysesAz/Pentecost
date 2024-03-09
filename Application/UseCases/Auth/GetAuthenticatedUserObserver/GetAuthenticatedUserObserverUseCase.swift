//
//  GetAuthenticatedUserObserverUseCase.swift
//  Application
//
//  Created by Moyses Miranda do Vale Azevedo on 27/02/24.
//

import Foundation
import Infra
import Domain

public struct GetAuthenticatedUserObserverUseCase {
    private let repository: AuthRepositoryInterface

    public init(repository: AuthRepositoryInterface) {
        self.repository = repository
    }

    public func handler(completion: @escaping (Result<AuthEntity, Error>) -> Void) {

        repository.getAuthenticatedUserObserver { result in
            switch result {
            case .success(let value):
                completion(.success(value))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
