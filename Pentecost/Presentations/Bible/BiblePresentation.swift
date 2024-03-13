//
//  BooksPresentation.swift
//  Pentecost
//
//  Created by Moyses Miranda do Vale Azevedo on 05/02/24.
//

import SwiftUI
import SwiftUI

struct BiblePresentation: View {
    let vm = BibleVM()
    @State var searchBook: String = ""

    var body: some View {
        NavigationStack {
            if searchBook != "" &&
                vm.bibleXML.nameBooks.filter({ $0.contains(searchBook) }).count == 0 {
                    noSerchBook
                } else {
                    List {
                        ForEach(0..<vm.bibleXML.books.count, id: \.self) { index in
                            if searchBook.isEmpty || vm.bibleXML.nameBooks[index].contains(searchBook) {
                                navigationLink(for: index)
                            }
                        }
                    }
                    .navigationTitle("Books")
                }
            

        }
        .searchable(text: $searchBook)
    }

    var noSerchBook: some View {
        Text("No exist book with name in Bible")
    }

    @ViewBuilder
    private func navigationLink(for index: Int) -> some View {
        NavigationLink {
            BookPresentation(bibleXML: vm.bibleXML, number: index)
        } label: {
            Text(vm.bibleXML.nameBooks[index])
        }
    }
}

#Preview {
    BiblePresentation()
}
