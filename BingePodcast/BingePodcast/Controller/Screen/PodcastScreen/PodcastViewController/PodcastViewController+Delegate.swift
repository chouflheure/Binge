import Foundation
import UIKit

extension PodcastViewController: PodcastPageDelegate {
    func showPodcastAnEpisode(podcastEpisode: PodcastEpisode) {
        self.podcastEpisode.append(podcastEpisode)
        myCollectionViewPodcast?.reloadData()
        
        pageController?.setViewControllers([PageListPodcast(episode: self.podcastEpisode[currentIndex].episode)], direction: .forward, animated: true, completion: nil)
    }

    func fetchPodcastList(result: [Podcast]) {
        result.enumerated().forEach { podcast in
            podcastPageModel.fetchEpisodePodcast(podcast: podcast.element)
        }
         
    }
}
