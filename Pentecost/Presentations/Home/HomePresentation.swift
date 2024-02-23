//
//  HomePresentation.swift
//  Pentecost
//
//  Created by Moyses Miranda do Vale Azevedo on 21/02/24.
//

import SwiftUI

struct HomePresentation: View {
    @State private var isLoggin: Bool = false

    var body: some View {
        if isLoggin {
            BiblePresentation()
        } else {
            SignInPresentation(vm: .init(isLoggin: $isLoggin))
        }
    }
}

#Preview {
    HomePresentation()
}
