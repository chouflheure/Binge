import UIKit

class PodcastViewController: UIViewController {

    let cellPodcast = "cellPodcast"
    let cellEpisodeTableView = "cellEpisodeTableView"
    let cellEpisodeTabViewCell = "CellEpisodeTabViewCell"

    let carouselView = UIView()
    // var actualIndexPathRow = 0
    var pageController: UIPageViewController?
    var pageControl: UIPageControl?
    var myCollectionViewPodcast: UICollectionView?

    var podcastEpisode = [PodcastEpisode]()
    let podcastPageModel = PodcastPageModel()
    
    var currentIndex: Int = 0
    let sizeCarousel: CGFloat = UIScreen.main.bounds.width - 200
    var offsetCell = CGFloat()
    let centerPageController: CGFloat = (UIScreen.main.bounds.width - 200) / 2

    override func viewDidLoad() {
        super.viewDidLoad()
        podcastPageModel.podcastPageDelegate = self
        podcastPageModel.fetchAllPodcast()
        initVar()
        setupCarousel()
        setGradientBackground()
        setupPageController()
        configurePageControl()
    }
    
    private func initVar() {
        offsetCell = (UIScreen.main.bounds.width - sizeCarousel) / 2
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
    
    private func setupCollectionViewPodcast() {

        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0,
                                           left: offsetCell,
                                           bottom: 0,
                                           right: 0)
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
        
        myCollectionViewPodcast?.dataSource = self
        myCollectionViewPodcast?.delegate = self

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
    
    func configurePageControl() {
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
    
    func next() {
        pageController?.goToNextPage()
    }
    
    func previous() {
        pageController?.goToPreviousPage()
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
    
    
    func setupPageController() {
        
        pageController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)

        pageController?.dataSource = self
        pageController?.delegate = self
        pageController?.view.backgroundColor = .clear
        pageController?.view.frame = CGRect(x: 0,
                                            y: myCollectionViewPodcast?.frame.height ?? 300,
                                            width: self.view.frame.width,
                                            height: UIScreen.main.bounds.height - (myCollectionViewPodcast?.frame.height ?? 300))
        
        guard let pageController = pageController else {return}
        self.addChild(pageController)
        self.view.addSubview(pageController.view)
    
        let initialVC = PageListPodcast(episode: [Episode(title: "",
                                                          subtitle: "",
                                                          description: "",
                                                          totalTime: "",
                                                          imageUrl: "",
                                                          playerUrl: "")])

        pageController.setViewControllers([initialVC], direction: .forward, animated: true, completion: nil)
        pageController.didMove(toParent: self)
    }
}
