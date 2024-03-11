import Foundation
import CoreData
import Domain

public final class StatisticRepository: StatisticGoalInterface {
    private let context = CoreDataStack.shared.persistentContainer.viewContext

    public init() {}

    public func addSecondsToday(today: Date, seconds: Int) {
        let statisticGoal = read(today)

        guard let statisticGoal = statisticGoal else {
            create(today, seconds: seconds)
            return
        }

        statisticGoal.seconds += Int16(seconds)

        do {
            try context.save()
        } catch {
            fatalError("FatalError addSecondsToday")
        }
    }

    public func getToday(_ today: Date) -> Domain.StatisticGoal? {
        let fetchRequest: NSFetchRequest<Domain.StatisticGoal> = Domain.StatisticGoal.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "date == %@", today as NSDate)

        do {
            let results = try context.fetch(fetchRequest)
            return results.first
        } catch {
            print("Erro ao buscar StatisticGoal: \(error.localizedDescription)")
            return nil
        }
    }

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

    public func delete(_ entity: Domain.StatisticGoal) {
        context.delete(entity)
    }

}
