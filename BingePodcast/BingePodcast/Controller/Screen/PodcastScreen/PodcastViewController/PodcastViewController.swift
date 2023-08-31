import UIKit

class PodcastViewController: UIViewController {

    let cellPodcast = "cellPodcast"
    let cellEpisodeTableView = "cellEpisodeTableView"
    let cellEpisodeTabViewCell = "CellEpisodeTabViewCell"

    let carouselView = UIView()
    var actualIndexPathRow = 0
    var pageController: UIPageViewController?
    var currentIndex: Int = 0
    var myCollectionViewPodcast: UICollectionView?

    var podcastEpisode = [PodcastEpisode]()
    let podcastPageModel = PodcastPageModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .lightGray
        podcastPageModel.podcastPageDelegate = self
        setupCarousel()
        setupPageController(test: PageListPodcast(episode: [Episode(title: "", subtitle: "", description: "", totalTime: "", imageUrl: "", playerUrl: "")]))
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
        if actualIndexPathRow != 0 {
            positionCellWithIdexPath(indexCell: actualIndexPathRow - 1)
        }
    }
    
    @objc private func swipeRightToLeft(_ sender: UISwipeGestureRecognizer) {
        if actualIndexPathRow != podcastEpisode.count {
            positionCellWithIdexPath(indexCell: actualIndexPathRow + 1)
        }
    }
    
    
    private func setupCollectionViewPodcast() {
 
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 30, left: 100, bottom: 10, right: 20)
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
    
    
    
    func next() {
        pageController?.goToNextPage()
    }
    
    func previous() {
        pageController?.goToPreviousPage()
    }
    
    
    
    func setupPageController(test: PageListPodcast) {
        
        pageController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)

        pageController?.dataSource = self
        pageController?.delegate = self
        pageController?.view.backgroundColor = .clear
        pageController?.view.frame = CGRect(x: 0,
                                            y: 300,
                                            width: self.view.frame.width,
                                            height: UIScreen.main.bounds.height - 300)
        
        // pageController?.view.backgroundColor = .red
        guard let pageController = pageController else {return}
        self.addChild(pageController)
        self.view.addSubview(pageController.view)

        let initialVC = test
        pageController.setViewControllers([initialVC], direction: .forward, animated: true, completion: nil)
        pageController.didMove(toParent: self)
    }
}
