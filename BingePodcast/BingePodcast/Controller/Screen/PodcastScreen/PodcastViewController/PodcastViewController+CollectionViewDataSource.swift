import Foundation
import UIKit

extension PodcastViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        podcastEpisode.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellPodcast, for: indexPath) as? CellPodcastCollectionViewCell
        
        guard let cell = cell else {return UICollectionViewCell()}
        cell.setUpUI(title: "",
                     subtitlePodcast: "",
                     imagePodcastString: podcastEpisode[indexPath.row].podcast.image ?? "")

        return cell
    }
}
