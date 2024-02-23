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
    public var isLoggin: Binding<Bool>

    private let auth: AuthUseCase

    public init(isLoggin: Binding<Bool>) {
        let repository = AuthRepository()
        auth = AuthUseCase(repository: repository)
        self.isLoggin = isLoggin
    }

    public func singUpEvent() {
        let login = LoginInput(email: email, password: password)
        auth.singIn(login) { result in
            switch result {
            case .success(let result):
                self.isLoggin.wrappedValue.toggle()
                print(result)
            case .failure(let error):
                self.errorLogin = "Email ou Senha incorretos"
            }
        }
    }

}
