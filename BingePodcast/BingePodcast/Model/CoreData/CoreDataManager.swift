import Foundation
import CoreData
import UIKit


class CoreDataManager {

    private let coreDataStack: CoreDataStack
    private let request = NSFetchRequest<NSFetchRequestResult>(entityName: "EpisodeSaved")
    private let context: NSManagedObjectContext

    public init(coreDataStack: CoreDataStack = CoreDataStack(modelName: "BingePodcast",
                                                             useInMemoryStore: false)
    ) {
        self.coreDataStack = coreDataStack
        self.context = coreDataStack.mainContext
        request.returnsObjectsAsFaults = false
    }

    var recipes: [Episode] {
        let recipes = fetchFavoriteEpisode()
        return recipes
    }

    // This method is to check if the recipe is in favorite / in Core Data
    func checkIfEpisodeIsFavorite(titleEpisode: String) async -> Bool {
        do {
            let result = try context.fetch(request)
            for r in result as! [NSManagedObject] {
                if r.value(forKey: "titleEpisode") as! String == titleEpisode {
                    return true
                }
            }
        } catch { return false}
        return false
    }


    // This method is to save a recipe on core data
    func addEpisodeIFavorite(title: String, subtitle: String, description: String, totalTime: String, imageUrl: String, playerUrl: String, channel: String = "Du sport") async {

        let newEpisode = NSEntityDescription.insertNewObject(forEntityName: "EpisodeSaved", into: coreDataStack.mainContext)
        
        newEpisode.setValue(title, forKey: "titleEpisode")
        newEpisode.setValue(description, forKey: "descriptionEpisode")
        newEpisode.setValue(totalTime, forKey: "totalTimeEpisode")
        newEpisode.setValue(imageUrl, forKey: "imageUrlEpisode")
        newEpisode.setValue(playerUrl, forKey: "playerUrlEpisode")
        newEpisode.setValue(channel, forKey: "channel")

        coreDataStack.saveContext()
    }

    // This method is to remove a recipe on core data
    func removeEpisodeFromFavorite(titlePodcast: String) async {

        do {
            let result = try context.fetch(request)
            for r in result as! [NSManagedObject] {
                if r.value(forKey: "titleEpisode") as! String == titlePodcast
                    || r.value(forKey: "titleEpisode") as! String == "" {
                    coreDataStack.mainContext.delete(r)
                }
            }
        } catch {}
        coreDataStack.saveContext()
    }
    
    // This method is to fectch all recipes from core data
    func fetchFavoriteEpisode() -> [Episode] {
        var episodeFavoriteList = [Episode]()

        do {
            let result = try context.fetch(request)
            
            for res in result as! [NSManagedObject] {
                let data = Episode(
                    title: res.value(forKey: "titleEpisode") as? String ?? "",
                    subtitle: res.value(forKey: "subtitleEpisode") as? String ?? "",
                    description: res.value(forKey: "descriptionEpisode") as? String ?? "",
                    totalTime: res.value(forKey: "totalTimeEpisode") as? String ?? "",
                    imageUrl: res.value(forKey: "imageUrlEpisode") as? String ?? "",
                    playerUrl: res.value(forKey: "playerUrlEpisode") as? String ?? ""
                )
                episodeFavoriteList.append(data)
            }
            print("@@@ episode = \(episodeFavoriteList)")
            /*
             channel
             */

        } catch {}
        return episodeFavoriteList
    }
}
