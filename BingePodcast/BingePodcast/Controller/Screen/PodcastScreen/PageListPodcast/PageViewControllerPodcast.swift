import Foundation
import UIKit

class ConstantPageListPodcast {
    static let cellSpacingHeightHeaderInSection: CGFloat = 5.0
    static let cellRowSpacingHeight: CGFloat = 82.0
    static let tableViewEpisodeTopConstraint: CGFloat  = 100
    static let tableViewEpisodehorizontalConstraint: CGFloat = 20
    static let tableViewEpisodeBottomConstraint: CGFloat = 82
}

class PageListPodcast: UIViewController {
    
    var titleLabel: UILabel?
    // var episode: [Episode]
    var podcastEpisode: PodcastEpisode
    let podcastPageModel: PodcastPageModel

    init(podcastEpisode: PodcastEpisode, podcastPageModel: PodcastPageModel /*episode: [Episode]*/) {
        // self.episode = episode
        self.podcastPageModel = podcastPageModel
        self.podcastEpisode = podcastEpisode
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    let favorite = [true, false, false, true, false, true, true, true,true, false, false, true, false, true, true, true,true, false, false, true, false, true, true, true,true, false, false, true, false, true, true, true,true, false, false, true, false, true, true, true,true, false, false, true, false, true, true, true]
    
    let imagePodcastString = Assets.aBientotDeTeRevoir.name
    
    let tableViewEpisode = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initTableView()
        initTableViewFooter()
    }
    
    private func initTableView() {
        tableViewEpisode.delegate = self
        tableViewEpisode.dataSource = self
        tableViewEpisode.register(UINib(nibName: "CellEpisodeTabViewCell", bundle: nil),
                                  forCellReuseIdentifier: "cellEpisode")
        tableViewEpisode.backgroundColor = .clear
        tableViewEpisode.showsVerticalScrollIndicator = false
        self.view.addSubview(tableViewEpisode)
        
        tableViewEpisode.translatesAutoresizingMaskIntoConstraints = false
        [
            tableViewEpisode.topAnchor.constraint(
                equalTo: view.topAnchor,
                constant: ConstantPageListPodcast.tableViewEpisodeTopConstraint
            ),
            tableViewEpisode.rightAnchor.constraint(
                equalTo: view.rightAnchor,
                constant: -ConstantPageListPodcast.tableViewEpisodehorizontalConstraint
            ),
            tableViewEpisode.leftAnchor.constraint(
                equalTo: view.leftAnchor,
                constant: ConstantPageListPodcast.tableViewEpisodehorizontalConstraint
            ),
            tableViewEpisode.bottomAnchor.constraint(
                equalTo: view.bottomAnchor,
                constant: ConstantPageListPodcast.tableViewEpisodeBottomConstraint
            )
        ].forEach{$0.isActive = true}
        
        tableViewEpisode.separatorColor = .clear
    }
    
    private func initTableViewFooter() {
        let footerView = UIView()
        footerView.frame.size.height = 90
        tableViewEpisode.tableFooterView = footerView
    }
    
}
