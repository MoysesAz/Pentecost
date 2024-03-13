import SwiftUI
import Domain
import Application
import SwiftyXMLParser


struct BookPresentation: View {
    let vm: BookVM

    init(bibleXML: BibleXML, number: Int) {
        self.vm = BookVM(bibleXML: bibleXML, number: number)
    }

    var body: some View {
            NavigationStack {
            List {
                ForEach(0..<vm.bookXML.chapters.count, id: \.self) { index in
                    NavigationLink {
                        ChapterPresentation(bookXML: vm.bookXML, number: index)
                    } label: {
                        Text((index + 1).description)
                    }
                }
            }
            .navigationTitle(vm.bookXML.name)
        }
    }
}

