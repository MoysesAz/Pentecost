//
//  File.swift
//  Application
//
//  Created by Moyses Miranda do Vale Azevedo on 11/03/24.
//

import Foundation
import Domain

public struct GetAllReadingStatisticsUseCase {
    private let repository: ReadingStatisticsInterface

    public init(repository: ReadingStatisticsInterface) {
        self.repository = repository
    }

    public func handler() -> [ReadingStatistics] {
        return repository.readAll()
    }
}
