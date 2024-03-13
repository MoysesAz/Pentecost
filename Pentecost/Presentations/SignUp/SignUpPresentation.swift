//
//  RegisterPresentation.swift
//  Pentecost
//
//  Created by Moyses Miranda do Vale Azevedo on 22/02/24.
//

import SwiftUI
import Application
import KeychainSwift

struct SignUpPresentation: View {
    @ObservedObject var vm: SignUpVM
    @State var isRegister: Bool = false

    init(vm: SignUpVM) {
        self.vm = vm
    }

    var body: some View {
        register
    }

    var register: some View {
        VStack {
            TextField("Email", text: $vm.email)
                .modifier(TextFieldMod())
            SecureField("Password", text: $vm.password)
                .modifier(TextFieldMod())
            SecureField("ConfirmPassword", text: $vm.confirmPassword)
                .modifier(TextFieldMod())
            if vm.errorRegister != "" {
                Text(vm.errorRegister)
                    .foregroundStyle(.red)
            }
            
            ButtonCTA("Register") {
                vm.registerEvent()
            }
        }
    }
}
