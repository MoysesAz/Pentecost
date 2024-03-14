//
//  ReadingStatistics+CoreDataProperties.swift
//  Pentecost
//
//  Created by Moyses Miranda do Vale Azevedo on 14/03/24.
//
//

import Foundation
import CoreData


extension ReadingStatistics {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ReadingStatistics> {
        return NSFetchRequest<ReadingStatistics>(entityName: "ReadingStatistics")
    }

    @NSManaged public var day: Date?
    @NSManaged public var goal: Bool
    @NSManaged public var seconds: Int16
    @NSManaged public var upload: Bool

}

extension ReadingStatistics : Identifiable {

}
