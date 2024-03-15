import Foundation
import SwiftyXMLParser

public final class VerseXML {
    public let number: Int
    public let text: String

    public init(number: Int, text: String) {
        self.number = number
        self.text = text
    }
}
