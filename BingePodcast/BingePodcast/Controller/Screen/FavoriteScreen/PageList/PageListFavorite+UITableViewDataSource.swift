import Foundation
import UIKit

extension PageListFavorite: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        podcastSaved.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let view = UIView(frame: CGRect(x: 0,
                                        y: 0,
                                        width: tableView.frame.width,
                                        height: Constants_FavoritesViewController.heightHeader)
        )
        
        view.backgroundColor = .clear
        
        let blurEffect = UIBlurEffect(style: .light)
        let blurEffectView = UIVisualEffectView()
        blurEffectView.frame = CGRect(x: view.frame.origin.x,
                                      y: view.frame.origin.y,
                                      width: tableView.frame.width,
                                      height: Constants_FavoritesViewController.heightHeader)
        
        blurEffectView.clipsToBounds = true
        blurEffectView.alpha = 1

        view.insertSubview(blurEffectView, at: 0)
        blurEffectView.effect = blurEffect
        blurEffectView.layer.cornerRadius = 10

        let label = UILabel(frame: CGRect(x: 15,
                                          y: 0,
                                          width: view.frame.width - 15,
                                          height: Constants_FavoritesViewController.heightHeader)
        )

        label.font = UIFont(name: .fonts.proximaNova_Regular.fontName(), size: 20)
        label.text = podcastSaved[section].titlePocast
        label.textColor = Colors.darkBlue.color
        view.addSubview(label)
        
        return view
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        podcastSaved[section].episodeSaved.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        Constants_FavoritesViewController.heightHeader
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0,
                                        y: 0,
                                        width: tableView.frame.width,
                                        height:  Constants_FavoritesViewController.heightHeader)
        )
        view.backgroundColor = .clear
        return view
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        Constants_FavoritesViewController.heightCell
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let section = indexPath.section
        let row = indexPath.row
        
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "cellEpisode",
            for: indexPath as IndexPath) as? CellEpisodeTabViewCell
        
        guard let cell = cell else {return UITableViewCell()}
        
        let episode = podcastSaved[section].episodeSaved[row]
        
        cell.setupCell(title: episode.titleEpisode,
                       subtitle: episode.subtitleEpisode,
                       imageEpisode: episode.imageEpisode,
                       time: episode.totalTimeEpisode,
                       favorite: episode.favorite)

        return cell
    }
    
}
