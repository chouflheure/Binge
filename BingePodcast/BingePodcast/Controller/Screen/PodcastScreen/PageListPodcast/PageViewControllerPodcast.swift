import Foundation
import UIKit

class PageListPodcast: UIViewController {
    
    var titleLabel: UILabel?
    
    // var page: PagePodcast
    let episode: [Episode]
    
    init(episode: [Episode]) {
        self.episode = episode
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let cellSpacingHeight: CGFloat = 5

    let favorite = [true, false, false, true, false, true, true, true,true, false, false, true, false, true, true, true,true, false, false, true, false, true, true, true,true, false, false, true, false, true, true, true,true, false, false, true, false, true, true, true,true, false, false, true, false, true, true, true]
    
    let imagePodcastString = Assets.aBientotDeTeRevoir.name
    
    let tableViewEpisode = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(tableViewEpisode)
        
        tableViewEpisode.translatesAutoresizingMaskIntoConstraints = false
        [
            tableViewEpisode.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            tableViewEpisode.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            tableViewEpisode.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            tableViewEpisode.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 82)
        ].forEach{$0.isActive = true}
        
        let footerView = UIView()
        footerView.frame.size.height = 90
        tableViewEpisode.tableFooterView = footerView
       
        
        initTableView()
    }
    
    private func initTableView() {
        tableViewEpisode.delegate = self
        tableViewEpisode.dataSource = self
        tableViewEpisode.register(UINib(nibName: "CellEpisodeTabViewCell", bundle: nil),
                                  forCellReuseIdentifier: "cellEpisode")
        tableViewEpisode.backgroundColor = .clear
    }
    
}

