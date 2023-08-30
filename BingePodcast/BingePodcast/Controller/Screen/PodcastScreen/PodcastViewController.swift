
// https://medium.com/@thomsmed/expandable-and-dynamic-sized-table-header-view-and-table-footer-view-6611ce0265b4

// link to resize 


import UIKit

class PodcastViewController: UIViewController {

    private let cellPodcast = "cellPodcast"
    private let cellEpisodeTableView = "cellEpisodeTableView"
    private let cellEpisodeTabViewCell = "CellEpisodeTabViewCell"

    let carouselView = UIView()
    var actualIndexPathRow = 0
    private var pageController: UIPageViewController?
    private var currentIndex: Int = 0
    private var myCollectionViewPodcast: UICollectionView?

    var podcast = [PodcastSaved]()

    let podcastPageModel = PodcastPageModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .lightGray
        
        podcastPageModel.podcastPageDelegate = self
        
        setupCarousel()
        
        
        
        podcast.append(PodcastSaved(titlePocast: "Du Sport", episodeSaved: [
            EpisodeSaved_test(titleEpisode: "Episode 1",
                              subtitleEpisode: "Les jeux olympiques sont ils utilent",
                              totalTimeEpisode: "12:45",
                              favorite: true,
                              imageEpisode: Assets.aBientotDeTeRevoir.name),
            
            EpisodeSaved_test(titleEpisode: "Episode 2",
                              subtitleEpisode: "À quoi ca sert de courir ?",
                              totalTimeEpisode: "12:45",
                              favorite: true,
                              imageEpisode: Assets.aBientotDeTeRevoir.name),
            
            EpisodeSaved_test(titleEpisode: "Episode 3",
                              subtitleEpisode: "Peut-on toujours repousser les limites ?",
                              totalTimeEpisode: "12:45",
                              favorite: true,
                              imageEpisode: Assets.aBientotDeTeRevoir.name),
            
            EpisodeSaved_test(titleEpisode: "Episode 4",
                              subtitleEpisode: "Pourquoi les ballons no…",
                              totalTimeEpisode: "12:45",
                              favorite: true,
                              imageEpisode: Assets.aBientotDeTeRevoir.name),
        ]))

        podcast.append(PodcastSaved(titlePocast: "Les couilles sur la table", episodeSaved: [
            EpisodeSaved_test(titleEpisode: "Episode 1",
                              subtitleEpisode: "Test",
                              totalTimeEpisode: "12:45",
                              favorite: true,
                              imageEpisode: Assets.aBientotDeTeRevoir.name),

            EpisodeSaved_test(titleEpisode: "Episode 2",
                              subtitleEpisode: "Test",
                              totalTimeEpisode: "12:45",
                              favorite: true,
                              imageEpisode: Assets.aBientotDeTeRevoir.name),

            EpisodeSaved_test(titleEpisode: "Episode 3",
                              subtitleEpisode: "Peut-on toujours repousser les limites ?",
                              totalTimeEpisode: "12:45",
                              favorite: true,
                              imageEpisode: Assets.aBientotDeTeRevoir.name)
        ]))
        
        print("@@@@@ Podcast = \(podcast)")
        print("@@@@@ Podcast count = \(podcast.count)")
        
        setupPageController()
        
        podcastPageModel.fetchAllPodcast()
        
    }
    
    private func setupCarousel() {
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
        if actualIndexPathRow != podcast.count {
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

        myCollectionViewPodcast = UICollectionView(
            frame: CGRect( x: 0, y: 0, width: UIScreen.main.bounds.width, height: 300),
            collectionViewLayout: layout)
        
        myCollectionViewPodcast?.register(CellPodcastCollectionViewCell.self, forCellWithReuseIdentifier: cellPodcast)
        myCollectionViewPodcast?.backgroundColor = .clear
        
        myCollectionViewPodcast?.dataSource = self
        myCollectionViewPodcast?.delegate = self

        carouselView.addSubview(myCollectionViewPodcast ?? UICollectionView())

        let swipeGestureRecognizerDownLeftToRight = UISwipeGestureRecognizer(target: self, action: #selector(swipeLeftToRight(_:)))
        let swipeGestureRecognizerDownRightToLeft = UISwipeGestureRecognizer(target: self, action: #selector(swipeRightToLeft(_:)))
        swipeGestureRecognizerDownRightToLeft.direction = .left
        swipeGestureRecognizerDownLeftToRight.direction = .right
        
        carouselView.addGestureRecognizer(swipeGestureRecognizerDownLeftToRight)
        carouselView.addGestureRecognizer(swipeGestureRecognizerDownRightToLeft)
        
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

        // dataSource at nil to remove the swipe
        self.pageController?.dataSource = self
        self.pageController?.delegate = self
        self.pageController?.view.backgroundColor = .clear
        self.pageController?.view.frame = CGRect(x: 0,
                                                 y: 300,
                                                 width: self.view.frame.width,
                                                 height: UIScreen.main.bounds.height - 300)
        
        guard let pageController = pageController else {return}
        
        self.addChild(pageController)
        self.view.addSubview(pageController.view)
        
        let initialVC = PageViewControllerPodcast(episode: podcast[currentIndex].episodeSaved) //with: pages[0])
        
        self.pageController?.setViewControllers([initialVC], direction: .forward, animated: true, completion: nil)
        
        self.pageController?.didMove(toParent: self)
    }
}

extension PodcastViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let currentVC = viewController as? PageViewControllerPodcast else {return nil}
        if currentIndex == 0 {return nil}
        currentIndex -= 1

        let vc: PageViewControllerPodcast = PageViewControllerPodcast(episode: podcast[currentIndex].episodeSaved)
        return vc
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let currentVC = viewController as? PageViewControllerPodcast else {return nil}
        if currentIndex >= podcast.count - 1 {return nil}
        currentIndex += 1
        
        let vc: PageViewControllerPodcast = PageViewControllerPodcast(episode: podcast[currentIndex].episodeSaved)
        return vc
    }
}

extension PodcastViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        podcast.count // How many cells to display
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let myCell = collectionView.dequeueReusableCell(withReuseIdentifier: cellPodcast, for: indexPath) as? CellPodcastCollectionViewCell
        
        guard let myCell = myCell else {return UICollectionViewCell()}
        myCell.setUpUI(title: "", subtitlePodcast: Assets.aBientotDeTeRevoir.name, imagePodcastString: podcast[indexPath.row].episodeSaved.first?.imageEpisode ?? "")

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


extension PodcastViewController: UICollectionViewDelegate {
 
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

extension PodcastViewController: PodcastPageDelegate {
    func fetchPodcastList(result: [Podcast]) {
        print("@@@ result func = \(result)")
    }
}
