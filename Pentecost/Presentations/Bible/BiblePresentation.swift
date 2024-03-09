//
//  BooksPresentation.swift
//  Pentecost
//
//  Created by Moyses Miranda do Vale Azevedo on 05/02/24.
//

import SwiftUI

struct BiblePresentation: View {
    let vm = BibleVM()

    var body: some View {
        NavigationStack {
            List {
                ForEach(0..<vm.bibleXML.books.count, id: \.self) { index in
                    NavigationLink {
                        BookPresentation(bibleXML: vm.bibleXML, number: index)
                    } label: {
                        Text(vm.bibleXML.nameBooks[index])
                    }
                }
            }
            .navigationTitle("Books")
        }
    }
}

#Preview {
    BiblePresentation()
}
