

import Foundation
import UIKit

class PageListFavorite: UIViewController {
    
    private let cellEpisodeTabViewCell = "CellEpisodeTabViewCell"
    
    var podcastSaved = [PodcastSaved]()
    var tableViewEpisode = UITableView()
    
    var tableViewOrganisation = [Int]()
    
    init(with tableViewEpisode: UITableView) {
        self.tableViewEpisode = tableViewEpisode
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initTableView()
    }
    
    private func initTableView() {

        view.addSubview(tableViewEpisode)
        [
            tableViewEpisode.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            tableViewEpisode.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            tableViewEpisode.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            tableViewEpisode.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 82)
        ].forEach{$0.isActive = true}
    }

}
