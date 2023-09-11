import Foundation
import UIKit

protocol HomePageDelegate: AnyObject {
    func fetchPodcastListAndShowOnHomePage(result: [Podcast])
}

protocol PodcastPageDelegate: AnyObject {
    func fetchPodcastList(result: [Podcast])
    func showPodcastAndEpisode(podcastEpisode: PodcastEpisode)
    func loadMoreEpisode(podcastEpisode: PodcastEpisode)
}
