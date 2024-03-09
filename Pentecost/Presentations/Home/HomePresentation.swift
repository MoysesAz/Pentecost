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
    }

    var body: some View {
        if vm.isLoggin {
            tabView
        } else {
            SignInPresentation(vm: .init(isLoggin: vm.isLoggin))
        }
    }

    var tabView: some View {
        TabView {
            BiblePresentation()
                .tabItem {
                    Image(systemName: "book")
                    Text("Bible")
                }
            UserPresentation()
                .tabItem {
                    Image(systemName: "person")
                    Text("User")
                }
        }
    }
}

//#Preview {
//    HomePresentation()
//}
