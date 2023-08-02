import Foundation
import UIKit

protocol HomePageDelegate: AnyObject {

    func fetchPodcastListAndShowOnHomePage(result: [Podcast])
}

protocol ListRecipeDelegate: AnyObject {
    func inAppDelegateFavorite()
}

protocol DetailRecipeDelegate: AnyObject {
    func inAppDelegateFavorite()
    func addTimeAndLikeIfNotEmpty(dataLike: Int, dataTime: Int)
}
