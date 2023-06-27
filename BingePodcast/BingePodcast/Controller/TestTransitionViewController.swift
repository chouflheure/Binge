
 import UIKit

enum Pages: CaseIterable {
    case pageZero
    case pageOne
    case pageTwo
    case pageThree
    
    var name: String {
        switch self {
        case .pageZero:
            return "This is page zero"
        case .pageOne:
            return "This is page one"
        case .pageTwo:
            return "This is page two"
        case .pageThree:
            return "This is page three"
        }
    }
    
    var index: Int {
        switch self {
        case .pageZero:
            return 0
        case .pageOne:
            return 1
        case .pageTwo:
            return 2
        case .pageThree:
            return 3
        }
    }
}

class TestPageViewController: UIViewController {

    private var pageController: UIPageViewController?
    private var pages: [Pages] = Pages.allCases
    private var currentIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("@@@ page : \(pages[0].index)")
        self.view.backgroundColor = .lightGray
        
        self.setupPageController()
        
        let btnPrevious = UIButton()
        let btnNext = UIButton()
        
        view.addSubview(btnNext)
        view.addSubview(btnPrevious)

        btnPrevious.setTitle("Previous", for: .normal)
        btnNext.setTitle("Next", for: .normal)
        
        btnPrevious.addTarget(self, action: #selector(previous(_:)), for: .touchUpInside)
        btnNext.addTarget(self, action: #selector(next(_:)), for: .touchUpInside)
        
        btnNext.translatesAutoresizingMaskIntoConstraints = false
        btnPrevious.translatesAutoresizingMaskIntoConstraints = false
        [
            btnNext.topAnchor.constraint(equalTo: view.topAnchor, constant: 40),
            btnPrevious.topAnchor.constraint(equalTo: view.topAnchor, constant: 40),
            btnPrevious.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 40),
            btnNext.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -40),
            btnNext.heightAnchor.constraint(equalToConstant: 30),
            btnPrevious.heightAnchor.constraint(equalToConstant: 30)
        ].forEach{$0.isActive = true}
    }
    
    @objc func next(_ sender: Any) {
        print("@@@ click next")
        pageController?.goToNextPage()
    }
    
    @objc func previous(_ sender: Any) {
        print("@@@ click previous")
        pageController?.goToPreviousPage()
    }
    
    private func setupPageController() {
        self.pageController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        self.pageController?.dataSource = self
        self.pageController?.delegate = self
        self.pageController?.view.backgroundColor = .clear
        self.pageController?.view.frame = CGRect(x: 0,y: 0,width: self.view.frame.width,height: self.view.frame.height)
        self.addChild(self.pageController!)
        self.view.addSubview(self.pageController!.view)
        
        let initialVC = PageVC(with: pages[0])
        
        self.pageController?.setViewControllers([initialVC], direction: .forward, animated: true, completion: nil)
        
        self.pageController?.didMove(toParent: self)
    }
}

extension TestPageViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let currentVC = viewController as? PageVC else {
            return nil
        }
        
        var index = currentVC.page.index
        
        if index == 0 {
            return nil
        }
        
        index -= 1
        
        let vc: PageVC = PageVC(with: pages[index])
        
        return vc
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let currentVC = viewController as? PageVC else {
            return nil
        }
        
        var index = currentVC.page.index
        
        if index >= self.pages.count - 1 {
            return nil
        }
        
        index += 1
        
        let vc: PageVC = PageVC(with: pages[index])
        
        return vc
    }
}

//
//  PageVC.swift
//  PageControllerTutorial
//
//  Created by Chris Larsen on 5/30/19.
//  Copyright © 2019 Tiger Bomb. All rights reserved.
//



class PageVC: UIViewController {
    
    var titleLabel: UILabel?
    
    var page: Pages
    
    init(with page: Pages) {
        self.page = page
        print("@@@ page = \(self.page)")
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let cellSpacingHeight: CGFloat = 5
        
    let episodeArray = ["Episode 1", "Episode 2", "Episode 3", "Episode 4", "Episode 5", "Episode 6", "Episode 7", "Episode 8"]
        
    let titleEpisode = ["Les jeux olympiques sont ils utilent", "À quoi ca sert de courir ?", "Peut-on toujours repous…",
                            "Pourquoi les ballons no…", "Les jeux olympiques s…", "À quoi ca sert de courir ?",
                            "Peut-on toujours repous…", "Pourquoi les ballons no…"]
        
    let favorite = [true, false, false, true, false, true, true, true]

    let time = ["12:45", "12:45", "12:45", "12:45", "12:45", "12:45", "12:45", "12:45"]
    
    let imagePodcastString = Assets.aBientotDeTeRevoir.name
    
    let tableViewEpisode = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(tableViewEpisode)
        // titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 21))
        // titleLabel?.center = CGPoint(x: 160, y: 250)
        // titleLabel?.textAlignment = NSTextAlignment.center
        // titleLabel?.text = page.name
        tableViewEpisode.translatesAutoresizingMaskIntoConstraints = false
        [
            tableViewEpisode.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            tableViewEpisode.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            tableViewEpisode.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            tableViewEpisode.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -82)
        ].forEach{$0.isActive = true}
        

        
        initTableView()
        
    }
    
    private func initTableView() {
        tableViewEpisode.delegate = self
        tableViewEpisode.dataSource = self
        tableViewEpisode.register(UINib(nibName: "CellPodcastViewController", bundle: nil), forCellReuseIdentifier: "cell")
        tableViewEpisode.backgroundColor = .clear
    }
    
}

extension PageVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            
            print("@@@ select at \(indexPath)")
           
        }
}

extension PageVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        episodeArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let index = indexPath.section
        
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "cell",
            for: indexPath as IndexPath) as? CellPodcastViewController
        
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
