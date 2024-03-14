import Foundation

public protocol ReadingStatisticsInterface {
    init ()
    func create(_ day: Date, seconds: Int, goal: Bool, upload: Bool)
    func upload(_ entity: ReadingStatistics , goal: Bool, seconds: Int, upload: Bool)
    func read(_ day:  Date) -> ReadingStatistics?
    func readAll() -> [ReadingStatistics]
    func delete(_ entity: ReadingStatistics)
}
