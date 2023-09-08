import Foundation
import UIKit

extension PodcastViewController: UICollectionViewDelegate {
 
    // This method positions the newly selected cell in the centre
    func positionCellWithIdexPath(indexCell: Int) {
        let attributesCollectionViewPodcast = myCollectionViewPodcast?
            .layoutAttributesForItem(at: IndexPath(row: indexCell, section: 0)
        )

        var position = CGPoint(x: 0, y: 0)

        if attributesCollectionViewPodcast != nil {
            position.x = attributesCollectionViewPodcast!.frame.origin.x - horizontalSectionInsetCollectionView
        }

        myCollectionViewPodcast?.setContentOffset(position, animated: true)

        if indexCell < currentIndex {previous()}
        if indexCell > currentIndex {next()}

        currentIndex = indexCell
    }

    // This methode is call when a cell is selected
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        positionCellWithIdexPath(indexCell: indexPath.row)
    }
}
