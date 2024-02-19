import Foundation
import Application
import Domain
import Infra

final class BookVM {
    let bookXML: BookXML

    init(bibleXML: BibleXML, number: Int) {
        let xmlGenerator = XmlGenerator()
        let useCase = GetBookUseCase(repository: xmlGenerator)
        self.bookXML = useCase.handler(bibleXML: bibleXML, number: number)
    }
}
