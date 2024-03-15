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
            ZStack {
                tabView
                    .opacity(vm.inAnimationTabView ? 0 : 1)
                ProgressView()
                    .opacity(vm.inAnimationTabView ? 1 : 0)
                    .task {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                            vm.inAnimationTabView = false
                        }
                    }

            }
            .onAppear {
                vm.inAnimationTabView = true
            }
        } else {
            signInPresentation
        }
    }

    var signInPresentation: some View {
        SignInPresentation(vm: .init(isLoggin: vm.isLoggin))
    }

    var tabView: some View {
        TabView {
            BiblePresentation()
                .tabItem {
                    Image(systemName: "book")
                    Text("Bible")
                }
            StatisticsPresentation()
                .tabItem {
                    Image(systemName: "chart.xyaxis.line")
                    Text("Statistics")
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
