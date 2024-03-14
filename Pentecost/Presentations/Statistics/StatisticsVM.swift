import Foundation
import Application
import Infra
import Domain

final class StatisticsVM: ObservableObject {
    private let useCase: GetAllReadingStatisticsUseCase

    public init() {
        let repository = ReadingStatisticsRepository()
        useCase = .init(repository: repository)
    }

    func generateStatisticGoalData() -> [StatisticsGoalData] {
        let statisticGoal = useCase.handler()
        var statisticGoalData: [StatisticsGoalData] = []
        for i in statisticGoal {
            let mins = Float(i.seconds) / 60
            let date = i.day!
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd-MM-yyyy"
            let dateString = dateFormatter.string(from: date)
            statisticGoalData.append(.init(day: dateString, min: mins))

        }
        return statisticGoalData
    }

}
