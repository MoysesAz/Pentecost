import Foundation
import Domain

public final class GetChapterUseCase {
    let repository: BibleXMLRepositoryProtocol

    public init(repository: BibleXMLRepositoryProtocol) {
        self.repository = repository
    }

    public func handler(bookXML: BookXML, number: Int) -> ChapterXML {
        let chapterXML = repository.getChapter(book: bookXML, number: number)
        return chapterXML
    }

    public func handler(bibleXML: BibleXML, numberBook: Int, numberChapter: Int) -> ChapterXML {
        let chapterXML = repository.getChapter(bible: bibleXML, numberBook: numberBook, numberChapter: numberChapter)
        return chapterXML
    }
}
