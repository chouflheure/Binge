import Foundation
import CoreData
import UIKit


class CoreDataManager {

    private let coreDataStack = CoreDataStack(modelName: "BigePodcast")
    private let request = NSFetchRequest<NSFetchRequestResult>(entityName: "RecipeSaved")
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
    func newRecipeSaved(label: String, yield: Int, image: String, url: String, totalTime: Int, ingredients: String, ingredientLines: [String]) async {
/*
        let newRecipe = NSEntityDescription.insertNewObject(forEntityName: "EpisodeSaved", into: coreDataStack.mainContext) as? Episode

        newRecipe?.setValue(label, forKey: "label")
        newRecipe?.setValue(url, forKey: "url")
        newRecipe?.setValue(yield, forKey: "yield")
        newRecipe?.setValue(image, forKey: "image")
        newRecipe?.setValue(totalTime, forKey: "totalTime")
        newRecipe?.setValue(ingredients, forKey: "ingredients")
        newRecipe?.setValue(ingredientLines, forKey: "ingredientLines")

        coreDataStack.saveContext()
 */
    }

    // This method is to remove a recipe on core data
    func removeRecipeFromFavorite(label: String) async {

        do {
            let result = try context.fetch(request)
            for r in result as! [NSManagedObject] {
                if r.value(forKey: "label") as! String == label || r.value(forKey: "label") as! String == "" {
                    coreDataStack.mainContext.delete(r)
                }
            }
        } catch {}
        coreDataStack.saveContext()
    }
    
    // This method is to fectch all recipes from core data
    func fetchFavoriteRecipe() -> [Episode] {
        var recipeList = [Episode]()

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
        return recipeList
    }
}
