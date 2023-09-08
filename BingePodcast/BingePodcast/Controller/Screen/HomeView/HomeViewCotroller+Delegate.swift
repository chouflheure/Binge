import Foundation
import UIKit

extension HomeViewController: HomePageDelegate {
    
    // This method retrieves the podcast list and stops the view loader
    func fetchPodcastListAndShowOnHomePage(result: [Podcast]) {
        podcast = result
        stackViewLoaderCollectionView.isHidden = true
        collectionViewPodcast.isHidden = false
        collectionViewPodcast.reloadData()
    }

}
