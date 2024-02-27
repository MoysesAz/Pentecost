//
//  HomePresentation.swift
//  Pentecost
//
//  Created by Moyses Miranda do Vale Azevedo on 21/02/24.
//

import SwiftUI
import KeychainSwift
import Firebase

struct HomePresentation: View {
    @ObservedObject var vm: HomeVM
    

    init(vm: HomeVM = .init()) {
        self.vm = vm
        self.vm.authenticatedUser()
    }

    var body: some View {
        if vm.isLoggin {
            BiblePresentation()
        } else {
            SignInPresentation(vm: .init(isLoggin: vm.isLoggin))
        }
    }
}

//#Preview {
//    HomePresentation()
//}
