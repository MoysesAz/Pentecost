import Foundation
import Domain
import Infra

public struct AddSecondsTodayUseCase {
    private let repository: StatisticGoalInterface

    public init(repository: StatisticGoalInterface) {
        self.repository = repository
    }

    public func handler(_ today: Date, seconds: Int) {
        repository.addSecondsToday(today: today, seconds: seconds)
    }
}
