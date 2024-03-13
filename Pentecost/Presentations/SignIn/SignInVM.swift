//
//  LoginVM.swift
//  Pentecost
//
//  Created by Moyses Miranda do Vale Azevedo on 21/02/24.
//

import SwiftUI
import Application
import Infra
import Domain

final class SignInVM: ObservableObject {
    @Published public var email: String = ""
    @Published public var password: String = ""
    @Published public var errorLogin: String = ""
    public var disable: Bool {
        get {
            email == "" || password == "" ? true : false
        }
    }

    public var isLoading: Bool = false
    public var isLoggin: Bool
    private let useCase: SignInUseCase

    public init(isLoggin: Bool) {
        let repository = AuthRepository()
        useCase = SignInUseCase(repository: repository)
        self.isLoggin = isLoggin
    }

    public func singInEvent() {
        isLoading = true
        let login = SignInInput(email: email, password: password)
        useCase.handler(login) { result in
            switch result {
            case .success(let result):
                self.isLoggin.toggle()
                self.isLoading = false
            case .failure(let error):
                self.errorLogin = "Email ou Senha incorretos"
                self.isLoading = false
            }
        }
    }

}
