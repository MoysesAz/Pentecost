import Foundation
import CoreData
import SwiftyXMLParser
import Domain
import Application
import Infra

final class ChapterVM: ObservableObject {
    let chapterXMLInEnglish: ChapterXML
    var chapterXMLInPortugues: ChapterXML?
    @Published var versesInEnglish: [Int: String] = [:]
    @Published var versesInPortugues: [Int: String] = [:]
    var startChapter: Date

    init(bookXML: BookXML, number: Int) {
        let xmlGeneratorRepository = XmlGenerator()
        let useCaseChapterInEnglish = GetChapterUseCase(repository: xmlGeneratorRepository)
        self.chapterXMLInEnglish = useCaseChapterInEnglish.handler(bookXML: bookXML, number: number)
        startChapter = Date()
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

    public func addStatisticGoal() {
        let repository = ReadingStatisticsRepository()
        let useCase = AddSecondsTodayUseCase(repository: repository)
        let secondsInChapter = Int(Date().timeIntervalSince(self.startChapter))
        let date = ChapterVM.createDateNow()
        useCase.handler(date, seconds: secondsInChapter)
    }

    static func createDateNow() -> Date {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day], from: Date())
        guard let newData = calendar.date(from: components) else {
            fatalError("Erro ao criar a nova data")
        }
        return newData
    }

    func countTime() {
        startChapter = Date()
    }
}
