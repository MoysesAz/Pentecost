//
//  CheckUserSessionUseCase.swift
//  Application
//
//  Created by Moyses Miranda do Vale Azevedo on 24/02/24.
//

import Foundation
import Domain

public struct GetAuthenticatedUserUseCase {
    private let repository: AuthRepositoryInterface

    public init(repository: AuthRepositoryInterface) {
        self.repository = repository
    }

    public func handler() -> Bool {
        let result = repository.getAuthenticatedUser()
        guard let user = result else {return false}
        return true
    }
}
