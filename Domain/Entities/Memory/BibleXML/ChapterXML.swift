import Foundation
import SwiftyXMLParser

public final class ChapterXML {
    public let number: Int
    public let numberBook: Int
    public var verses: [XML.Accessor]



    public init(number: Int, numberBook: Int, verses: [XML.Accessor]) {
        self.number = number
        self.numberBook = numberBook
        self.verses = verses
    }
}
