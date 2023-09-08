import Foundation
import UIKit

extension PageListPodcast: UIScrollViewDelegate {
    
    // This method allows you to request a new episode when you scroll to the bottom of the podcast list

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
