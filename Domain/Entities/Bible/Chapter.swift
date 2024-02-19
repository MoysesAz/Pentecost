import Foundation

public final class Chapter {
    let number: Int
    let verses: [Verse]

    public init(number: Int, verses: [Verse]) {
        self.number = number
        self.verses = verses
    }
}
