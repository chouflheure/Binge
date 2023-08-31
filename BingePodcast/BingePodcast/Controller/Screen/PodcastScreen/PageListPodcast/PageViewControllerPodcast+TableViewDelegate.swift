import Foundation
import UIKit

extension PageListPodcast: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            //print("@@@ select at \(indexPath)")
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

/*

import Lottie

class PodcastViewController: UIViewController {
    
    private var animationView: AnimationView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        animationView = .init(name: "workinProgress")

        animationView!.frame = view.bounds

        animationView!.contentMode = .scaleAspectFit

        animationView!.loopMode = .loop

        animationView!.animationSpeed = 0.5

        view.addSubview(animationView!)

        animationView!.play()

        view.backgroundColor = Colors.bluePodcastPage.color

    }
}

*/
