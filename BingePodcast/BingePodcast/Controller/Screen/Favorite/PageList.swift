

import Foundation
import UIKit

class PageList: UIViewController {
    
    private let cellEpisodeTabViewCell = "CellEpisodeTabViewCell"
    
    var podcastSaved = [PodcastSaved]()
    var page: Pages
    let tableViewEpisode = UITableView()
    let cellSpacingHeight: CGFloat = 5
    let heightCell = 100.0
    let heightHeader = 40.0
    
    var tableViewOrganisation = [Int]()
    
    init(with page: Pages) {
        self.page = page
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        podcastSaved.append(PodcastSaved(titlePocast: "Du Sport", episodeSaved: [
            EpisodeSaved(titleEpisode: "Episode 1", subtitleEpisode: "Les jeux olympiques sont ils utilent", totalTimeEpisode: "12:45", favorite: true, imageEpisode: Assets.aBientotDeTeRevoir.name),
            EpisodeSaved(titleEpisode: "Episode 2", subtitleEpisode: "À quoi ca sert de courir ?", totalTimeEpisode: "12:45", favorite: true, imageEpisode: Assets.aBientotDeTeRevoir.name),
            EpisodeSaved(titleEpisode: "Episode 3", subtitleEpisode: "Peut-on toujours repousser les limites ?", totalTimeEpisode: "12:45", favorite: true, imageEpisode: Assets.aBientotDeTeRevoir.name),
            EpisodeSaved(titleEpisode: "Episode 4", subtitleEpisode: "Pourquoi les ballons no…", totalTimeEpisode: "12:45", favorite: true, imageEpisode: Assets.aBientotDeTeRevoir.name),
        ]))
        
        podcastSaved.append(PodcastSaved(titlePocast: "Les couilles sur la table", episodeSaved: [
            EpisodeSaved(titleEpisode: "Episode 1", subtitleEpisode: "Les jeux olympiques sont ils utilent", totalTimeEpisode: "12:45", favorite: true, imageEpisode: Assets.aBientotDeTeRevoir.name),
            EpisodeSaved(titleEpisode: "Episode 2", subtitleEpisode: "À quoi ca sert de courir ?", totalTimeEpisode: "12:45", favorite: true, imageEpisode: Assets.aBientotDeTeRevoir.name),
            EpisodeSaved(titleEpisode: "Episode 3", subtitleEpisode: "Peut-on toujours repousser les limites ?", totalTimeEpisode: "12:45", favorite: true, imageEpisode: Assets.aBientotDeTeRevoir.name)
        ]))
        
        
        
        initTableView()
        offSetTopSectionTableView()
        offSetTableviewToTabBar()
    }
    
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


extension PageList: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            print("@@@ select at \(indexPath)")
        }
}

extension PageList: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        podcastSaved.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 40))
        view.backgroundColor = .clear

        let blurEffect = UIBlurEffect(style: .light)
        let blurEffectView = UIVisualEffectView()
        blurEffectView.frame = CGRect(x: view.frame.origin.x, y: view.frame.origin.y , width: tableView.frame.width, height: 40 )
        blurEffectView.clipsToBounds = true
        blurEffectView.alpha = 1
        view.insertSubview(blurEffectView, at: 0)
        blurEffectView.effect = blurEffect

        let label = UILabel(frame: CGRect(x: 15, y: 0, width: view.frame.width - 15, height: 40))
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
        heightHeader
    }
         
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        heightCell
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

