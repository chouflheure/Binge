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

    var recipes: [PodcastEpisode] {
        let recipes = fetchFavoriteEpisode()
        return recipes
    }

    // This method is to check if the recipe is in favorite / in Core Data
    func checkIfEpisodeIsFavorite(titleEpisode: String, subtitleEpisode: String) async -> Bool {
        do {
            let result = try context.fetch(request)
            for r in result as! [NSManagedObject] {
                if r.value(forKey: "titleEpisode") as! String == titleEpisode
                    && r.value(forKey: "subtitleEpisode") as! String == subtitleEpisode {
                    return true
                }
            }
        } catch { return false}
        return false
    }


    // This method is to save a recipe on core data
    func addEpisodeInFavorite(title: String, subtitle: String, description: String, totalTime: String, imageUrl: String, playerUrl: String, podcastName: String) async {

        let newEpisode = NSEntityDescription.insertNewObject(forEntityName: "EpisodeSaved", into: coreDataStack.mainContext)
        
        newEpisode.setValue(title, forKey: "titleEpisode")
        newEpisode.setValue(subtitle, forKey: "subtitleEpisode")
        newEpisode.setValue(description, forKey: "descriptionEpisode")
        newEpisode.setValue(totalTime, forKey: "totalTimeEpisode")
        newEpisode.setValue(imageUrl, forKey: "imageUrlEpisode")
        newEpisode.setValue(playerUrl, forKey: "playerUrlEpisode")
        newEpisode.setValue(podcastName, forKey: "podcastName")

        coreDataStack.saveContext()
    }

    // This method is to remove a recipe on core data
    func removeEpisodeFromFavorite(titlePodcast: String, subtitlePodcast: String) async {

        do {
            let result = try context.fetch(request)
            for r in result as! [NSManagedObject] {
                if (r.value(forKey: "titleEpisode") as! String == titlePodcast
                    && r.value(forKey: "subtitleEpisode") as! String == subtitlePodcast )
                    || r.value(forKey: "titleEpisode") as! String == "" {
                    coreDataStack.mainContext.delete(r)
                }
            }
        } catch {}
        coreDataStack.saveContext()
    }
    
    
    // This method is to fectch all recipes from core data
    func fetchFavoriteEpisode() -> [PodcastEpisode]  {
        var episodeFavoriteList = [PodcastEpisode]()
        var episodes = [Episode]()

        do {
            let result = try context.fetch(request)

            for res in result as! [NSManagedObject] {
                let data = Episode(
                    title:        res.value(forKey: "titleEpisode")       as? String ?? "",
                    subtitle:     res.value(forKey: "subtitleEpisode")    as? String ?? "",
                    description:  res.value(forKey: "descriptionEpisode") as? String ?? "",
                    totalTime:    res.value(forKey: "totalTimeEpisode")   as? String ?? "",
                    imageUrl:     res.value(forKey: "imageUrlEpisode")    as? String ?? "",
                    playerUrl:    res.value(forKey: "playerUrlEpisode")   as? String ?? "",
                    podcastTitle: res.value(forKey: "podcastName")        as? String ?? ""
                )

                episodes.append(data)
            }
            
            var podcastEpisodeDictionary = [String: [Episode]]()
            for episode in episodes {
                if var existingEpisodes = podcastEpisodeDictionary[episode.podcastTitle ?? ""] {
                    existingEpisodes.append(episode)
                    podcastEpisodeDictionary[episode.podcastTitle ?? ""] = existingEpisodes
                } else {
                    podcastEpisodeDictionary[episode.podcastTitle ?? ""] = [episode]
                }
            }
            
            podcastEpisodeDictionary.enumerated().forEach { index in
                episodeFavoriteList.append(PodcastEpisode(
                    podcast: Podcast(title: index.element.key, image: "", author: ""),
                    episode: index.element.value))
            }

        } catch {}
        return episodeFavoriteList
    }
}
