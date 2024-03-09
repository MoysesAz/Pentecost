//
//  LogoutUseCase.swift
//  Application
//
//  Created by Moyses Miranda do Vale Azevedo on 09/03/24.
//

import Foundation
import Infra
import Domain

public struct LogoutUseCase {
    private let repository: AuthRepositoryInterface

    public init(repository: AuthRepositoryInterface) {
        self.repository = repository
    }

    public func handler() {
        repository.logout()
    }
}
