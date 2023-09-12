import Foundation
import UIKit

extension PageListFavorite: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let section = indexPath.section
        let row = indexPath.row
        let episodeData = podcastSaved[section].episode[row]

        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let secondVC = mainStoryboard.instantiateViewController(
            withIdentifier: "PlayerViewController") as? PlayerViewController

        print("@@@ click = \(indexPath)")
        guard let secondVC = secondVC else {return}
        secondVC.isReturnButtonChevronLeft = true
        secondVC.titlePodcast.text = episodeData.title
        secondVC.subtitlePodcast.text = episodeData.subtitle
        secondVC.descriptionPodcast.text = episodeData.description
        secondVC.imagePlayer = episodeData.imageUrl ?? ""
        secondVC.modalPresentationStyle = .custom
        secondVC.transitioningDelegate = self

        self.present(secondVC, animated: true, completion: nil)
    }

}
