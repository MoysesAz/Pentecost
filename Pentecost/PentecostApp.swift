//
//  PentecostApp.swift
//  Pentecost
//
//  Created by Moyses Miranda do Vale Azevedo on 04/02/24.
//

import SwiftUI
import Firebase
import Infra
import CoreData

@main
struct PentecostApp: App {

    init() {
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            HomePresentation()
        }
    }
}
