import Foundation
import SwiftyXMLParser

public final class BookXML {
    public let name: String
    public let number: Int
    public let abbreviated: String
    public let chapters: [XML.Accessor]

    public init(name: String, number: Int, abbreviated: String, chapters: [XML.Accessor]) {
        self.name = name
        self.number = number
        self.abbreviated = abbreviated
        self.chapters = chapters
    }
}
