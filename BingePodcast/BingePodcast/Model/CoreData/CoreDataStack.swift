import Foundation
import CoreData
import UIKit

open class CoreDataStack {

    // MARK: - Properties
    var favorite = false
    private let modelName: String

    // MARK: - Initializer

    public init(modelName: String) {
        self.modelName = modelName
    }
    
    // MARK: - Core Data stack
    public lazy var persistentContainer: NSPersistentCloudKitContainer = {
        let container = NSPersistentCloudKitContainer(name: modelName)
        container.loadPersistentStores(completionHandler: { (_, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support
    func saveContext () {
        let context = mainContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                    print("Somme error to save context = \(nserror)")
            }
        }
    }

    public lazy var mainContext: NSManagedObjectContext = {
        return persistentContainer.viewContext
    }()
}
