import Foundation
import CoreData
import UIKit


class CoreDataManager {

    private let coreDataStack = CoreDataStack(modelName: "BingePodcast")
    private let request = NSFetchRequest<NSFetchRequestResult>(entityName: "EpisodeSaved")
    private let context: NSManagedObjectContext

    public init() {
        self.context = coreDataStack.mainContext
        request.returnsObjectsAsFaults = false
    }

    var recipes: [Episode] {
        let recipes = fetchFavoriteRecipe()
        return recipes
    }

    // This method is to check if the recipe is in favorite / in Core Data
    func checkIfRecipeIsFavorite(label: String) async -> Bool {
        do {
            let result = try context.fetch(request)
            for r in result as! [NSManagedObject] {
                if r.value(forKey: "label") as! String == label {
                    return true
                }
            }
        } catch { return false}
        return false
    }


    // This method is to save a recipe on core data
    func playerUrl(title: String, subtitle: String, description: String, totalTime: String, imageUrl: String, ingredients: String, playerUrl: String, channel: String = "Du sport") async {

        let newEpisode = NSEntityDescription.insertNewObject(forEntityName: "EpisodeSaved", into: coreDataStack.mainContext)
        
        newEpisode.setValue(title, forKey: "titleEpisode")
        newEpisode.setValue(description, forKey: "descriptionEpisode")
        newEpisode.setValue(title, forKey: "titleEpisode")
        newEpisode.setValue(totalTime, forKey: "totalTimeEpisode")
        newEpisode.setValue(imageUrl, forKey: "imageUrlEpisode")
        newEpisode.setValue(playerUrl, forKey: "playerUrlEpisode")
        newEpisode.setValue(channel, forKey: "channel")

        coreDataStack.saveContext()
    }

    // This method is to remove a recipe on core data
    func removeRecipeFromFavorite(titlePodcast: String) async {

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
    func fetchFavoriteRecipe() -> [Episode] {
        var episodeFavoriteList = [Episode]()

        do {
            let result = try context.fetch(request)
/*
            for r in result as! [NSManagedObject] {
                let data = Hit(recipe: Recipe(
                    label: r.value(forKey: "label") as? String ?? "",
                    image: r.value(forKey: "image") as? String,
                    url: r.value(forKey: "url") as? String ?? "",
                    yield: r.value(forKey: "yield") as? Int ?? 0,
                    ingredientLines: r.value(forKey: "ingredientLines")  as? [String] ?? [""],
                    totalTime: r.value(forKey: "totalTime") as? Int,
                    ingredients: convertStringToIngredientArray(ingredientString: r.value(forKey: "ingredients") as? String ?? "")
                ))
                recipeList.append(data)
            }
 */
        } catch {}
        return episodeFavoriteList
    }
}
