//
//  File.swift
//  Application
//
//  Created by Moyses Miranda do Vale Azevedo on 11/03/24.
//

import Foundation
import Domain

public struct GetAllStatisticsGoalsUseCase {
    private let repository: StatisticGoalInterface

    public init(repository: StatisticGoalInterface) {
        self.repository = repository
    }

    public func handler() -> [StatisticGoal] {
        return repository.readAll()
    }
}
