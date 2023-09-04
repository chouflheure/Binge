import Foundation
import UIKit

extension PodcastViewController: PodcastPageDelegate {
    func showPodcastAnEpisode(podcastEpisode: PodcastEpisode) {
        self.podcastEpisode.append(podcastEpisode)
        myCollectionViewPodcast?.reloadData()
        let test = PageListPodcast(podcastEpisode: self.podcastEpisode[currentIndex])
        // let test = PageListPodcast(episode: self.podcastEpisode[currentIndex].episode)

        arrayPageListPodcast.append(test)
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

        for i in 0 ..< podcastEpisode.episode.count{
            // arrayPageListPodcast[1].episode.append(podcastEpisode.episode[i])
        }

        
        
        let test = arrayPageListPodcast[currentIndex]
        
        
        // test.episode.enumerated().forEach { e in
           // print("@@@ test = \(e.element.subtitle)")
        // }
        arrayPageListPodcast[currentIndex] = test
        
        pageController?.setViewControllers([test], direction: .forward, animated: true)
        
        // arrayPageListPodcast[currentIndex].tableViewEpisode.reloadData()
        
        
    }
}
