import Foundation
import UIKit
import Lottie
import ListPlaceholder

class PageListFavorite: UIViewController {
    
    private let cellEpisodeTabViewCell = "CellEpisodeTabViewCell"
    
    var podcastSaved = [PodcastSaved]()
    var tableViewEpisode = UITableView()
    private var animationView: AnimationView?

    init(with podcastElemet: [PodcastSaved]) {
        self.podcastSaved = podcastElemet
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        if podcastSaved[0].titlePocast == "" {
            initAimation()
        } else {
            initTableView()
        }
    }
    
    private func initAimation() {
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

// MARK: - Extension TableView
private extension PageListFavorite {
   
    private func initTableView() {
        tableViewEpisode.delegate = self
        tableViewEpisode.dataSource = self
        tableViewEpisode.register(UINib(nibName: "CellEpisodeTabViewCell", bundle: nil),
                                  forCellReuseIdentifier: "cellEpisode")

        tableViewEpisode.backgroundColor = .clear
        tableViewEpisode.separatorColor = .clear
        tableViewEpisode.showsVerticalScrollIndicator = false
        tableViewEpisode.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(tableViewEpisode)
        [
            tableViewEpisode.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            tableViewEpisode.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            tableViewEpisode.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            tableViewEpisode.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 82)
        ].forEach{$0.isActive = true}
        
        offSetTopSectionTableView()
        offSetTableviewToTabBar()
    }
    
    private func offSetTopSectionTableView() {
        if #available(iOS 15.0, *) {
            tableViewEpisode.sectionHeaderTopPadding = 0
        }
    }
    
    private func offSetTableviewToTabBar() {
        let footerView = UIView()
        footerView.frame.size.height = 90
        tableViewEpisode.tableFooterView = footerView
    }
}
