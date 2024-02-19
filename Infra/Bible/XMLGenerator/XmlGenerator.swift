import Foundation
import Domain
import SwiftyXMLParser

public final class XmlGenerator: BibleXMLRepositoryProtocol {
    public func getKingJames() -> Domain.BibleXML {
        let xml = generatorBible(nameBible: "KingJames")
        return getBible(bible: xml)
    }
    
    public func getAlmeida() -> Domain.BibleXML {
        let xml = generatorBible(nameBible: "Almeida")
        return getBible(bible: xml)

    }
    
    public func getChapter(bible: Domain.BibleXML, numberBook: Int, numberChapter: Int) -> Domain.ChapterXML {
        let book = getBook(bible: bible, number: numberBook)
        let chapter = getChapter(book: book, number: numberChapter)
        return chapter
    }



    public func getBible(bible: XML.Accessor) -> Domain.BibleXML {
        let booksXML = bible["bible", "book"].compactMap{$0}
        let names = booksXML.compactMap{ $0.attributes["num"] }
        let abbreviated = booksXML.compactMap{ $0.attributes["abbrev"]}
        let bibleXml = BibleXML(name: "Teste",
                                books: booksXML,
                                nameBooks: names,
                                abbreviated: abbreviated)
        return bibleXml

    }

    public func getBook(bible: Domain.BibleXML, number: Int) -> Domain.BookXML {
        let name = bible.nameBooks[number]
        let abbreviated = bible.abbreviated[number]
        let book = bible.books.compactMap{$0}[number]
        let chapters = book["chapter"].compactMap{$0}
        let bookXML = BookXML(name: name, number: number,
                              abbreviated: abbreviated,
                              chapters: chapters)

        return bookXML
    }

    public func getChapter(book: Domain.BookXML, number: Int) -> Domain.ChapterXML {
        let chapter = book.chapters[number]
        let verses = chapter["verse"].compactMap(){$0}
        let chapterXML = ChapterXML(number: number, numberBook: book.number, verses: verses)
        return chapterXML
    }

    private func generatorBible(nameBible: String) -> XML.Accessor {
        if let path = Bundle.main.path(forResource: nameBible, ofType: "xml") {
            do {
                let bibleInString = try String(contentsOfFile: path)
                let bibleInXml = try XML.parse(bibleInString)
                return bibleInXml
            } catch {
                fatalError("Error: Erro ao tentar carregar KingJames")
            }
        }
       fatalError("Error: Error")
    }

    public init() {}

}

