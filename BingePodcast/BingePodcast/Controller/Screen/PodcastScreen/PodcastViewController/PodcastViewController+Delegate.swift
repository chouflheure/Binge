import Foundation
import UIKit

extension PodcastViewController: PodcastPageDelegate {
    func showPodcastAnEpisode(podcastEpisode: PodcastEpisode) {
        self.podcastEpisode.append(podcastEpisode)
        myCollectionViewPodcast?.reloadData()
        
        guard let last = self.podcastEpisode.last else {return}
        let pageListPodcast = PageListPodcast(podcastEpisode: last, podcastPageModel: podcastPageModel)
        arrayPageListPodcast.append(pageListPodcast)
        
        currentIndex += 1
        
        if currentIndex == 6 {
            pageController?.setViewControllers([arrayPageListPodcast[0]], direction: .forward, animated: true)
            currentIndex = 0
        }
        
    }

    func fetchPodcastList(result: [Podcast]) {
        result.enumerated().forEach { podcast in
            podcastPageModel.fetchEpisodePodcast(podcast: podcast.element)
        }
    }
    
    func test(podcastEpisode: PodcastEpisode) {

        podcastEpisode.episode.enumerated().forEach { e in
            print("@@@ episode init = \(e.element.subtitle)")
        }

        for i in 0 ..< podcastEpisode.episode.count {
            arrayPageListPodcast[currentIndex].podcastEpisode.episode.append(podcastEpisode.episode[i])
        }

        let test = arrayPageListPodcast[currentIndex]

        test.podcastEpisode.episode.enumerated().forEach { e in
           print("@@@ test = \(e.element.subtitle)")
         }

        arrayPageListPodcast[currentIndex] = test
        
        pageController?.setViewControllers([arrayPageListPodcast[currentIndex]], direction: .forward, animated: true)
        arrayPageListPodcast[currentIndex].tableViewEpisode.reloadData()
    }
}
