//
//  RegisterVM.swift
//  Pentecost
//
//  Created by Moyses Miranda do Vale Azevedo on 22/02/24.
//

import SwiftUI
import Application
import Infra
import Domain

final class SignUpVM: ObservableObject {
    @Published public var email: String = ""
    @Published public var password: String = ""
    @Published public var confirmPassword: String = ""
    @Published public var errorLogin: String = ""
    public var isRegistering: Binding<Bool>

    private let auth: RegisterUseCase

    public init(isRegistering: Binding<Bool>) {
        let repository = AuthRepository()
        auth = RegisterUseCase(repository: repository)
        self.isRegistering = isRegistering
    }

    public func registerEvent() {
        if password != confirmPassword {
            self.errorLogin = "passwords are different"
            return
        }

        let login = RegisterUseInput(email: email, password: password)
        auth.register(login) { result in
            switch result {
            case .success(let result):
                self.isRegistering.wrappedValue.toggle()
                print(result)
            case .failure(let error):
                self.errorLogin = "Email ou Senha incorretos"
            }
        }
    }

}
