//
//  LabelButtonSecondy.swift
//  Pentecost
//
//  Created by Moyses Miranda do Vale Azevedo on 22/02/24.
//

import SwiftUI

struct LabelButtonSecondy: View {
    private let nameButton: String

    init(_ nameButton: String) {
        self.nameButton = nameButton
    }

    var body: some View {
        Text(nameButton)
            .bold()
            .frame(width: 200, height: 40)
            .background(
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .foregroundColor(.gray)
            )
            .foregroundColor(.white)
    }
}

#Preview {
    LabelButtonSecondy("teste")
}
