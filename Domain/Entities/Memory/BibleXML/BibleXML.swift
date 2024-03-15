import Foundation
import SwiftyXMLParser

public final class BibleXML {
    public let name: String
    public let books: [XML.Accessor]
    public let nameBooks: [String]
    public let abbreviated: [String]

    public init(name: String, books: [XML.Accessor], nameBooks: [String], abbreviated: [String]) {
        self.name = name
        self.books = books
        self.nameBooks = nameBooks
        self.abbreviated = abbreviated
    }
}

