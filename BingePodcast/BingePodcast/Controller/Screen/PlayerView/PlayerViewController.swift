
import UIKit
import AVFoundation

class PlayerViewController: UIViewController {

    // MARK: - Variable déclaration
    var podcastTitle: String = ""
    let totalTimeTest: String = "01:01"
    var isPlaying: Bool = false
    var imagePlayer: String = Assets.placeholderImage.name
    var isFavorite: Bool = false
    var isSmallScreen: Bool = UIScreen.main.bounds.height < 800
    var isReturnButtonChevronLeft: Bool = false
    let descriptionView = UIView()
    var favoriteEpisode = false
    let coreDataManager = CoreDataManager()
    var imageCallURL = ImageCallURL()
    var player = AVPlayer()

    // MARK: Gradient Color
    let gradient: CAGradientLayer = {
        let gradient = CAGradientLayer()
        gradient.type = .axial
        gradient.colors = [
            Colors.purpleGradientMax.color.cgColor,
            Colors.orangeGradientMin.color.cgColor
        ]
        gradient.locations = [0, 1, 1]
        return gradient
    }()
    
    // MARK: Scroll View
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    // MARK: Scroll View Container
    let scrollViewContainer: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: Return Button
    let stackReturnView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fill
        return stack
    }()
    
    // MARK: Stack containe menu and return button
    let stackTopViewPlayer: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fill
        return stack
    }()
    
    // MARK: - 3 points Menu
    let stackVerticalMenu:  UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fill
        return stack
    }()
    
    var imageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: Assets.placeholderImage.name))
        imageView.layer.cornerRadius = 30
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    // MARK: - Image View
    var imageViewPlayer: UIStackView = {
        var stack = UIStackView()
        stack = stack.verticalStack()

        stack.layer.cornerRadius = 30
        stack.layer.shadowRadius = 3
        stack.layer.shadowOffset = CGSize(width: 5, height: 5)
        stack.layer.shadowOpacity = 0.3
        stack.layer.shadowColor = UIColor.black.cgColor
        stack.layer.masksToBounds = false

        return stack
    }()

    // MARK: - Heart Button
    let heartButton: UIButton = {
        let button = UIButton()
        button.generatedButton(isBordering: false,
                               width: Constants.widthSquareSeekLessButton,
                               height: Constants.widthSquareSeekLessButton,
                               button: button,
                               image: Assets.Picto.Favorite.favoriteUnselectedWhite.name,
                               borderColor: .white.withAlphaComponent(0),
                               backGroundColor: .white.withAlphaComponent(0)
        )
        return button
    }()
    
    // MARK: - Title
    let titlePodcast: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: .fonts.proximaNova_Semibold.fontName(), size: 20)
        label.numberOfLines = 1
        label.textColor = Colors.yellow.color
        return label
    }()
    
    // MARK: - Subtitle
    let subtitlePodcast: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: .fonts.proximaNova_Regular.fontName(), size: 17.0)
        label.textColor = .white
        label.numberOfLines = 1
        return label
    }()
    
    // MARK: - Slider
    var slider: UISlider = {
        let slider = UISlider()

        slider.value = 0
        slider.minimumValue = 0
        slider.maximumValue = Float(slider.maximumValue.convertHoursToFloat(totalTime: "1"))

        slider.thumbTintColor = Colors.darkBlue.color
        slider.maximumTrackTintColor = Colors.ligthBlue.color
        slider.minimumTrackTintColor = Colors.darkBlue.color
        slider.setThumbImage(UIImage(named: Assets.Picto.thumb.name), for: .normal)
        slider.setThumbImage(UIImage(named: Assets.Picto.thumb.name), for: .highlighted)

        return slider
    }()

    // MARK: - Spend Time
    var spendTime: UILabel = {
        let spendTime = UILabel()
        spendTime.text = "00:00"
        spendTime.font = spendTime.font.withSize(12)
        spendTime.textColor = .white
        return spendTime
    }()
    
    // MARK: - Total Time
    var totalTime: UILabel = {
        let totalTime = UILabel()
        totalTime.text = "03:00:10"
        totalTime.textAlignment = .right
        totalTime.font = totalTime.font.withSize(12)
        totalTime.textColor = .white
        return totalTime
    }()
    
    // MARK: - Seek Less Button
    let seekLessButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.generatedButton(isBordering: true,
                               width: Constants.widthSquareSeekLessButton,
                               height: Constants.widthSquareSeekLessButton,
                               button: button,
                               image: Assets.Picto.seekLess.name,
                               borderColor: Colors.darkBlue.color,
                               backGroundColor: .white.withAlphaComponent(0)
        )
        return button
    }()
    
    
    // MARK: - Seek More Button
    let seekMoreButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.generatedButton(isBordering: true,
                               width: Constants.widthSquareSeekMoreButton,
                               height: Constants.widthSquareSeekMoreButton,
                               button: button,
                               image: Assets.Picto.seekMore.name,
                               borderColor: Colors.darkBlue.color,
                               backGroundColor: .white.withAlphaComponent(0)
        )
        return button
    }()
    
    // MARK: - Play Pause Button
    let playPauseButton: UIButton = {
        let button = UIButton()
        button.generatedButton(isBordering: true,
                               width: Constants.widthSquarePlayPauseButton,
                               height: Constants.widthSquarePlayPauseButton,
                               button: button,
                               image: Assets.Picto.pause.name,
                               borderColor: Colors.darkBlue.color,
                               backGroundColor: .white.withAlphaComponent(0)
        )
        return button
    }()
    
    var descriptionPodcast: UILabel = {
        var description = UILabel()
        description.setLineSpacing(lineSpacing: 8.0)
        description.numberOfLines = 0
        description.font = UIFont(name: .fonts.proximaNova_Alt_Thin.fontName(), size: 16)
        description.textColor = Colors.white.color
        return description
    }()
    
    // MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = view
        setupImagePlayer()
        setupUI()
        setupAction()
        setupDescription()
        setupAudioPlayer()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        checkIfPodcastIsFavorite()
    }
    
    private func setupImagePlayer() {
        imageViewPlayer.addArrangedSubview(imageView)

        imageCallURL.downloadImage(imagePlayer) { image, urlString in
            if let imageObject = image {
                // performing UI operation on main thread
                DispatchQueue.main.async {
                    guard let urlString = urlString else {return}
                    if self.imagePlayer == urlString {
                        self.imageView.image = imageObject
                    } else {}
                }
            }
        }
    }

    private func checkIfPodcastIsFavorite() {

        Task {
            if await coreDataManager.checkIfEpisodeIsFavorite(titleEpisode: titlePodcast.text ?? "",
                                                              subtitleEpisode: subtitlePodcast.text ?? "") {
                heartButton.changeSizeButton(button: heartButton, imageString: Assets.Picto.Favorite.favoriteSelectedWhite.name)
                isFavorite = true
            } else {
                heartButton.changeSizeButton(button: heartButton, imageString: Assets.Picto.Favorite.favoriteUnselectedWhite.name)
                isFavorite = false
            }
        }
    }
    
    func setupAudioPlayer(){

        let url = URL(string: "https://sphinx.acast.com/a-bientot-de-te-revoir/la-presque-100eme/media.mp3")
        let playerItem = AVPlayerItem(url: url!)
        player = AVPlayer(playerItem:playerItem)
        player.play()

        NotificationCenter.default.addObserver(self, selector: #selector(playerDidFinishPlaying), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: player.currentItem)
        
        let _ = player.addPeriodicTimeObserver(forInterval: CMTime(seconds: 1, preferredTimescale: CMTimeScale(NSEC_PER_SEC)), queue: DispatchQueue.main) { [weak self] (time) in
            self?.updateSlider(time: time)
        }

    }
    
    @objc func playerDidFinishPlaying(note: NSNotification) {
        player.pause()
        print("@@@ The audio file is complete!")
    }
    
    func updateSlider(time:CMTime){
        let duration = CMTimeGetSeconds(player.currentItem!.asset.duration)
        self.slider.value = Float(CMTimeGetSeconds(time)) / Float(duration)
        spendTime.text = "\(self.slider.value)"
    }


    @objc func audioPlaybackSlider(_ sender: Any) {

        let duration = CMTimeGetSeconds(player.currentItem!.asset.duration)
        let value = self.slider.value
        spendTime.text = "\(self.slider.value)"
        let durationToSeek = Float(duration) * value

        self.player.seek(to: CMTimeMakeWithSeconds(Float64(durationToSeek),preferredTimescale: player.currentItem!.duration.timescale)) { [](state) in

        }

    }
    
    
    
    private func setupUI() {
        setupGradient()
        setupScrollView()
        returnView()
        setupPlayerView()
    }
    
    private func setupGradient() {
        gradient.frame = view.bounds
        view.layer.addSublayer(gradient)
    }
    
    
    private func setupScrollView() {
        view.addSubview(scrollView)
        scrollView.addSubview(scrollViewContainer)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollViewContainer.translatesAutoresizingMaskIntoConstraints = false
        [
            scrollView.leftAnchor.constraint(equalTo: view.leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: view.rightAnchor),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            scrollViewContainer.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 25),
            scrollViewContainer.topAnchor.constraint(equalTo: scrollView.topAnchor),
            scrollViewContainer.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -10),
            scrollViewContainer.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 50),

        ].forEach{$0.isActive = true}
    }

    func generatePoint(width: CGFloat = 10) -> UIView {
        let view = UIView()
        view.widthAnchor.constraint(equalToConstant: width).isActive = true
        view.backgroundColor = .white
        view.layer.cornerRadius = 2.5
        return view
    }
    
    func generateHorizontalSpace(width: CGFloat = 10) -> UIView {
        let view = UIView()
        view.widthAnchor.constraint(equalToConstant: width).isActive = true
        return view
    }
    
    func generateVerticalSpace(height: CGFloat = 10 ) -> UIView {
        let view = UIView()
        view.heightAnchor.constraint(equalToConstant: height).isActive = true
        return view
    }
}

