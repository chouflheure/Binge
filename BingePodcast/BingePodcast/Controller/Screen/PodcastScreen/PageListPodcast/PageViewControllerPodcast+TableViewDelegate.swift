import Foundation
import UIKit

extension PageListPodcast: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let secondVC = mainStoryboard.instantiateViewController(
            withIdentifier: "PlayerViewController") as? PlayerViewController
        
        let index = indexPath.section

        guard let secondVC = secondVC else {return}

        secondVC.isReturnButtonChevronLeft = true
        secondVC.titlePodcast.text = podcastEpisode.episode[index].title
        secondVC.subtitlePodcast.text = podcastEpisode.episode[index].subtitle
        secondVC.descriptionPodcast.text = podcastEpisode.episode[index].description
        secondVC.podcastTitle = podcastEpisode.episode[index].podcastTitle ?? ""
        secondVC.imagePlayer = podcastEpisode.episode[index].imageUrl ?? ""
        
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
