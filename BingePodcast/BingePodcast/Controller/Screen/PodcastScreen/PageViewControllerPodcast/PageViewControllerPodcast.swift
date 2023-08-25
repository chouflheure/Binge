import Foundation
import UIKit

class PageViewControllerPodcast: UIViewController {
    
    var titleLabel: UILabel?
    
    var page: PagePodcast
    
    init(with page: PagePodcast) {
        self.page = page
        print("@@@ page = \(self.page)")
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let cellSpacingHeight: CGFloat = 5
        
    let episodeArray = ["Episode 1", "Episode 2", "Episode 3", "Episode 4", "Episode 5", "Episode 6", "Episode 7", "Episode 8"]
        
    let titleEpisode = ["Les jeux olympiques sont ils utilent", "À quoi ca sert de courir ?", "Peut-on toujours repous…", "Pourquoi les ballons no…", "Les jeux olympiques s…", "À quoi ca sert de courir ?", "Peut-on toujours repous…", "Pourquoi les ballons no…"]
        
    let favorite = [true, false, false, true, false, true, true, true]

    let time = ["12:45", "12:45", "12:45", "12:45", "12:45", "12:45", "12:45", "12:45"]
    
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
        tableViewEpisode.register(UINib(nibName: "CellEpisodeTabViewCell", bundle: nil), forCellReuseIdentifier: "cellEpisode")
        tableViewEpisode.backgroundColor = .clear
    }
    
}

extension PageViewControllerPodcast: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            print("@@@ select at \(indexPath)")
        }
}

extension PageViewControllerPodcast: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        episodeArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let index = indexPath.section
        
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "cellEpisode",
            for: indexPath as IndexPath) as? CellEpisodeTabViewCell
        
        guard let cell = cell else {return UITableViewCell()}
        
        cell.setupCell(title: episodeArray[index], subtitle: titleEpisode[index], imageEpisode: imagePodcastString, time: time[index], favorite: favorite[index])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .clear
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        cellSpacingHeight
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        82
    }
}



/*

import Lottie

class PodcastViewController: UIViewController {
    
    private var animationView: AnimationView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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

*/
