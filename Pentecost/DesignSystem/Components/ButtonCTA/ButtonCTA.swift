//
//  CTAButton.swift
//  Pentecost
//
//  Created by Moyses Miranda do Vale Azevedo on 22/02/24.
//

import SwiftUI

struct ButtonCTA: View {
    private let nameButton: String
    @ObservedObject var vm: ButtonCTAVM
    let action: () -> Void

    init(_ nameButton: String, vm: ButtonCTAVM = .init(isLoading: false, disable: false), action: @escaping () -> Void) {
        self.nameButton = nameButton
        self.vm = vm
        self.action = action
    }

    var body: some View {
        if vm.isLoading {
            progressView
        } else {
            Button {
                action()
            } label: {
                Text(nameButton)
                    .bold()
                    .frame(width: 200, height: 40)
                    .background(
                        RoundedRectangle(cornerRadius: 10, style: .continuous)
                            .foregroundColor(!vm.disable ? .red : .gray)
                    )
                    .foregroundColor(.white)
            }
            .disabled(vm.disable)
        }
    }

    var progressView: some View {
        ProgressView()
            .frame(width: 200, height: 40)
            .background(
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .foregroundColor(.red)
            )
    }
}
