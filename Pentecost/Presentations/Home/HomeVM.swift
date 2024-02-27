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

final class HomeVM: ObservableObject {
    @Published public var isLoggin: Bool = false
    private let useCase: GetAuthenticatedUserUseCase

    public init() {
        let repository = AuthRepository()
        useCase = GetAuthenticatedUserUseCase(repository: repository)
    }

    public func authenticatedUser() {
        isLoggin = useCase.handler()
    }



}
