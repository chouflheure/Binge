import Foundation
import UIKit

extension PodcastViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        podcastEpisode.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let myCell = collectionView.dequeueReusableCell(withReuseIdentifier: cellPodcast, for: indexPath) as? CellPodcastCollectionViewCell
        
        guard let myCell = myCell else {return UICollectionViewCell()}
        myCell.setUpUI(title: "", subtitlePodcast: "", imagePodcastString: podcastEpisode[indexPath.row].podcast.image ?? "")

        return myCell
    }
}
