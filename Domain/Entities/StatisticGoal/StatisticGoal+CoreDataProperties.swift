//
//  StatisticGoal+CoreDataProperties.swift
//  Infra
//
//  Created by Moyses Miranda do Vale Azevedo on 10/03/24.
//
//

import Foundation
import CoreData


extension StatisticGoal {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<StatisticGoal> {
        return NSFetchRequest<StatisticGoal>(entityName: "StatisticGoal")
    }

    @NSManaged public var day: Date?
    @NSManaged public var goal: Bool
    @NSManaged public var seconds: Int16
    @NSManaged public var upload: Bool

}

extension StatisticGoal : Identifiable {

}
