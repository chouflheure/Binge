import Foundation

protocol SearchDelegate: AnyObject {

    func messageErrorServerConnexionDelegate()
    func addAlimentsInList(ingredient: String)
    func togglePressButton()
    func messageErrorEmptyIngredient()
}

protocol ListRecipeDelegate: AnyObject {
    func inAppDelegateFavorite()
}

protocol DetailRecipeDelegate: AnyObject {
    func inAppDelegateFavorite()
    func addTimeAndLikeIfNotEmpty(dataLike: Int, dataTime: Int)
}
