import CoreData

public class CoreDataStack: ObservableObject {
    public static let shared = CoreDataStack()

    // Create a persistent container as a lazy variable to defer instantiation until its first use.
    public lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "PentecostData")
        container.loadPersistentStores { _, error in
            if let error {
                fatalError("Failed tox load persistent stores: \(error.localizedDescription)")
            }
        }
        return container
    }()

    private init() { 
        persistentContainer.loadPersistentStores { description, error in
            if let error = error {
                print("Core Data failed to load: \(error.localizedDescription)")
                return
            }

            self.persistentContainer.viewContext.mergePolicy = NSMergePolicy.mergeByPropertyStoreTrump
        }
    }
}

