import Foundation
import UIKit
import Lottie

// Enum which indicates the status of the page to be displayed
enum FavoriteStatus {
    case favorite
    case seeLater
    case initialisation
}


class PageListFavorite: UIViewController {
    
    // MARK: - Init var
    var status: FavoriteStatus
    var tableViewEpisode = UITableView()
    var podcastSaved = [PodcastEpisode]()
    private let cellEpisodeTabViewCell = "CellEpisodeTabViewCell"
    private var animationView = AnimationView.init(name: "workinProgress")
    private let viewEmptyMessage = UIView(frame: CGRect(x: 0,
                                                        y: 0,
                                                        width: UIScreen.main.bounds.width,
                                                        height: UIScreen.main.bounds.height)
    )

    init(with podcastElemet: [PodcastEpisode], status: FavoriteStatus) {
        self.podcastSaved = podcastElemet
        self.status = status
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewWillAppear(_ animated: Bool) {
        if status == .seeLater {
            initAimation()
        } else {
            checkIfEmptyTableView()
        }
    }
    
    // This method can be used to determine whether or not the podcasts recorded are empty
    private func checkIfEmptyTableView() {
        print("@@@ podcastSaved.first?.podcast.title = \(podcastSaved.first?.podcast.title)")
        podcastSaved.isEmpty ? emptyViewMessage() : initTableView()
    }

    // This method is used to show the lottie animation "Working Progress"
    private func initAimation() {
        animationView.frame = view.bounds
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.animationSpeed = 0.5
        view.addSubview(animationView)
        animationView.play()

        view.backgroundColor = Colors.bluePodcastPage.color
    }
    
    // This method is used to set up the how to add a podcast to favourites message
    private func emptyViewMessage() {
        print("@@@ init emptyViewMessage")
        let labelEmptyMessage = UILabel()
        labelEmptyMessage.numberOfLines = 0
        labelEmptyMessage.translatesAutoresizingMaskIntoConstraints = false
        labelEmptyMessage.text = L10n.emptyFavoritePodcast
        labelEmptyMessage.textColor = Colors.darkBlue.color

        view.addSubview(viewEmptyMessage)
        viewEmptyMessage.addSubview(labelEmptyMessage)
        [
            labelEmptyMessage.topAnchor.constraint(equalTo: viewEmptyMessage.topAnchor,
                                                   constant: 50),
            labelEmptyMessage.leftAnchor.constraint(equalTo: viewEmptyMessage.leftAnchor,
                                                    constant: 70),
            labelEmptyMessage.rightAnchor.constraint(equalTo: viewEmptyMessage.rightAnchor,
                                                     constant: -70)
        ].forEach{$0.isActive = true}
        
        labelEmptyMessage.backgroundColor = .clear
        viewEmptyMessage.backgroundColor = .clear
        
        tableViewEpisode.removeFromSuperview()
    }
    
    // This method can be used to set up the gradient of the global view
    private func setGradientBackground() {
        let colorTop = Colors.ligthBlue.color.cgColor
        let colorBottom = Colors.white.color.cgColor

        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = self.view.bounds
                
        viewEmptyMessage.layer.insertSublayer(gradientLayer, at: 0)
    }
}

// MARK: - Extension TableView
private extension PageListFavorite {
   
    private func initTableView() {
        print("@@@ init tableview")
        viewEmptyMessage.removeFromSuperview()
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
    
    // This method ensures that the header sweeps over the other header when swiping.
    private func offSetTopSectionTableView() {
        if #available(iOS 15.0, *) {
            tableViewEpisode.sectionHeaderTopPadding = 0
        }
    }
    
    // This method allows you to scroll the table view behind the college bar. 
    private func offSetTableviewToTabBar() {
        let footerView = UIView()
        footerView.frame.size.height = 90
        tableViewEpisode.tableFooterView = footerView
    }
}
