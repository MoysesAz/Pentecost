import Foundation
import CoreData
import Domain

public final class ReadingStatisticsRepository: ReadingStatisticsInterface {

    private let context = CoreDataStack.shared.persistentContainer.viewContext

    public init() {}

    public func isGoalToday() -> Bool {
        return true
    }

    public func create(_ day: Date, seconds: Int, goal: Bool = false, upload: Bool = false) {
        let entity = ReadingStatistics(context: context)
        entity.day = day
        entity.goal = goal
        entity.seconds = Int16(seconds)
        entity.upload = upload

        do {
            try context.save()
        } catch {
            fatalError("create ReadingStatistics")
        }
    }

    public func upload(_ entity: Domain.ReadingStatistics, goal: Bool, seconds: Int, upload: Bool) {
        entity.goal = goal
        entity.seconds = Int16(seconds)
        entity.upload = upload

        do {
            try context.save()
        } catch {
            fatalError("upload ReadingStatistics")
        }
    }

    public func read(_ day: Date) -> Domain.ReadingStatistics? {
        let fetchRequest: NSFetchRequest<Domain.ReadingStatistics> = Domain.ReadingStatistics.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "day == %@", day as NSDate)

        do {
            let results = try context.fetch(fetchRequest)
            return results.first
        } catch {
            return nil
        }
    }

    public func readAll() -> [Domain.ReadingStatistics] {
        do {
            let results = try context.fetch(Domain.ReadingStatistics.fetchRequest())
            return results
        } catch {
            return []
        }
    }

    public func delete(_ entity: Domain.ReadingStatistics) {
        context.delete(entity)
    }


}
