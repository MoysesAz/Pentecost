import Foundation

public protocol StatisticGoalInterface {
    init ()
    func create(_ day: Date, seconds: Int, goal: Bool, upload: Bool)
    func upload(_ entity: StatisticGoal, goal: Bool, seconds: Int, upload: Bool)
    func read(_ day:  Date) -> StatisticGoal?
    func readAll() -> [StatisticGoal]
    func delete(_ entity: StatisticGoal)
}
