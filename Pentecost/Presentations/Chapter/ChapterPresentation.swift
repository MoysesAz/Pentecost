import SwiftUI
import Domain

struct ChapterPresentation: View {
    @ObservedObject var vm: ChapterVM
    let numberChapter: Int

    init(bookXML: BookXML, number: Int) {
        self.vm = ChapterVM(bookXML: bookXML, number: number)
        numberChapter = number
    }

    var body: some View {
        NavigationStack {
            VStack{
                verses
            }
            .onAppear {
                vm.generationVersesInEnglish()
                vm.generationVersesInPortugues(numberBook: vm.chapterXMLInEnglish.numberBook, numberChapter: numberChapter)
            }

        }
    }

    var verses: some View {
        List {
            ForEach(0..<vm.versesInEnglish.count, id: \.self) { index in
                Text((vm.versesInPortugues[index] ?? "teste"))
                    .listRowSeparator(.hidden)
                Text((vm.versesInEnglish[index] ?? "teste"))
                    .italic()
                    .bold()
                    .listRowSeparator(.visible)
                    .onTapGesture {
                        
                    }
            }
        }
    }

    var buttonsControllers: some View {
        HStack {
            Image(systemName: "circle")
            Image(systemName: "circle")
            Image(systemName: "circle")
            Image(systemName: "circle")
            Spacer()


        }
        .listRowSeparator(.visible)
    }
}
