import Foundation
import UIKit

extension PageListFavorite: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = indexPath.row
        let section = indexPath.section
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let secondVC = mainStoryboard.instantiateViewController(
            withIdentifier: "PlayerViewController") as? PlayerViewController

        print("@@@ click = \(indexPath)")
        guard let secondVC = secondVC else {return}
        secondVC.isReturnButtonChevronLeft = true
        secondVC.titlePodcast.text = podcastSaved[section].episode[row].title
        secondVC.subtitlePodcast.text = podcastSaved[section].episode[row].subtitle
        secondVC.descriptionPodcast.text = podcastSaved[section].episode[row].description
        secondVC.imageString = podcastSaved[section].episode[row].imageUrl ?? ""
        secondVC.modalPresentationStyle = .custom
        secondVC.transitioningDelegate = self

        self.present(secondVC, animated: true, completion: nil)
    }

}
