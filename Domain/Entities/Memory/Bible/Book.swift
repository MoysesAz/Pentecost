import Foundation

public final class Book {
    let name: String
    let chapters: [Chapter]

    public init(name: String, chapters: [Chapter]) {
        self.name = name
        self.chapters = chapters
    }
}
