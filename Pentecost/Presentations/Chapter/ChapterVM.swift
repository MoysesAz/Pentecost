import Foundation
import SwiftyXMLParser
import Domain
import Application
import Infra

final class ChapterVM: ObservableObject {
    let chapterXMLInEnglish: ChapterXML
    var chapterXMLInPortugues: ChapterXML?
    @Published var versesInEnglish: [Int: String] = [:]
    @Published var versesInPortugues: [Int: String] = [:]

    init(bookXML: BookXML, number: Int) {
        let repository = XmlGenerator()
        let useCase = GetChapterUseCase(repository: repository)
        let useCaseBibleInEnglish = GetBibleUseCase(repository: repository)
        let useCaseChapterInEnglish = GetChapterUseCase(repository: repository)
        self.chapterXMLInEnglish = useCaseChapterInEnglish.handler(bookXML: bookXML, number: number)
    }

    public func generationVersesInEnglish() {
        var verses: [Int: String] = [:]
        for i in 0..<chapterXMLInEnglish.verses.count {
            let versesInEnglish = chapterXMLInEnglish.verses[i]
            verses[i] = versesInEnglish.text ?? "erro"
        }
        versesInEnglish = verses
    }

    public func generationVersesInPortugues(numberBook: Int, numberChapter: Int) {
        let repository = XmlGenerator()
        let useCaseBibleInPortugues = GetBibleUseCase(repository: repository)
        let useCaseChapterInPotugues = GetChapterUseCase(repository: repository)
        let almeida = useCaseBibleInPortugues.getAlmeida()

        chapterXMLInPortugues = useCaseChapterInPotugues.handler(bibleXML: almeida, numberBook: numberBook, numberChapter: numberChapter)

        var verses: [Int: String] = [:]
        for i in 0..<(chapterXMLInPortugues?.verses.count ?? 1){
            let versesInPortugues = chapterXMLInPortugues?.verses[i]
            verses[i] = versesInPortugues?.text ?? "erro"
        }
        versesInPortugues = verses
    }

}
