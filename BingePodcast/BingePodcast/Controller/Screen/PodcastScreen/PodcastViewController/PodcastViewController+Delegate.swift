import Foundation
import UIKit

extension PodcastViewController: PodcastPageDelegate {
    func showPodcastAnEpisode(podcastEpisode: PodcastEpisode) {
        self.podcastEpisode.append(podcastEpisode)
        myCollectionViewPodcast?.reloadData()
    }

    func fetchPodcastList(result: [Podcast]) {
        result.enumerated().forEach { podcast in
            podcastPageModel.fetchEpisodePodcast(podcast: podcast.element)
        }
         
    }
}
