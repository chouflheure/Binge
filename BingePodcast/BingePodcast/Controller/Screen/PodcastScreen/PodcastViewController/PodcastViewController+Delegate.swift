import Foundation
import UIKit

extension PodcastViewController: PodcastPageDelegate {

    func showPodcastAnEpisode(podcastEpisode: PodcastEpisode) {
        self.podcastEpisode.append(podcastEpisode)
        
        guard let lastPodcast = self.podcastEpisode.last else {return}
        let pageListPodcast = PageListPodcast(podcastEpisode: lastPodcast,
                                              podcastPageModel: podcastPageModel)

        arrayPageListPodcast.append(pageListPodcast)
        
        currentIndex += 1
        
        if currentIndex == 6 {
            pageController?.setViewControllers([arrayPageListPodcast[0]],
                                               direction: .forward,
                                               animated: true)
            currentIndex = 0
        }

        myCollectionViewPodcast?.reloadData()

    }

    func fetchPodcastList(result: [Podcast]) {
        result.enumerated().forEach { podcast in
            podcastPageModel.fetchEpisodePodcast(podcast: podcast.element)
        }
    }
    
    func test(podcastEpisode: PodcastEpisode) {

        for index in 0 ..< podcastEpisode.episode.count {
            arrayPageListPodcast[currentIndex].podcastEpisode.episode
                .append(podcastEpisode.episode[index])
        }
        
        pageController?.setViewControllers([arrayPageListPodcast[currentIndex]],
                                           direction: .forward,
                                           animated: true)

        arrayPageListPodcast[currentIndex].tableViewEpisode.reloadData()
    }
}
