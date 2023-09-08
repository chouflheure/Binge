import Foundation
import UIKit

protocol HomePageDelegate: AnyObject {
    func fetchPodcastListAndShowOnHomePage(result: [Podcast])
}

protocol PodcastPageDelegate: AnyObject {
    func fetchPodcastList(result: [Podcast])
    func showPodcastAnEpisode(podcastEpisode: PodcastEpisode)
    func test(podcastEpisode: PodcastEpisode)
}
