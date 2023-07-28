
import UIKit


class PlayerViewController: UIViewController {
    
    let totalTimeTest: String = "01:01"
    var isPlaying: Bool = false
    var imageString: String = "play"
    var isFavorite: Bool = true
    var isSmallScreen: Bool = UIScreen.main.bounds.height < 800
    
    var isReturnButtonChevronLeft: Bool = false

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
    
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    let scrollViewContainer: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let stackReturnView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fill
        return stack
    }()
    
    let stackTopViewPlayer: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fill
        return stack
    }()
    
    let stackVerticalMenu:  UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fill
        return stack
    }()
    
    // MARK: - verticalStack Image
    var imageViewPlayer: UIStackView = {
        var stack = UIStackView()
        stack = stack.verticalStack()
        let image = UIImage(named: Assets.aBientotDeTeRevoir.name)
        let imageView = UIImageView(image: image)

        imageView.layer.cornerRadius = 30
        imageView.layer.masksToBounds = true
        
        stack.addArrangedSubview(imageView)

        stack.layer.cornerRadius = 30
        stack.layer.shadowRadius = 3
        stack.layer.shadowOffset = CGSize(width: 5, height: 5)
        stack.layer.shadowOpacity = 0.3
        stack.layer.shadowColor = UIColor.black.cgColor
        stack.layer.masksToBounds = false

        return stack
    }()

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
    
    let titlePodcast: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: .fonts.proximaNova_Semibold.fontName(), size: 20)
        label.numberOfLines = 1
        label.text = "A bientot de te revoir"
        label.textColor = Colors.yellow.color
        return label
    }()
    
    let subtitlePodcast: UILabel = {
        let label = UILabel()
        label.text = "Episode 112"
        label.font = UIFont(name: .fonts.proximaNova_Regular.fontName(), size: 17.0)
        label.textColor = .white
        label.numberOfLines = 1
        return label
    }()
    
    var slider: UISlider = {
        let slider = UISlider()

        slider.value = 0
        slider.minimumValue = 0
        slider.maximumValue = Float(slider.maximumValue.convertHoursToFloat(totalTime: "03:00:10"))

        slider.thumbTintColor = Colors.darkBlue.color
        slider.maximumTrackTintColor = Colors.ligthBlue.color
        slider.minimumTrackTintColor = Colors.darkBlue.color
        slider.setThumbImage(UIImage(named: Assets.Picto.thumb.name), for: .normal)
        slider.setThumbImage(UIImage(named: Assets.Picto.thumb.name), for: .highlighted)

        return slider
    }()

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

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = view
        setupUI()
        setupAction()
        setupDescription()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }

    // MARK: - Init
    /*
    init(isFavorite: Bool, isReturnButtonChevronLeft: Bool, imageViewPlayer: UIStackView, slider: UISlider, spendTime: UILabel, totalTime: UILabel) {
        self.isFavorite = isFavorite
        self.isReturnButtonChevronLeft = isReturnButtonChevronLeft
        self.imageViewPlayer = imageViewPlayer
        self.slider = slider
        self.spendTime = spendTime
        self.totalTime = totalTime
        super.init(nibName: nil, bundle: nil)
    }
    */
    /*/
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    */

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

    private func returnView() {
        let spacingBetweenImageAndTitle = UIView()
        spacingBetweenImageAndTitle.translatesAutoresizingMaskIntoConstraints = false
        let chevronReturn = UIImageView(image: UIImage(named: Assets.Picto.chevronReturn.name))
        chevronReturn.translatesAutoresizingMaskIntoConstraints = false

        let marginOnTop = UIView()
        marginOnTop.translatesAutoresizingMaskIntoConstraints = false
        scrollViewContainer.addArrangedSubview(marginOnTop)

        if isReturnButtonChevronLeft {
            let titleReturn: UILabel = {
                let label = UILabel()
                label.translatesAutoresizingMaskIntoConstraints = false
                label.text = L10n.podcast
                label.textColor = Colors.white.color
                label.font = UIFont(name: .fonts.proximaNova_Alt_Light.fontName(), size: 20)
                return label
            }()
            stackReturnView.addArrangedSubview(chevronReturn)
            stackReturnView.addArrangedSubview(spacingBetweenImageAndTitle)
            stackReturnView.addArrangedSubview(titleReturn)
        } else {
            let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
            chevronReturn.transform = chevronReturn.transform.rotated(by: .pi * 1.5)
            stackReturnView.addArrangedSubview(chevronReturn)
            stackReturnView.addArrangedSubview(view)
        }
        
        stackVerticalMenu.addArrangedSubview(generateVerticalSpace(height: 8))
        stackVerticalMenu.addArrangedSubview(setupMenuIndicator())
        stackVerticalMenu.addArrangedSubview(generateVerticalSpace(height: 8))

        let spacingBetweenReturnAndMenu = UIView()
        spacingBetweenReturnAndMenu.translatesAutoresizingMaskIntoConstraints = false
        
    
        stackTopViewPlayer.addArrangedSubview(stackReturnView)
        stackTopViewPlayer.addArrangedSubview(spacingBetweenReturnAndMenu)
        stackReturnView.addArrangedSubview(stackVerticalMenu)
        
        scrollViewContainer.addArrangedSubview(stackTopViewPlayer)

        [
            marginOnTop.heightAnchor.constraint(equalToConstant: 10),
            chevronReturn.widthAnchor.constraint(equalToConstant: 12),
            spacingBetweenImageAndTitle.widthAnchor.constraint(equalToConstant: 10),
            stackVerticalMenu.widthAnchor.constraint(equalToConstant: 25),
            stackVerticalMenu.rightAnchor.constraint(equalTo: stackTopViewPlayer.rightAnchor),
            stackTopViewPlayer.heightAnchor.constraint(equalToConstant: 21),
            
        ].forEach{$0.isActive = true}
        
    }

    private func setupPlayerView() {
        
        let horizontalStackTime: UIStackView = {
            var stack = UIStackView()
            stack = stack.horizontalStack()

            stack.addArrangedSubview(spendTime)
            stack.addArrangedSubview(totalTime)
            return stack
        }()
        
        
        // MARK: horizontal Stack Button Player
        let horizontalStackButtonPlayer: UIStackView = {
            let stack = UIStackView()
            stack.axis = .horizontal
            stack.alignment = .center
            stack.distribution = .fill

            let horizontalViewBetweenGeneralViewAndSeekLessButton = UIView()
            let horizontalViewBetweenSeekLessButtonAndPlayPauseButton = UIView()
            let horizontalViewBetweenPlayPauseButtonAndSeekMoreButton = UIView()
            let horizontalViewBetweenGeneralViewAndSeekMoreButton = UIView()

            [
                horizontalViewBetweenGeneralViewAndSeekLessButton.widthAnchor.constraint(equalToConstant: (UIScreen.main.bounds.width-Constants.widthPlayerButton) / 2),
                horizontalViewBetweenSeekLessButtonAndPlayPauseButton.widthAnchor.constraint(equalToConstant: 35),
                horizontalViewBetweenPlayPauseButtonAndSeekMoreButton.widthAnchor.constraint(equalToConstant: 35),
                horizontalViewBetweenGeneralViewAndSeekLessButton.heightAnchor.constraint(equalToConstant: 70)
            ].forEach{$0.isActive = true}
            
            let stackButtonSeekLess = UIStackView()
            stackButtonSeekLess.axis = .vertical
            stackButtonSeekLess.distribution = .fill
            let view1 = UIView()
            view1.translatesAutoresizingMaskIntoConstraints = false
            let view2 = UIView()
            view2.translatesAutoresizingMaskIntoConstraints = false
            stackButtonSeekLess.addArrangedSubview(view1)
            stackButtonSeekLess.addArrangedSubview(seekLessButton)
            stackButtonSeekLess.addArrangedSubview(view2)
            view1.heightAnchor.constraint(equalToConstant: (70 - 50)/2 ).isActive = true
            view2.heightAnchor.constraint(equalToConstant: (70 - 50)/2 ).isActive = true
            stackButtonSeekLess.widthAnchor.constraint(equalToConstant: 50).isActive = true
            stackButtonSeekLess.heightAnchor.constraint(equalToConstant: 70).isActive = true
            
            let stackButtonSeekMore = UIStackView()
            stackButtonSeekMore.axis = .vertical
            stackButtonSeekMore.distribution = .fill
            let view3 = UIView()
            view3.translatesAutoresizingMaskIntoConstraints = false
            
            let view4 = UIView()
            view4.translatesAutoresizingMaskIntoConstraints = false
            
            stackButtonSeekMore.addArrangedSubview(view3)
            stackButtonSeekMore.addArrangedSubview(seekMoreButton)
            stackButtonSeekMore.addArrangedSubview(view4)
            view3.heightAnchor.constraint(equalToConstant: (70 - 50)/2 ).isActive = true
            view4.heightAnchor.constraint(equalToConstant: (70 - 50)/2 ).isActive = true
            stackButtonSeekMore.widthAnchor.constraint(equalToConstant: 50).isActive = true
            stackButtonSeekMore.heightAnchor.constraint(equalToConstant: 70).isActive = true
            
            stack.addArrangedSubview(horizontalViewBetweenGeneralViewAndSeekLessButton)
            stack.addArrangedSubview(stackButtonSeekLess)
            stack.addArrangedSubview(horizontalViewBetweenSeekLessButtonAndPlayPauseButton)
            stack.addArrangedSubview(playPauseButton)
            stack.addArrangedSubview(horizontalViewBetweenPlayPauseButtonAndSeekMoreButton)
            stack.addArrangedSubview(stackButtonSeekMore)
            stack.addArrangedSubview(horizontalViewBetweenGeneralViewAndSeekMoreButton)

            return stack
        }()
        
        
        let marginOnTop = UIView()
        let spaceBetweenImageAndTitle = UIView()
        let spaceBetweenTitleAndSubtitle = UIView()
        let spaceBetweenSubtitleAndSlider = UIView()
        let spaceBetweenSliderAndTime = UIView()
        let spaceBetweenTimeAndButtonPlayer = UIView()
        let spacingBetweenTitleAndFavoriteBtn = UIView()
        
        [
            marginOnTop,
            spaceBetweenImageAndTitle,
            spaceBetweenTitleAndSubtitle,
            spaceBetweenSubtitleAndSlider,
            spaceBetweenSliderAndTime,
            spaceBetweenTimeAndButtonPlayer,
            spacingBetweenTitleAndFavoriteBtn
        ].forEach{$0.translatesAutoresizingMaskIntoConstraints = false}
        

        let stackViewPlayer = UIStackView()
        stackViewPlayer.axis = .vertical
        
        
        let stackViewTitleAndFavorite = UIStackView()
        stackViewTitleAndFavorite.axis = .horizontal
        
        stackViewTitleAndFavorite.addArrangedSubview(titlePodcast)
        stackViewTitleAndFavorite.addArrangedSubview(spacingBetweenTitleAndFavoriteBtn)
        stackViewTitleAndFavorite.addArrangedSubview(heartButton)
        
        stackViewPlayer.addArrangedSubview(marginOnTop)
        stackViewPlayer.addArrangedSubview(imageViewPlayer)
        stackViewPlayer.addArrangedSubview(spaceBetweenImageAndTitle)
        stackViewPlayer.addArrangedSubview(stackViewTitleAndFavorite)
        stackViewPlayer.addArrangedSubview(spaceBetweenTitleAndSubtitle)
        stackViewPlayer.addArrangedSubview(subtitlePodcast)
        stackViewPlayer.addArrangedSubview(spaceBetweenSubtitleAndSlider)
        stackViewPlayer.addArrangedSubview(slider)
        stackViewPlayer.addArrangedSubview(spaceBetweenSliderAndTime)
        stackViewPlayer.addArrangedSubview(horizontalStackTime)
        stackViewPlayer.addArrangedSubview(spaceBetweenTimeAndButtonPlayer)
        // horzotal stack player btn
        stackViewPlayer.addArrangedSubview(horizontalStackButtonPlayer)
        
        [
            // Margin between Stack return and image
            marginOnTop.heightAnchor.constraint(equalToConstant: 15),
            
            // Image Podcast
            imageViewPlayer.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 50),
            
            // Space Image - Title
            spaceBetweenImageAndTitle.heightAnchor.constraint(equalToConstant: isSmallScreen ? Constants.verticalSmallSpacer : Constants.verticalLargeSpacer),
            
            // Title Podcast
            stackViewTitleAndFavorite.heightAnchor.constraint(equalToConstant: 25),
            spacingBetweenTitleAndFavoriteBtn.widthAnchor.constraint(equalToConstant: 10),
            heartButton.widthAnchor.constraint(equalToConstant: 25),
            
            // Space Title - Subtitle
            spaceBetweenTitleAndSubtitle.heightAnchor.constraint(equalToConstant: 10),

            // Space Subtitle - Slider
            spaceBetweenSubtitleAndSlider.heightAnchor.constraint(equalToConstant: isSmallScreen ? Constants.verticalSmallSpacer : Constants.verticalMediumSpacer),
            
            // Slider
            
            // Space Slider - Time timer Podcast
            spaceBetweenSliderAndTime.heightAnchor.constraint(equalToConstant: 3),
            
            // Time timer Podcast
            
            
            // Space Title timer Podcast - Button Player
            spaceBetweenTimeAndButtonPlayer.heightAnchor.constraint(equalToConstant: 10),
            
            // Button Player
            playPauseButton.widthAnchor.constraint(equalToConstant: Constants.widthSquarePlayPauseButton),
            playPauseButton.heightAnchor.constraint(equalToConstant: Constants.widthSquarePlayPauseButton)
            
        ].forEach{$0.isActive = true}
        
        
        scrollViewContainer.addArrangedSubview(stackViewPlayer)
        
    }
  
    private func setupDescription() {
        
        let view = UIView()
        view.heightAnchor.constraint(equalToConstant: 300).isActive = true
        
        let marginTop = UIView()
        marginTop.translatesAutoresizingMaskIntoConstraints = false
        marginTop.heightAnchor.constraint(equalToConstant: Constants.verticalSmallSpacer).isActive = true
        
        var stackTitleAndFullScreen = UIStackView()
        stackTitleAndFullScreen = stackTitleAndFullScreen.horizontalStack()
        stackTitleAndFullScreen.alignment = .center
        stackTitleAndFullScreen.distribution = .fill
        
        let title = UILabel()
        title.text = L10n.description
        title.font = UIFont(name: .fonts.proximaNova_Alt_Bold.fontName(), size: 18)
        title.textColor = Colors.yellow.color

        let fullScreenButton = UIButton()
        fullScreenButton.generatedButton(isBordering: true,
                                         width: 30,
                                         height: 30,
                                         button: fullScreenButton,
                                         image: Assets.Picto.fullScreen.name,
                                         borderColor: .white.withAlphaComponent(0),
                                         backGroundColor: .white.withAlphaComponent(0.3)
        )
        
        fullScreenButton.addTarget(self, action: #selector(actionFullScreenButton), for: .touchUpInside)
        
        stackTitleAndFullScreen.addArrangedSubview(title)
        stackTitleAndFullScreen.addArrangedSubview(fullScreenButton)
        
        let descritpion = UILabel()
        descritpion.text = """
            Cet été, A bientôt de te revoir accompagne les auditeur·ices avec le meilleur des quatre saisons. Le premier best-of est A bientôt de te revoir accompagne les auditeur·ices avec le meilleur des quatre saisons. Le premier best-of est est A bientôt de te revoir accompagne les auditeur·ices avec le meilleur des quatre saisons. Le premier best-of est est A bientôt de te revoir accompagne les auditeur·ices. Cet été, A bientôt de te revoir accompagne les auditeur·ices avec le meilleur des quatre saisons. Le premier best-of est A bientôt de te revoir accompagne les auditeur·ices avec le meilleur des quatre saisons. Le premier best-of est est A bientôt de te revoir accompagne les auditeur·ices avec le meilleur des quatre saisons. Le premier best-of est est A bientôt de te revoir accompagne les auditeur·ices. Cet été, A bientôt de te revoir accompagne les auditeur·ices avec le meilleur des quatre saisons. Le premier best-of est A bientôt de te revoir accompagne les auditeur·ices avec le meilleur des quatre saisons. Le premier best-of est est A bientôt de te revoir accompagne les auditeur·ices avec le meilleur des quatre saisons. Le premier best-of est est A bientôt de te revoir accompagne les auditeur·ices.
            """
        descritpion.setLineSpacing(lineSpacing: 8.0)
        descritpion.numberOfLines = 0
        descritpion.font = UIFont(name: .fonts.proximaNova_Alt_Thin.fontName(), size: 16)
        descritpion.textColor = Colors.white.color

        view.layer.cornerRadius = 33
        view.backgroundColor = Colors.purpleGradientMax.color.withAlphaComponent(0.8)

        view.addSubview(stackTitleAndFullScreen)
        view.addSubview(descritpion)
        
        view.layer.shadowRadius = 3
        view.layer.shadowOffset = CGSize(width: -2, height: -2)
        view.layer.shadowOpacity = 0.3
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.masksToBounds = false

        stackTitleAndFullScreen.translatesAutoresizingMaskIntoConstraints = false
        [
            stackTitleAndFullScreen.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            stackTitleAndFullScreen.heightAnchor.constraint(equalToConstant: 30),
            stackTitleAndFullScreen.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            stackTitleAndFullScreen.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            fullScreenButton.widthAnchor.constraint(equalToConstant: 30),
            fullScreenButton.heightAnchor.constraint(equalToConstant: 30)
        ].forEach{ $0.isActive = true }
        
        descritpion.translatesAutoresizingMaskIntoConstraints = false
        [
            descritpion.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 20),
            descritpion.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
            descritpion.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            descritpion.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20)
        ].forEach{ $0.isActive = true }
        
        scrollViewContainer.addArrangedSubview(marginTop)
        scrollViewContainer.addArrangedSubview(view)
    }
    
}

// MARK: - Action
private extension PlayerViewController {
    
    func setupAction() {
        
        // Tap gesture Return
        let tapDismiss = UITapGestureRecognizer(target: self, action: #selector(tapStackReturn(_:)))
        stackReturnView.isUserInteractionEnabled = true
        stackReturnView.addGestureRecognizer(tapDismiss)

        // Tap gesture menu 3 points
        let tapMenu = UITapGestureRecognizer(target: self, action: #selector(shareAll(_:)))
        stackVerticalMenu.isUserInteractionEnabled = true
        stackVerticalMenu.addGestureRecognizer(tapMenu)

        // Favorite button
        heartButton.addTarget(self, action: #selector(actionPressFavoriteButton(_:)), for: .touchUpInside)
        
        // Slider
        slider.addTarget(self, action: #selector(actionSliderValueChanged(_:)), for: .valueChanged)
        
        // Action Button
        seekLessButton.addTarget(self, action: #selector(actionPressButtonLightColor(_:)), for: .touchUpInside)
        seekLessButton.addTarget(self, action: #selector(actionPressMoinsSeekButton(_:)), for: .touchDown)
        seekLessButton.addTarget(self, action: #selector(actionPressButtonLightColor(_:)), for: .allEvents)
        playPauseButton.addTarget(self, action: #selector(actionPressButtonLightColor(_:)), for: .touchUpInside)
        playPauseButton.addTarget(self, action: #selector(actionPressPlayPauseButton(_:)), for: .touchDown)
        playPauseButton.addTarget(self, action: #selector(actionPressButtonLightColor(_:)), for: .allEvents)
        seekMoreButton.addTarget(self, action: #selector(actionPressButtonLightColor(_:)), for: .touchUpInside)
        seekMoreButton.addTarget(self, action: #selector(actionPressPlusSeekButton(_:)), for: .touchDown)
        seekMoreButton.addTarget(self, action: #selector(actionPressButtonLightColor(_:)), for: .allEvents)
    }
}

// MARK: - Action
private extension PlayerViewController {
    
    @objc func actionSliderValueChanged(_ sender: Any) {
        print("@@@ actionnSlider")
        spendTime.text = spendTime.text?.secondsToHoursMinutesSecondsToString(Int(slider.value))
    }
    
    @objc func actionPressButtonLightColor(_ sender: UIButton) {
        UIView.animate(withDuration: 0.1, delay: 0.1) {
            sender.layer.borderColor = Colors.darkBlue.color.withAlphaComponent(1).cgColor
        }
    }
    
    @objc func actionPressFavoriteButton(_ sender: UIButton) {
        print("@@@ click favorite")

        var imageString = String()
        if isFavorite {
            imageString = Assets.Picto.Favorite.favoriteSelectedWhite.name
        } else {
            imageString = Assets.Picto.Favorite.favoriteUnselectedWhite.name
        }
        isFavorite = !isFavorite
        
        sender.changeSizeButton(button: sender, imageWidth: 25, imageString: imageString)
    }
    
    @objc func actionPressMoinsSeekButton(_ sender: UIButton) {
        sender.layer.borderColor = Colors.darkBlue.color.withAlphaComponent(0.3).cgColor
        print("@@@ click moins seek")
    }
    
    @objc func actionPressPlayPauseButton(_ sender: UIButton) {
        sender.layer.borderColor = Colors.darkBlue.color.withAlphaComponent(0.3).cgColor

        var imageString = String()
        if isPlaying {
            imageString = Assets.Picto.pause.name
        } else {
            imageString = Assets.Picto.Play.play.name
        }
        isPlaying = !isPlaying

        sender.changeSizeButton(button: sender, imageWidth: Constants.widthSquarePlayPauseButton / 2, imageString: imageString)
        print("@@@ click play pause")
    }
    
    @objc func actionPressPlusSeekButton(_ sender: UIButton) {
        sender.layer.borderColor = Colors.darkBlue.color.withAlphaComponent(0.3).cgColor
        print("@@@ click plus seek")
    }
    
    @objc func actionFullScreenButton(_ sender: UIButton) {
        let view = UIView()
        view.backgroundColor = .red
        view.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(view)
        [
            view.topAnchor.constraint(equalTo: self.view.topAnchor),
            view.heightAnchor.constraint(equalToConstant: 100),
            view.widthAnchor.constraint(equalToConstant: 100),
        ].forEach{$0.isActive = true}
        /*
        let playerVC = self.storyboard?.instantiateViewController(withIdentifier: "DescriptionPlayerViewController")
        playerVC?.modalPresentationStyle = .custom
        playerVC?.transitioningDelegate = self
        guard let playerVC = playerVC else {return}
        self.present(playerVC, animated: true, completion: nil)
         */
    }

    @objc func tapStackReturn(_ sender: UITapGestureRecognizer) {
        dismiss(animated: true)
    }
    
    @objc func shareAll(_ sender: UITapGestureRecognizer) {
        let text = "This is the text...."
        let myWebsite = NSURL(string:"https://stackoverflow.com/users/4600136/mr-javed-multani?tab=profile")
        let shareAll = [text, myWebsite!] as [Any]
        let activityViewController = UIActivityViewController(activityItems: shareAll, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        self.present(activityViewController, animated: true, completion: nil)
    }

}

private extension PlayerViewController {
    
    func setupMenuIndicator() -> UIStackView {
        
        let stackThreePoint = UIStackView()
        stackThreePoint.axis = .horizontal
        stackThreePoint.distribution = .fill

        let point1 = UIView()
        let point2 = UIView()
        let point3 = UIView()
        let spacingBetweenPoint1 = UIView()
        let spacingBetweenPoint2 = UIView()
        
        [
            stackThreePoint, point1, point2, point3, spacingBetweenPoint1, spacingBetweenPoint2
        ].forEach{$0.translatesAutoresizingMaskIntoConstraints = false}

        stackThreePoint.addArrangedSubview(generatePoint(width: 5))
        stackThreePoint.addArrangedSubview(generateHorizontalSpace(width: 5))
        stackThreePoint.addArrangedSubview(generatePoint(width: 5))
        stackThreePoint.addArrangedSubview(generateHorizontalSpace(width: 5))
        stackThreePoint.addArrangedSubview(generatePoint(width: 5))

        stackThreePoint.widthAnchor.constraint(equalToConstant: 25).isActive = true
        stackThreePoint.heightAnchor.constraint(equalToConstant: 5).isActive = true

        return stackThreePoint
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
