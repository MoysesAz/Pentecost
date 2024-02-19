import Foundation
import Domain

public final class GetBookUseCase {
    let repository: BibleXMLRepositoryProtocol

    public init(repository: BibleXMLRepositoryProtocol) {
        self.repository = repository
    }

    public func handler(bibleXML: BibleXML, number: Int) -> BookXML {
        let bookXML = repository.getBook(bible: bibleXML, number: number)
        return bookXML
    }
}
