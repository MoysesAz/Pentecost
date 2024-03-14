import Foundation
import Domain
import Infra

public struct AddSecondsTodayUseCase {
    private let repository: ReadingStatisticsInterface

    public init(repository: ReadingStatisticsInterface) {
        self.repository = repository
    }

    public func handler(_ today: Date, seconds: Int) {
        let entity = repository.read(today)

        guard let entity = entity else {
            repository.create(today, seconds: seconds, goal: false, upload: false)
            return
        }

        let secondsEntity = Int(entity.seconds) + seconds

        repository.upload(entity, goal: false, seconds: secondsEntity, upload: false)
    }
}
