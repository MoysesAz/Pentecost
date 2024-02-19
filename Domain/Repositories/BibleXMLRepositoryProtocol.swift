import Foundation

public protocol BibleXMLRepositoryProtocol  {
    func getKingJames() -> BibleXML
    func getAlmeida() -> BibleXML
    func getBook(bible: BibleXML, number: Int) -> BookXML
    func getChapter(book: BookXML, number: Int) ->ChapterXML
    func getChapter(bible: BibleXML, numberBook: Int, numberChapter: Int) ->ChapterXML
}
