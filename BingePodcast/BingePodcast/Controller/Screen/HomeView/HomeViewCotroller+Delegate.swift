import Foundation
import UIKit

extension HomeViewController: HomePageDelegate {
    
    func fetchPodcastListAndShowOnHomePage(result: [Podcast]) {
        podcast = result
        stackViewLoaderCollectionView.isHidden = true
        collectionViewPodcast.isHidden = false
        collectionViewPodcast.reloadData()
    }

}
