import Foundation
import UIKit

extension PageListFavorite: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let secondVC = mainStoryboard.instantiateViewController(withIdentifier: "PlayerViewController")
            as? PlayerViewController

        guard let secondVC = secondVC else {return}
        secondVC.isReturnButtonChevronLeft = true
        secondVC.titlePodcast.text = "test"
        secondVC.subtitlePodcast.text = "episode 112"
        secondVC.descriptionPodcast.text = "test description"
        secondVC.modalPresentationStyle = .custom
        secondVC.transitioningDelegate = self

        self.present(secondVC, animated: true, completion: nil)
    }

}
