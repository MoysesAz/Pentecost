import Foundation
import CoreData
import Domain

public final class StatisticRepository: StatisticGoalInterface {
    
    private let context = CoreDataStack.shared.persistentContainer.viewContext

    public init() {}

    public func isGoalToday() -> Bool {
        return true
    }

    public func create(_ day: Date, seconds: Int, goal: Bool = false, upload: Bool = false) {
        let entity = StatisticGoal(context: context)
        entity.day = day
        entity.goal = goal
        entity.seconds = Int16(seconds)
        entity.upload = upload

        do {
            try context.save()
        } catch {
            fatalError("create StatisticGoal")
        }
    }

    public func upload(_ entity: Domain.StatisticGoal, goal: Bool, seconds: Int, upload: Bool) {
        entity.goal = goal
        entity.seconds = Int16(seconds)
        entity.upload = upload

        do {
            try context.save()
        } catch {
            fatalError("upload StatisticGoal")
        }
    }

    public func read(_ day: Date) -> Domain.StatisticGoal? {
        let fetchRequest: NSFetchRequest<Domain.StatisticGoal> = Domain.StatisticGoal.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "day == %@", day as NSDate)

        do {
            let results = try context.fetch(fetchRequest)
            return results.first
        } catch {
            return nil
        }
    }

    public func readAll() -> [Domain.StatisticGoal] {
        do {
            let results = try context.fetch(Domain.StatisticGoal.fetchRequest())
            return results
        } catch {
            return []
        }
    }

    public func delete(_ entity: Domain.StatisticGoal) {
        context.delete(entity)
    }


}
