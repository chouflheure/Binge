import Foundation
import UIKit

extension PodcastViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {

        if currentIndex == 0 {return nil}
        currentIndex -= 1

        let vc: PageListPodcast = arrayPageListPodcast[currentIndex]
        /*
        let vc: PageListPodcast = PageListPodcast(
            episode: podcastEpisode[currentIndex].episode
        )
         */
        
        pageControl?.currentPage = currentIndex
        return vc
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        if currentIndex >= podcastEpisode.count - 1 {return nil}
        currentIndex += 1
        
        let vc: PageListPodcast = arrayPageListPodcast[currentIndex]
        
        pageControl?.currentPage = currentIndex
        return vc
    }

}
