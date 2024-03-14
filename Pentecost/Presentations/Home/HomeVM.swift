//
//  HomeVM.swift
//  Pentecost
//
//  Created by Moyses Miranda do Vale Azevedo on 24/02/24.
//

import SwiftUI
import Application
import Infra
import Domain
import KeychainSwift
import Combine

final class HomeVM: ObservableObject {
    @Published public var isLoggin: Bool = false
    @Published private var authEntity: AuthEntity? = nil
    @Published public var auth: ()?
    @Published public var inAnimationTabView: Bool = true
    private let useCase: GetAuthenticatedUserObserverUseCase

    public init() {
        let repository = AuthRepository()
        useCase = .init(repository: repository)
        auth = authenticatedUser()
    }

    public func authenticatedUser() {
        useCase.handler() { result in
            switch result {
            case .failure(let error):
                self.isLoggin = false
            case .success(let result):
                self.authEntity = result
                DispatchQueue.global().asyncAfter(deadline: .now() + 2) {
                    DispatchQueue.main.async {
                        self.isLoggin = true
                    }
                }
            }
        }
    }
}
