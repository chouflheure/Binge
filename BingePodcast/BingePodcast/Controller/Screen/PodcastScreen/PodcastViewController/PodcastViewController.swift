import UIKit

class PodcastViewController: UIViewController {
    
    let cellPodcast = "cellPodcast"
    let cellEpisodeTableView = "cellEpisodeTableView"
    let cellEpisodeTabViewCell = "CellEpisodeTabViewCell"
    
    let carouselView = UIView()
    var pageController: UIPageViewController?
    var pageControl: UIPageControl?
    var myCollectionViewPodcast: UICollectionView?
    
    var podcastEpisode = [PodcastEpisode]()
    let podcastPageModel = PodcastPageModel()
    
    var arrayPageListPodcast = [PageListPodcast]()
    
    var currentIndex: Int = 0
    let sizeCarousel: CGFloat = UIScreen.main.bounds.width - 200
    var horizontalSectionInsetCollectionView = CGFloat()
    let centerPageController: CGFloat = (UIScreen.main.bounds.width - 200) / 2
    
    override func viewDidLoad() {
        super.viewDidLoad()
        podcastPageModel.fetchAllPodcast()
        initVar()
        setupCarousel()
        setupGradientBackground()
        setupPageController()
        initDelegate()
        setupPageControl()
    }
}

// MARK: - Set up
extension PodcastViewController {

    private func initVar() {
        horizontalSectionInsetCollectionView = (UIScreen.main.bounds.width - sizeCarousel) / 2
    }
    
    private func setupCarousel() {
        view.addSubview(carouselView)
        carouselView.translatesAutoresizingMaskIntoConstraints = false
        [
            carouselView.heightAnchor.constraint(equalToConstant: sizeCarousel),
            carouselView.leftAnchor.constraint(equalTo: view.leftAnchor),
            carouselView.rightAnchor.constraint(equalTo: view.rightAnchor),
            carouselView.topAnchor.constraint(equalTo: view.topAnchor)
        ].forEach{$0.isActive = true}
        
        carouselView.backgroundColor = Colors.yellow.color.withAlphaComponent(0.5)
        setupCollectionViewPodcast()
    }

    private func setupCollectionViewPodcast() {

        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0,
                                           left: horizontalSectionInsetCollectionView,
                                           bottom: 0,
                                           right: horizontalSectionInsetCollectionView)
        layout.itemSize = CGSize(width: sizeCarousel, height: sizeCarousel)
        layout.scrollDirection = .horizontal

        myCollectionViewPodcast?.showsVerticalScrollIndicator = false
        myCollectionViewPodcast?.showsHorizontalScrollIndicator = false

        myCollectionViewPodcast = UICollectionView(
            frame: CGRect(x: 0, y: 40, width: UIScreen.main.bounds.width, height: sizeCarousel),
            collectionViewLayout: layout)
        
        myCollectionViewPodcast?.register(CellPodcastCollectionViewCell.self,
                                          forCellWithReuseIdentifier: cellPodcast)

        myCollectionViewPodcast?.backgroundColor = .clear

        carouselView.addSubview(myCollectionViewPodcast ?? UICollectionView())

        let swipeGestureRecognizerDownLeftToRight = UISwipeGestureRecognizer(
            target: self, action: #selector(swipeLeftToRight(_:))
        )
        
        let swipeGestureRecognizerDownRightToLeft = UISwipeGestureRecognizer(
            target: self, action: #selector(swipeRightToLeft(_:))
        )
        
        swipeGestureRecognizerDownRightToLeft.direction = .left
        swipeGestureRecognizerDownLeftToRight.direction = .right
        
        carouselView.addGestureRecognizer(swipeGestureRecognizerDownLeftToRight)
        carouselView.addGestureRecognizer(swipeGestureRecognizerDownRightToLeft)
        
        myCollectionViewPodcast?.isScrollEnabled = false
    }

    private func setupGradientBackground() {
        let colorTop = Colors.ligthBlue.color.cgColor
        let colorBottom = Colors.white.color.cgColor
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = self.view.bounds
        self.view.layer.insertSublayer(gradientLayer, at: 0)

    }
    
    func setupPageController() {
        pageController = UIPageViewController(transitionStyle: .scroll,
                                              navigationOrientation: .horizontal,
                                              options: nil)

        pageController?.view.backgroundColor = .clear
        pageController?.view.frame = CGRect(x: 0,
                                            y: myCollectionViewPodcast?.frame.height ?? 300,
                                            width: self.view.frame.width,
                                            height: UIScreen.main.bounds.height - (myCollectionViewPodcast?.frame.height ?? 300))
        
        guard let pageController = pageController else {return}
        self.addChild(pageController)
        self.view.addSubview(pageController.view)

        let initialVC = PageListPodcast(
            podcastEpisode: PodcastEpisode(
                podcast: Podcast(title: "",
                                 image: "",
                                 author: ""
                                ),
                episode: [Episode(title: "",
                                  subtitle: "",
                                  description: "",
                                  totalTime: "",
                                  imageUrl: "",
                                  playerUrl: "",
                                 podcastTitle: "")]),
            podcastPageModel: podcastPageModel
        )

        pageController.setViewControllers([initialVC],
                                          direction: .forward,
                                          animated: true,
                                          completion: nil)

        pageController.didMove(toParent: self)
    }

    private func initDelegate() {
        podcastPageModel.podcastPageDelegate = self
        myCollectionViewPodcast?.dataSource = self
        myCollectionViewPodcast?.delegate = self
        pageController?.dataSource = nil
        pageController?.delegate = self
    }
    
    func setupPageControl() {
        self.pageControl = UIPageControl(frame: CGRectMake(centerPageController,
                                                           (sizeCarousel + 50),
                                                           200,
                                                           20))
        guard let pageControl = pageControl else {return}
        pageControl.isUserInteractionEnabled = false
        pageControl.numberOfPages = 6
        pageControl.currentPage = 0
        pageControl.pageIndicatorTintColor = .lightGray
        pageControl.currentPageIndicatorTintColor = Colors.yellow.color
        self.view.addSubview(pageControl)
     }
}

// MARK: - Action
extension PodcastViewController {
    @objc private func swipeLeftToRight(_ sender: UISwipeGestureRecognizer) {
        if currentIndex != 0 {
            positionCellWithIdexPath(indexCell: currentIndex - 1)
        }
    }
    
    @objc private func swipeRightToLeft(_ sender: UISwipeGestureRecognizer) {
        if currentIndex != podcastEpisode.count - 1 {
            positionCellWithIdexPath(indexCell: currentIndex + 1)
        }
    }
    
    func next() {
        print("@@@ next")
        // pageController?.goToNextPage()
        
        if currentIndex >= podcastEpisode.count - 1 {return}
        currentIndex += 1
        
        let vc: PageListPodcast = arrayPageListPodcast[currentIndex]

        pageControl?.currentPage = currentIndex
        
        pageController?.setViewControllers([vc], direction: .forward, animated: true, completion: nil)
    }
    
    func previous() {
        print("@@@ previous")
        
        if currentIndex == 0 {return}
        currentIndex -= 1

        let vc: PageListPodcast = arrayPageListPodcast[currentIndex]

        pageControl?.currentPage = currentIndex
        
        pageController?.setViewControllers([vc], direction: .reverse, animated: true, completion: nil)
    }
}
