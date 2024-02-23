//
//  Login.swift
//  Pentecost
//
//  Created by Moyses Miranda do Vale Azevedo on 21/02/24.
//

import SwiftUI
import Application

struct SignInPresentation: View {
    @ObservedObject var vm: SignInVM
    @State var isRegistering: Bool = false

    init(vm: SignInVM) {
        self.vm = vm
    }

    var body: some View {
        singInView
            .sheet(isPresented: $isRegistering) {
                registerView
            }
    }

    var registerView: some View {
        SignUpPresentation(vm: .init(isRegistering: $isRegistering))
            .presentationDragIndicator(.visible)
    }

    var singInView: some View {
        VStack {
            TextField("Email", text: $vm.email)
                .modifier(TextFieldMod())
            SecureField("Password", text: $vm.password)
                .modifier(TextFieldMod())

            if vm.errorLogin != "" {
                Text(vm.errorLogin)
                    .foregroundStyle(.red)
            }

            Button {
                vm.singUpEvent()
            } label: {
                LabelButtonCTA("Sing In")
            }

            Button {
                isRegistering.toggle()
            } label: {
                Text("Already have an account? Login")
                    .padding()
            }
        }
    }

}

