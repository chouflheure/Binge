/*

import UIKit

enum Pages: CaseIterable {
    case pageZero
    case pageOne
    case pageTwo
    case pageThree
    case pageFour
    
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
        case .pageFour:
            return "This is page Four"
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
        case .pageFour:
            return 4
        }
    }
}

class TestPageViewController: UIViewController {

    private let cellPodcast = "cellPodcast"
    private let cellEpisodeTableView = "cellEpisodeTableView"
    private let cellEpisodeTabViewCell = "CellEpisodeTabViewCell"

    let carouselView = UIView()
    var actualIndexPathRow = 0
    private var pageController: UIPageViewController?
    private var pages: [Pages] = Pages.allCases
    private var currentIndex: Int = 0
    private var myCollectionViewPodcast: UICollectionView?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .lightGray
        
        self.setupPageController()
        
        view.addSubview(carouselView)
        carouselView.translatesAutoresizingMaskIntoConstraints = false
        [
            carouselView.heightAnchor.constraint(equalToConstant: 300),
            carouselView.leftAnchor.constraint(equalTo: view.leftAnchor),
            carouselView.rightAnchor.constraint(equalTo: view.rightAnchor),
            carouselView.topAnchor.constraint(equalTo: view.topAnchor)

        ].forEach{$0.isActive = true}
        
        carouselView.backgroundColor = .clear
        setupCollectionViewPodcast()
        
    }
    
    @objc private func swipeLeftToRight(_ sender: UISwipeGestureRecognizer) {
        print("@@@ swipe left to right")
        if actualIndexPathRow != 0 {
            positionCellWithIdexPath(indexCell: actualIndexPathRow - 1)
        }
    }
    
    @objc private func swipeRightToLeft(_ sender: UISwipeGestureRecognizer) {
        print("@@@ swipe right to left")
        if actualIndexPathRow != 4 {
            positionCellWithIdexPath(indexCell: actualIndexPathRow + 1)
        }
    }
    
    
    private func setupCollectionViewPodcast() {
 
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 30, left: 0, bottom: 10, right: 20)
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width - 200, height: 300)
        layout.scrollDirection = .horizontal

        myCollectionViewPodcast?.showsVerticalScrollIndicator = false
        myCollectionViewPodcast?.showsHorizontalScrollIndicator = false

        myCollectionViewPodcast = UICollectionView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 300), collectionViewLayout: layout)
        
        myCollectionViewPodcast?.register(CellPodcastCollectionViewCell.self, forCellWithReuseIdentifier: cellPodcast)
        myCollectionViewPodcast?.backgroundColor = .clear
        
        myCollectionViewPodcast?.dataSource = self
        myCollectionViewPodcast?.delegate = self

        carouselView.addSubview(myCollectionViewPodcast ?? UICollectionView())

        let swipeGestureRecognizerDownLeftToRight = UISwipeGestureRecognizer(target: self, action: #selector(swipeLeftToRight(_:)))
        let swipeGestureRecognizerDownRightToLeft = UISwipeGestureRecognizer(target: self, action: #selector(swipeRightToLeft(_:)))
        swipeGestureRecognizerDownRightToLeft.direction = .left
        swipeGestureRecognizerDownLeftToRight.direction = .right
        
        // carouselView.addGestureRecognizer(swipeGestureRecognizerDownLeftToRight)
        // carouselView.addGestureRecognizer(swipeGestureRecognizerDownRightToLeft)
        
        myCollectionViewPodcast?.isScrollEnabled = false
    }
    
    
    
    private func next() {
        print("@@@ click next")
        pageController?.goToNextPage()
    }
    
    private func previous() {
        print("@@@ click previous")
        pageController?.goToPreviousPage()
    }
    
    private func setupPageController() {
        self.pageController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        self.pageController?.dataSource = self
        self.pageController?.delegate = self
        self.pageController?.view.backgroundColor = .clear
        self.pageController?.view.frame = CGRect(x: 0,y: 300,width: self.view.frame.width,height: UIScreen.main.bounds.height - 300)
        
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
        
    let titleEpisode = ["Les jeux olympiques sont ils utilent", "À quoi ca sert de courir ?", "Peut-on toujours repous…", "Pourquoi les ballons no…", "Les jeux olympiques s…", "À quoi ca sert de courir ?", "Peut-on toujours repous…", "Pourquoi les ballons no…"]
        
    let favorite = [true, false, false, true, false, true, true, true]

    let time = ["12:45", "12:45", "12:45", "12:45", "12:45", "12:45", "12:45", "12:45"]
    
    let imagePodcastString = Assets.aBientotDeTeRevoir.name
    
    let tableViewEpisode = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(tableViewEpisode)
        
        let viewBottomTableView = UIView()
        
        view.addSubview(viewBottomTableView)
        viewBottomTableView.backgroundColor = .red
        viewBottomTableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableViewEpisode.translatesAutoresizingMaskIntoConstraints = false
        [
            tableViewEpisode.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            tableViewEpisode.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            tableViewEpisode.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            tableViewEpisode.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 82),
            viewBottomTableView.topAnchor.constraint(equalTo: tableViewEpisode.bottomAnchor),
            viewBottomTableView.heightAnchor.constraint(equalToConstant: 50)
        ].forEach{$0.isActive = true}
        
        initTableView()
    }
    
    private func initTableView() {
        tableViewEpisode.delegate = self
        tableViewEpisode.dataSource = self
        tableViewEpisode.register(UINib(nibName: "CellEpisodeTabViewCell", bundle: nil), forCellReuseIdentifier: "cellEpisode")
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

extension TestPageViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5 // How many cells to display
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let myCell = collectionView.dequeueReusableCell(withReuseIdentifier: cellPodcast, for: indexPath) as? CellPodcastCollectionViewCell
        
        guard let myCell = myCell else {return UICollectionViewCell()}
        // myCell.backgroundColor = UIColor.gray
        myCell.setUpUI(title: "", subtitlePodcast: Assets.aBientotDeTeRevoir.name, imagePodcastString: "")

        switch indexPath.row {
        case 0:  myCell.backgroundColor = .gray
        case 1:  myCell.backgroundColor = .blue
        case 2:  myCell.backgroundColor = .green
        case 3:  myCell.backgroundColor = .brown
        case 4:  myCell.backgroundColor = .black
        default: myCell.backgroundColor = UIColor.gray
        }

        return myCell
    }
}


extension TestPageViewController: UICollectionViewDelegate {
 
    private func positionCellWithIdexPath(indexCell: Int) {
        
        let attributesCollectionViewPodcast = myCollectionViewPodcast?.layoutAttributesForItem(
            at: IndexPath(row: indexCell, section: 0)
        )
        
        var height: CGFloat? = 0.0
        var width: CGFloat? = 0.0

        if attributesCollectionViewPodcast != nil {
            width = attributesCollectionViewPodcast!.frame.origin.x - attributesCollectionViewPodcast!.frame.width/2 - 10
            height = 0
        }

        let position = CGPoint(x: width ?? 0, y: height ?? 0)

        myCollectionViewPodcast?.setContentOffset(position, animated: true)

        
        if indexCell < actualIndexPathRow {
            previous()
        }
        if indexCell > actualIndexPathRow {
            next()
        }

        actualIndexPathRow = indexCell
    }

    // Methode qui permet de changer la tronche de la cell ( cacher le text, enlever le blur ... )
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        cellSelected(indexPath: indexPath)
        // TODO : ajouter une animation to blur

        positionCellWithIdexPath(indexCell: indexPath.row)
    }

    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
       print("@@@ didDeselect ")
        cellDeselected(indexPath: indexPath)
    }

    private func cellSelected(indexPath: IndexPath) {
        guard let cell = myCollectionViewPodcast?.cellForItem(at: indexPath) as? CellPodcastCollectionViewCell else {return}
        cell.imageViewPodcast.isHidden = false
    }
    
    private func cellDeselected(indexPath: IndexPath) {
        guard let cell = myCollectionViewPodcast?.cellForItem(at: indexPath) as? CellPodcastCollectionViewCell else {return}
        cell.imageViewPodcast.isHidden = true
    }
}
*/
