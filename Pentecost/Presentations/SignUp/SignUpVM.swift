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
    @Published public var errorRegister: String = ""
    public var isRegistering: Binding<Bool>

    private let auth: RegisterUseCase

    public init(isRegistering: Binding<Bool>) {
        let repository = AuthRepository()
        auth = RegisterUseCase(repository: repository)
        self.isRegistering = isRegistering
    }

    public func registerEvent() {
        if password != confirmPassword {
            self.errorRegister = "passwords are different"
            return
        }

        let login = RegisterUseInput(email: email, password: password)
        auth.register(login) { result in
            switch result {
            case .success(let result):
                self.isRegistering.wrappedValue.toggle()
                print(result)
            case .failure(let error):
                let translateError = error as! RegisterUserErros
                self.handleRegisterUserError(translateError)
            }
        }
    }

    func handleRegisterUserError(_ error: RegisterUserErros) {
        switch error {
        case .invalidEmail:
            errorRegister = "Email não esta nos padrões"
        case .emailAlreadyInUse:
            errorRegister = "Email já registrado"
        case .operationNotAllowed:
            errorRegister = "Não estamos realiando casdatro por email no momento, tente por outra forma"
        case .weakPassword:
            errorRegister = "Senha muito fraca"
        case .anyExpected:
            errorRegister = "Erro não esperado"
        default:
            errorRegister = "Erro não esperado"
        }
    }
}
