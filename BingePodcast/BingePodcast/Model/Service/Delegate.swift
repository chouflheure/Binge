import Foundation
import UIKit

protocol HomePageDelegate: AnyObject {

    func fetchPodcastListAndShowOnHomePage(result: [Podcast])
}

protocol PodcastPageDelegate: AnyObject {
    func fetchPodcastList(result: [Podcast])
}

protocol DetailRecipeDelegate: AnyObject {
    func inAppDelegateFavorite()
    func addTimeAndLikeIfNotEmpty(dataLike: Int, dataTime: Int)
}
