import Foundation
import Domain

public final class GetBibleUseCase {
    let repository: BibleXMLRepositoryProtocol

    public init(repository: BibleXMLRepositoryProtocol) {
        self.repository = repository
    }

    public func getKingJames() -> BibleXML {
        let bibleXML = repository.getKingJames()
        return bibleXML
    }

    public func getAlmeida() -> BibleXML {
        let bibleXML = repository.getAlmeida()
        return bibleXML
    }
}

