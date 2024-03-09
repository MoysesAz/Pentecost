//
//  UserPresentation.swift
//  Pentecost
//
//  Created by Moyses Miranda do Vale Azevedo on 09/03/24.
//

import SwiftUI

struct UserPresentation: View {
    @ObservedObject var vm: UserVM
    @State var isShowingAlertlogout = false


    init(vm: UserVM = .init()) {
        self.vm = vm
    }

    var body: some View {
        NavigationStack {
            Text("Future user information screen")
            toolBarView
        }
    }

    var toolBarView: some View {
        Text("")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    settings
                }
            }
    }

    var settings: some View {
        Menu {
            Button(role: .destructive) {
                eventShowAlertLogout()
            } label: {
                Text("Logout")
            }

            Button() {

            } label: {
                Text("Cancel")
            }

        } label: {
            Image(systemName: "line.3.horizontal")
        }
        .alert("Logout",
               isPresented: $isShowingAlertlogout,
               actions: {
            alertLogout
        }, message: {
            Text("Are you sure you want to log out?")
        })
    }

    var alertLogout: some View {
        Button(role: .destructive) {
            vm.eventAlertLogoutConfirm()
        } label: {
            Text("Confirm")
        }
    }

    public func eventShowAlertLogout() {
        isShowingAlertlogout = true
    }
}

#Preview {
    UserPresentation()
}
