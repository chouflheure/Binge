import UIKit

class FavoriteViewController: UIViewController {

    // MARK: - Var declaration
    // Var declaration
    var pageController: UIPageViewController?
    var currentIndex: Int = 0
    var podcastSaved = [PodcastEpisode]()
    var seeLater = [PodcastEpisode]()
    var arrayPageListFavorite = [PageListFavorite]()
    var emptyPageListPodcast: PageListFavorite?
    var leftContainer: NSLayoutConstraint?

    // var Core data declaration
    let favoriteCoreData = "BingePodcast"
    let seeLaterCoreData = "SeeLater"
    var coreDataManagerFavorite: CoreDataManager? = nil
    var coreDataManagerSeeLater: CoreDataManager? = nil

    
    // MARK: - Compiled var
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

    private let line : UIView = {
        let line = UIView()
        line.backgroundColor = Colors.yellow.color
        line.layer.cornerRadius = 2
        return line
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear

        initDelegate()
        initVariable()
        setupTitlePageViewController()
        setGradientBackground()
        setupPageController()
    }

    override func viewWillAppear(_ animated: Bool) {
        let episodeSaved = coreDataManagerFavorite?.fetchFavoriteEpisode()
        guard let episodeSaved = episodeSaved else {return}
        podcastSaved = episodeSaved
        arrayPageListFavorite[0].podcastSaved = podcastSaved
        pageController?.setViewControllers([arrayPageListFavorite[0]],
                                          direction: .forward,
                                          animated: true,
                                          completion: nil)

        arrayPageListFavorite[0].tableViewEpisode.reloadData()
    }

    private func initDelegate() {
        // nil dataSource to disable the swipe gesture on PageController
        self.pageController?.dataSource = nil
        self.pageController?.delegate = self
    }

    private func initVariable() {
        coreDataManagerFavorite = CoreDataManager(
            coreDataStack: CoreDataStack(modelName: favoriteCoreData, useInMemoryStore: false)
        )

        coreDataManagerSeeLater = CoreDataManager(
            coreDataStack: CoreDataStack(modelName: "", useInMemoryStore: false)
        )
        
        emptyPageListPodcast = PageListFavorite(
            with: [ PodcastEpisode(podcast: Podcast(title: "",
                                            image: "",
                                            author: ""),
                                   episode: [Episode(title: "",
                                             subtitle: "",
                                             description: "",
                                             totalTime: "",
                                             imageUrl: "",
                                             playerUrl: "",
                                             podcastTitle: "")])],
            status: .initialisation)

        let test1 = PageListFavorite(with: podcastSaved, status: .favorite)
        let test2 = PageListFavorite(with: seeLater, status: .seeLater)

        arrayPageListFavorite.append(test1)
        arrayPageListFavorite.append(test2)
    }

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

        let tapFavorite = UITapGestureRecognizer(target: self,
                                                 action: #selector(self.previousPageController))
        favoriteTitle.addGestureRecognizer(tapFavorite)

        let tapSeeLater = UITapGestureRecognizer(target: self,
                                                 action: #selector(self.nextPageController))
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

    func setupPageController() {
        let initialVC = emptyPageListPodcast
        self.pageController?.view.backgroundColor = .clear
        self.pageController = UIPageViewController(transitionStyle: .scroll,
                                                   navigationOrientation: .horizontal,
                                                   options: nil
        )
        self.pageController?.view.frame = CGRect(x: 0,
                                                 y: 120,
                                                 width: self.view.frame.width,
                                                 height: self.view.frame.height - 120
        )
        guard let pageController = pageController else {return}
        guard let initialVC = initialVC else {return}

        pageController.setViewControllers([initialVC],
                                          direction: .forward,
                                          animated: true,
                                          completion: nil)

        pageController.didMove(toParent: self)

        self.addChild(pageController)
        self.view.addSubview(pageController.view)
    }
}
