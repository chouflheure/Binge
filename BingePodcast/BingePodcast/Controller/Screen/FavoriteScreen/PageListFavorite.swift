import Foundation
import UIKit
import Lottie

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
        tableViewEpisode.register(UINib(nibName: "CellEpisodeTabViewCell", bundle: nil), forCellReuseIdentifier: "cellEpisode")
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


extension PageListFavorite: UIViewControllerTransitioningDelegate {
    
    public func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return PresentTransition()
    }
    
    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return DismissTransition()
    }

}


extension PageListFavorite: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let secondVC = mainStoryboard.instantiateViewController(withIdentifier: "PlayerViewController") as? PlayerViewController
        guard let secondVC = secondVC else {return}
        secondVC.isReturnButtonChevronLeft = true
        secondVC.modalPresentationStyle = .custom
        secondVC.transitioningDelegate = self

        self.present(secondVC, animated: true, completion: nil)
    }

}

extension PageListFavorite: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        podcastSaved.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let view = UIView(frame: CGRect(x: 0,
                                        y: 0,
                                        width: tableView.frame.width,
                                        height:  Constants_FavoritesViewController.heightHeader)
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
        
        cell.setupCell(title: episode.titleEpisode, subtitle: episode.subtitleEpisode, imageEpisode: episode.imageEpisode, time: episode.totalTimeEpisode, favorite: episode.favorite)
        
        return cell
    }
    
}
