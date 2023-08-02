
import Foundation
import UIKit

extension HomeViewController: HomePageDelegate {
    
    func fetchPodcastListAndShowOnHomePage(result: [Podcast]) {
        podcast = result
        collectionViewPodcast.reloadData()
    }
    
    
    
}
