import Foundation
import UIKit

extension PageListPodcast: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        podcastEpisode.episode.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let index = indexPath.section
        
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "cellEpisode",
            for: indexPath as IndexPath) as? CellEpisodeTabViewCell
        
        guard let cell = cell else {return UITableViewCell()}
        
        cell.setupCell(title: podcastEpisode.episode[index].title ?? "",
                       subtitle: podcastEpisode.episode[index].subtitle ?? "",
                       imageEpisode: podcastEpisode.episode[index].imageUrl ?? "",
                       time: podcastEpisode.episode[index].totalTime ?? "",
                       favorite: favorite[index]
        )

        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .clear
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        ConstantPageListPodcast.cellSpacingHeightHeaderInSection
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        ConstantPageListPodcast.cellRowSpacingHeight
    }
}
