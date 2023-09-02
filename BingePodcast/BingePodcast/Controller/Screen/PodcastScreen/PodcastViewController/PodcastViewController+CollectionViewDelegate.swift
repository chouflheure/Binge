import Foundation
import UIKit

extension PodcastViewController: UICollectionViewDelegate {
 
    func positionCellWithIdexPath(indexCell: Int) {
        let attributesCollectionViewPodcast = myCollectionViewPodcast?.layoutAttributesForItem(
            at: IndexPath(row: indexCell, section: 0)
        )
        var height: CGFloat? = 0.0
        var width: CGFloat? = 0.0

        if attributesCollectionViewPodcast != nil {
            width = attributesCollectionViewPodcast!.frame.origin.x - offsetCell
            height = 0
        }

        let position = CGPoint(x: width ?? 0, y: height ?? 0)

        myCollectionViewPodcast?.setContentOffset(position, animated: true)

        if indexCell < currentIndex {previous()}
        if indexCell > currentIndex {next()}

        currentIndex = indexCell
    }

    // Methode qui permet de changer la tronche de la cell ( cacher le text, enlever le blur ... )
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        cellSelected(indexPath: indexPath)
        // TODO : ajouter une animation to blur
        positionCellWithIdexPath(indexCell: indexPath.row)
    }

    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        cellDeselected(indexPath: indexPath)
    }

    private func cellSelected(indexPath: IndexPath) {
        guard let cell = myCollectionViewPodcast?.cellForItem(at: indexPath) as? CellPodcastCollectionViewCell else {return}
        cell.imageViewPodcast.isHidden = false
    }
    
    private func cellDeselected(indexPath: IndexPath) {
        guard let cell = myCollectionViewPodcast?.cellForItem(at: indexPath) as? CellPodcastCollectionViewCell else {return}
        print("@@@ size cell = \(cell.frame.size)")
        // cell.imageViewPodcast.isHidden = true
    }
}
