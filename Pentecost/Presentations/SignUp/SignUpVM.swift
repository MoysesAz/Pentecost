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

    private let useCase: RegisterUserUseCase

    public init(isRegistering: Binding<Bool>) {
        useCase = RegisterUserUseCase()
        self.isRegistering = isRegistering
    }

    public func registerEvent() {
        if password != confirmPassword {
            self.errorRegister = "passwords are different"
            return
        }

        let login = RegisterUseInput(email: email, password: password)
        useCase.handler(login) { result in
            switch result {
            case .success(let result):
                self.isRegistering.wrappedValue.toggle()
            case .failure(let error):
                let translateError = error as! RegisterUserErrors
                self.handleRegisterUserError(translateError)
            }
        }
    }

    func handleRegisterUserError(_ error: RegisterUserErrors) {
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
