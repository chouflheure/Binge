import UIKit
import Firebase

class HomeViewController: UIViewController {
    
    var podcast = [Podcast]()
    var image = [UIImage]()
    var imageViewTest = UIImageView()

    let cellPodcast = "cellPodcast"
    private let homePageModel = HomePageModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupScrollView()
        initCollectionView()
        setGradientBackground()
        loadPodcast()
        setupAccessibility()
        homePageModel.homePageDelegate = self
        homePageModel.fetchAllPodcast()
    }
    
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    let scrollViewContainer: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    func containerMargin() -> UIStackView {
        
        let spacingTitleWithSwitch = UIView()
        let spacingBetweenSwith = UIView()
        let spacingSwitchWithTitlePodcast = UIView()
        
        let viewVertical = UIStackView()
        viewVertical.axis = .vertical
        viewVertical.distribution = .fill
        viewVertical.translatesAutoresizingMaskIntoConstraints = false
        viewVertical.addArrangedSubview(titleSwitchPlayer)
        viewVertical.addArrangedSubview(spacingTitleWithSwitch)
        viewVertical.addArrangedSubview(switchPlayerFirst)
        viewVertical.addArrangedSubview(spacingBetweenSwith)
        viewVertical.addArrangedSubview(switchPlayerSecond)
        viewVertical.addArrangedSubview(spacingSwitchWithTitlePodcast)
        viewVertical.addArrangedSubview(titlePodcast)
        
        let viewHorizontal = UIStackView()
        viewHorizontal.axis = .horizontal
        viewHorizontal.translatesAutoresizingMaskIntoConstraints = false
        let viewLeft = UIView()
        let viewRight = UIView()
        
        viewHorizontal.addArrangedSubview(viewLeft)
        viewHorizontal.addArrangedSubview(viewVertical)
        viewHorizontal.addArrangedSubview(viewRight)
        
        [
            viewLeft.widthAnchor.constraint(equalToConstant: 35),
            viewRight.widthAnchor.constraint(equalToConstant: 35),
            
            titleSwitchPlayer.heightAnchor.constraint(equalToConstant: 23),
            spacingTitleWithSwitch.heightAnchor.constraint(equalToConstant: 10),
            switchPlayerFirst.heightAnchor.constraint(equalToConstant: 102),
            spacingBetweenSwith.heightAnchor.constraint(equalToConstant: 20),
            switchPlayerSecond.heightAnchor.constraint(equalToConstant: 102),
            spacingSwitchWithTitlePodcast.heightAnchor.constraint(equalToConstant: 45),
            titlePodcast.heightAnchor.constraint(equalToConstant: 23),
        ].forEach{$0.isActive = true}
       
        return viewHorizontal
    }

    let imageView: UIImageView = {
        var imageView = UIImageView()
        let image = Assets.logo.image
        imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    let spacingImageWithTitle: UIView = {
        let spacingTitleSwitch = UIView()
        spacingTitleSwitch.frame.size.height = 10
        return spacingTitleSwitch
    }()
    
    let titleSwitchPlayer: UILabel = {
        let label = UILabel()
        label.text = "À écouter"
        label.font = UIFont(name: .fonts.proximaNova_Regular.fontName(), size: 22)
        label.textColor = Colors.darkBlue.color
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let switchPlayerFirst: SwitchPlayer = {
        let episode1 = Episode(
            title: "EPISODE 8",
            subtitle: "Tu dors ?",
            description: "",
            totalTime: "",
            imageUrl: "https://back.bingeaudio.fr/wp-content/uploads/2023/01/pp-vignette-carr%C3%A9e-%C3%A9pisode-768x768.png",
            playerUrl: "",
            podcastTitle: "DU SPORT"
        )

        let switchPlayerFirst = SwitchPlayer(
            episode: episode1
        )
        switchPlayerFirst.translatesAutoresizingMaskIntoConstraints = false
        return switchPlayerFirst
    }()
    
    let switchPlayerSecond: SwitchPlayer = {
        let episode2 = Episode(
            title: "EPISODE 106",
            subtitle: "Avec Lujipeka",
            description: "",
            totalTime: "",
            imageUrl: "https://back.bingeaudio.fr/wp-content/uploads/2021/12/soundcloud_cover_116-768x768.png",
            playerUrl: "",
            podcastTitle: "À bientôt de te revoir"
        )

        let switchPlayerSecond = SwitchPlayer(
            episode: episode2
        )
        switchPlayerSecond.translatesAutoresizingMaskIntoConstraints = false
        return switchPlayerSecond
    }()

    let titlePodcast: UILabel = {
        let label = UILabel()
        label.text = "Nos Podcasts"
        label.font = UIFont(name: .fonts.proximaNova_Regular.fontName(), size: 22)
        label.textColor = Colors.darkBlue.color
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let spacingTitleWithCollectionView: UIView = {
        let spacingTitleSwitch = UIView()
        spacingTitleSwitch.frame.size.height = 20
        return spacingTitleSwitch
    }()
    
    let collectionViewPodcast: UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 35, bottom: 0, right: 35)
        layout.itemSize = CGSize(width: 148, height: 200)
        layout.minimumLineSpacing = 20
        layout.scrollDirection = .horizontal
        
        let collectionViewPodcast = UICollectionView(frame: CGRect(x: 0,
                                                                   y: 30,
                                                                   width: UIScreen.main.bounds.width,
                                                                   height: 200), collectionViewLayout: layout)
        collectionViewPodcast.backgroundColor = .clear
        collectionViewPodcast.isScrollEnabled = true
        collectionViewPodcast.translatesAutoresizingMaskIntoConstraints = false
        collectionViewPodcast.showsVerticalScrollIndicator = false
        collectionViewPodcast.showsHorizontalScrollIndicator = false
        return collectionViewPodcast
    }()
    
    let viewOffsetCollectionnView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    private func setupAccessibility() {
        collectionViewPodcast.accessibilityLabel = "collection view which references all available podcasts, clicking on it takes you to the Podcast page"
        switchPlayerFirst.accessibilityLabel = "switch player, an element that allows you to launch or stop a podcast by clicking on it"
        switchPlayerSecond.accessibilityLabel = "switch player, an element that allows you to launch or stop a podcast by clicking on it"
        switchPlayerFirst.imageCircle.accessibilityLabel = "click on the image to start or stop a podcast"
        switchPlayerSecond.imageCircle.accessibilityLabel = "click on the image to start or stop a podcast"
    }
    
    private func setupScrollView() {
        view.addSubview(scrollView)

        scrollView.addSubview(scrollViewContainer)
        scrollViewContainer.addArrangedSubview(imageView)
        scrollViewContainer.addArrangedSubview(spacingImageWithTitle)
        scrollViewContainer.addArrangedSubview(containerMargin())
        scrollViewContainer.addArrangedSubview(spacingTitleWithCollectionView)
        scrollViewContainer.addArrangedSubview(collectionViewPodcast)
        scrollViewContainer.addArrangedSubview(viewOffsetCollectionnView)

        [
            scrollView.leftAnchor.constraint(equalTo: view.leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: view.rightAnchor),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: -45),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            scrollViewContainer.leftAnchor.constraint(equalTo: scrollView.leftAnchor),
            scrollViewContainer.rightAnchor.constraint(equalTo: scrollView.rightAnchor),
            scrollViewContainer.topAnchor.constraint(equalTo: scrollView.topAnchor),
            scrollViewContainer.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 10),
            scrollViewContainer.widthAnchor.constraint(equalTo: scrollView.widthAnchor),

            imageView.heightAnchor.constraint(equalToConstant: 260),
            collectionViewPodcast.heightAnchor.constraint(equalToConstant: 200),
            viewOffsetCollectionnView.heightAnchor.constraint(equalToConstant: 70)
        ].forEach{$0.isActive = true}
    }

    private func initCollectionView() {
        collectionViewPodcast.register(PodcastHomePageCollectionViewCell.self,
                                       forCellWithReuseIdentifier: cellPodcast)
        collectionViewPodcast.dataSource = self
        collectionViewPodcast.delegate = self
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

    private func toggleSelectedSwitchPlayer() {
        
    }

    let stackViewLoaderCollectionView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fill
        return stack
    }()
    
    private func loadPodcast() {

        let imageViewPlaceHolderFirst = UIView()
        imageViewPlaceHolderFirst.layer.cornerRadius = 20

        let imageViewPlaceHolderSecond = UIView()
        imageViewPlaceHolderSecond.layer.cornerRadius = 20

        let labelPlaceHolderFirst = UIView()
        let labelPlaceHolderSecond = UIView()
        
        let spacingBetweenStackPlaceholder = UIView()
        
        let stackPodcastPlaceholderFirst = UIStackView()
        stackPodcastPlaceholderFirst.axis = .vertical
        stackPodcastPlaceholderFirst.distribution = .fill
        stackPodcastPlaceholderFirst.spacing = 10

        let stackPodcastPlaceholderSecond = UIStackView()
        stackPodcastPlaceholderSecond.axis = .vertical
        stackPodcastPlaceholderSecond.distribution = .fill
        stackPodcastPlaceholderSecond.spacing = 10
        
        scrollViewContainer.addArrangedSubview(stackViewLoaderCollectionView)
        [
            stackViewLoaderCollectionView.leftAnchor.constraint(equalTo: scrollViewContainer.leftAnchor, constant: 30),
            stackViewLoaderCollectionView.heightAnchor.constraint(equalToConstant: 200),
            stackViewLoaderCollectionView.topAnchor.constraint(equalTo: titlePodcast.bottomAnchor, constant: 20),
            stackViewLoaderCollectionView.rightAnchor.constraint(equalTo: scrollViewContainer.rightAnchor, constant: -30)
        ].forEach{$0.isActive = true}
        
        
        stackViewLoaderCollectionView.addArrangedSubview(stackPodcastPlaceholderFirst)
        stackViewLoaderCollectionView.addArrangedSubview(spacingBetweenStackPlaceholder)
        stackViewLoaderCollectionView.addArrangedSubview(stackPodcastPlaceholderSecond)
        
        [
            stackPodcastPlaceholderFirst.widthAnchor.constraint(equalToConstant: 130),
            stackPodcastPlaceholderFirst.heightAnchor.constraint(equalToConstant: 200),
            stackPodcastPlaceholderSecond.widthAnchor.constraint(equalToConstant: 130),
            stackPodcastPlaceholderSecond.heightAnchor.constraint(equalToConstant: 200),
        ].forEach{$0.isActive = true}
        
        stackPodcastPlaceholderFirst.addArrangedSubview(imageViewPlaceHolderFirst)
        stackPodcastPlaceholderFirst.addArrangedSubview(labelPlaceHolderFirst)
        stackPodcastPlaceholderSecond.addArrangedSubview(imageViewPlaceHolderSecond)
        stackPodcastPlaceholderSecond.addArrangedSubview(labelPlaceHolderSecond)

        [
            imageViewPlaceHolderFirst.widthAnchor.constraint(equalToConstant: 130),
            imageViewPlaceHolderFirst.heightAnchor.constraint(equalToConstant: 130),
            labelPlaceHolderFirst.widthAnchor.constraint(equalToConstant: 130),
            labelPlaceHolderFirst.heightAnchor.constraint(equalToConstant: 30),
            imageViewPlaceHolderSecond.widthAnchor.constraint(equalToConstant: 130),
            imageViewPlaceHolderSecond.heightAnchor.constraint(equalToConstant: 130),
            labelPlaceHolderSecond.widthAnchor.constraint(equalToConstant: 130),
            labelPlaceHolderSecond.heightAnchor.constraint(equalToConstant: 30)
        ].forEach{$0.isActive = true}

        
        stackPodcastPlaceholderFirst.showLoader()
        stackPodcastPlaceholderFirst.ld_addLoader(corerRadiusGradient: 25)
        
        stackPodcastPlaceholderSecond.showLoader()
        stackPodcastPlaceholderSecond.ld_addLoader(corerRadiusGradient: 25)
    }
}
