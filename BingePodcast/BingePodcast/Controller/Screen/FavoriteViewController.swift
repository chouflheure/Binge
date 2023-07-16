//
//  ViewController.swift
//  PageControllerTutorial
//
//  Created by Chris Larsen on 5/30/19.
//  Copyright © 2019 Tiger Bomb. All rights reserved.
//

import UIKit


enum Pages: CaseIterable {
    case pageZero
    case pageOne
    
    var name: String {
        switch self {
        case .pageZero:
            return "This is page zero"
        case .pageOne:
            return "This is page two"
        }
    }
    
    var index: Int {
        switch self {
        case .pageZero:
            return 0
        case .pageOne:
            return 1
  
        }
    }
}

class FavoriteViewController: UIViewController {
    
    private var pageController: UIPageViewController?
    private var pages = Pages.allCases
    private var currentIndex: Int = 0
    private var leftContainer: NSLayoutConstraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        setupTitlePageViewController()
        setupPageController()
        setGradientBackground()
    }
    
    private func nextPagePoint() {
        seeLaterTitle.adjustsFontSizeToFitWidth = true
        favoriteTitle.adjustsFontSizeToFitWidth = true
        
        if currentIndex == 0 {
            seeLaterTitle.font = UIFont(name: .fonts.proximaNova_Bold.fontName(), size: 24)
            favoriteTitle.font = UIFont(name: .fonts.proximaNova_Regular.fontName(), size: 24)
            UIView.animate(withDuration: 0.3) {
                self.leftContainer!.constant += UIScreen.main.bounds.width - (self.favoriteTitle.intrinsicContentSize.width / 2) - (self.seeLaterTitle.intrinsicContentSize.width / 2) - 80
                self.view.layoutIfNeeded() // Assurez-vous d'appeler cette méthode pour mettre à jour l'affichage.
            }
            /*
            UIView.animate(withDuration: 0.4) {
                self.leftContainer.constant += UIScreen.main.bounds.width - (self.favoriteTitle.intrinsicContentSize.width / 2) - (self.seeLaterTitle.intrinsicContentSize.width / 2) - 80
                self.view.layoutIfNeeded()
                //self.line.frame.origin.x += UIScreen.main.bounds.width - (self.favoriteTitle.intrinsicContentSize.width / 2) - (self.seeLaterTitle.intrinsicContentSize.width / 2) - 80
            }*/
            currentIndex += 1
        }
    }
    
    private func previousPagePoint() {
        if currentIndex == 1 {
            seeLaterTitle.font = UIFont(name: .fonts.proximaNova_Regular.fontName(), size: 24)
            favoriteTitle.font = UIFont(name: .fonts.proximaNova_Bold.fontName(), size: 24)
           
            UIView.animate(withDuration: 0.3) {
                self.leftContainer!.constant -= UIScreen.main.bounds.width - (self.favoriteTitle.intrinsicContentSize.width / 2) - (self.seeLaterTitle.intrinsicContentSize.width / 2) - 80
                self.view.layoutIfNeeded() // Assurez-vous d'appeler cette méthode pour mettre à jour l'affichage.
            }
            currentIndex -= 1
        }
    }
    
    @objc private func nextPageController() {
        guard let pageController = pageController else {return}
        pageController.setViewControllers([PageList(with: pages[1])], direction: .forward, animated: true, completion: nil)
        nextPagePoint()
    }
    
    @objc private func previousPageController() {

        guard let pageController = pageController else {return}
        pageController.setViewControllers([PageList(with: pages[0])], direction: .reverse, animated: true, completion: nil)
        previousPagePoint()
    }
    
    let favoriteTitle : UILabel = {
        let label = UILabel()
        label.text = L10n.favorite
        label.font = UIFont(name: .fonts.proximaNova_Bold.fontName(), size: 24)
        label.textColor = Colors.darkBlue.color
        return label
    }()
    
    let seeLaterTitle : UILabel = {
        let label = UILabel()
        label.text = L10n.seeLater
        label.font = UIFont(name: .fonts.proximaNova_Regular.fontName(), size: 24)
        label.textColor = Colors.darkBlue.color
        return label
    }()
    
    let line : UIView = {
        let line = UIView()
        line.backgroundColor = Colors.yellow.color
        line.layer.cornerRadius = 2
        return line
    }()
    
    private func setupTitlePageViewController() {

        view.addSubview(favoriteTitle)
        view.addSubview(seeLaterTitle)
        view.addSubview(line)

        favoriteTitle.translatesAutoresizingMaskIntoConstraints = false
        seeLaterTitle.translatesAutoresizingMaskIntoConstraints = false
        line.translatesAutoresizingMaskIntoConstraints = false

        leftContainer = line.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 40)
        
        favoriteTitle.isUserInteractionEnabled = true
        seeLaterTitle.isUserInteractionEnabled = true

        [
            leftContainer!,
            favoriteTitle.topAnchor.constraint(equalTo: view.topAnchor, constant: 70),
            favoriteTitle.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 40),
            seeLaterTitle.topAnchor.constraint(equalTo: view.topAnchor, constant: 70),
            seeLaterTitle.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -40),
            line.topAnchor.constraint(equalTo: favoriteTitle.bottomAnchor, constant: 5),
            line.widthAnchor.constraint(equalToConstant: favoriteTitle.intrinsicContentSize.width),
            line.heightAnchor.constraint(equalToConstant: 2),
            line.centerXAnchor.constraint(equalTo: favoriteTitle.centerXAnchor)

        ].forEach{$0.isActive = true}
        
        let tapFavorite = UITapGestureRecognizer(target: self, action: #selector(self.previousPageController))
        favoriteTitle.addGestureRecognizer(tapFavorite)
        
        let tapSeeLater = UITapGestureRecognizer(target: self, action: #selector(self.nextPageController))
        seeLaterTitle.addGestureRecognizer(tapSeeLater)
        
    }
    
    
    private func setGradientBackground() {
        let colorTop = Colors.ligthBlue.color.cgColor
        let colorBottom = Colors.white.color.cgColor

        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = self.view.bounds
                
        self.view.layer.insertSublayer(gradientLayer, at: 0)
    }

    
    
    private func setupPageController() {
        
        self.pageController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        // nil dataSource to disable the swipe gesture on PageController
        self.pageController?.dataSource = nil
        self.pageController?.delegate = self
        self.pageController?.view.backgroundColor = .clear

        self.pageController?.view.frame = CGRect(
            x: 0,
            y: 120,
            width: self.view.frame.width,
            height: self.view.frame.height - 120
        )
        
        self.addChild(self.pageController!)
        self.view.addSubview(self.pageController!.view)
        
        
        let initialVC = PageList(with: pages[0])
        
        self.pageController?.setViewControllers([initialVC], direction: .forward, animated: true, completion: nil)
        
        self.pageController?.didMove(toParent: self)
    }
    
}

extension FavoriteViewController: UIPageViewControllerDelegate {
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return self.pages.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return self.currentIndex
    }
}





class EpisodeSaved {
    var titleEpisode = String()
    var subtitleEpisode = String()
    var totalTimeEpisode = String()
    var favorite = Bool()
    var imageEpisode = String()
    
    init(titleEpisode: String, subtitleEpisode: String, totalTimeEpisode: String, favorite: Bool, imageEpisode: String) {
        self.titleEpisode = titleEpisode
        self.subtitleEpisode = subtitleEpisode
        self.totalTimeEpisode = totalTimeEpisode
        self.favorite = favorite
        self.imageEpisode = imageEpisode
    }
}


class PodcastSaved {
    var titlePocast = String()
    var episodeSaved = [EpisodeSaved]()
    
    init(titlePocast: String, episodeSaved: [EpisodeSaved]) {
        self.titlePocast = titlePocast
        self.episodeSaved = episodeSaved
    }
}




class PageList: UIViewController {
    
    private let cellEpisodeTabViewCell = "CellEpisodeTabViewCell"
    
    var podcastSaved = [PodcastSaved]()
    var page: Pages
    let tableViewEpisode = UITableView()
    let cellSpacingHeight: CGFloat = 5
    
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
            EpisodeSaved(titleEpisode: "Episode 3", subtitleEpisode: "Peut-on toujours repousser les limites ?", totalTimeEpisode: "12:45", favorite: true, imageEpisode: Assets.aBientotDeTeRevoir.name),
            EpisodeSaved(titleEpisode: "Episode 4", subtitleEpisode: "Pourquoi les ballons no…", totalTimeEpisode: "12:45", favorite: true, imageEpisode: Assets.aBientotDeTeRevoir.name),
        ]))
        
        
        
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
           return podcastSaved.count
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
        return podcastSaved[section].episodeSaved.count
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
           return 40
    }
         
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
           return 100
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























