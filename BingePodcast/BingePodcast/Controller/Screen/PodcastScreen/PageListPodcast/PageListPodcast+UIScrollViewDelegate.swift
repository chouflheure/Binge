import Foundation
import UIKit

extension PageListPodcast: UIScrollViewDelegate {
    
    // Vérifiez si vous êtes en bas de la table
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let contentOffsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let tableViewHeight = scrollView.bounds.size.height
        let offSetBottonTablView = 150.0
        
        if contentOffsetY >= contentHeight - tableViewHeight - offSetBottonTablView {
            podcastPageModel.fetchEpisodeMore(podcast: podcastEpisode.podcast)
        }
    }
    
}
