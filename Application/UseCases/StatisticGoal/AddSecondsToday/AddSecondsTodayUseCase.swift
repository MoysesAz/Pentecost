import Foundation
import Domain
import Infra

public struct AddSecondsTodayUseCase {
    private let repository: StatisticGoalInterface

    public init(repository: StatisticGoalInterface) {
        self.repository = repository
    }

    public func handler(_ today: Date, seconds: Int) {
        let statisticGoal = repository.read(today)

        guard let statisticGoal = statisticGoal else {
            repository.create(today, seconds: seconds, goal: false, upload: false)
            return
        }

        let secondsEntity = Int(statisticGoal.seconds) + seconds

        repository.upload(statisticGoal, goal: false, seconds: secondsEntity, upload: false)
    }
}
