import Foundation
import UIKit

extension HomeViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.tabBarController?.selectedIndex = 1
    }
}

extension HomeViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        podcast.count
    }
        
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellPodcast,
                                                      for: indexPath) as? PodcastHomePageCollectionViewCell
        
        guard let cell = cell else {return UICollectionViewCell()}
        cell.setup(imagePodcastName: podcast[indexPath.row].image ?? "",
                    titlePodcast: podcast[indexPath.row].title ?? "",
                    authorPodcast: podcast[indexPath.row].author ?? "")

        return cell
    }
}
