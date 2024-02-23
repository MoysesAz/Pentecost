//
//  RegisterPresentation.swift
//  Pentecost
//
//  Created by Moyses Miranda do Vale Azevedo on 22/02/24.
//

import SwiftUI
import Application

struct RegisterPresentation: View {
    @ObservedObject var vm: RegisterVM
    @State var isRegister: Bool = false

    init(vm: RegisterVM) {
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
            if vm.errorLogin != "" {
                Text(vm.errorLogin)
                    .foregroundStyle(.red)
            }
            
            Button {
                vm.registerEvent()
            }label: {
                LabelButtonCTA("Register")
            }
        }
    }
}
