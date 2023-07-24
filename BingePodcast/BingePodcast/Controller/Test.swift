
//
//  TestViewController.swift
//  BingePodcast
//
//  Created by charlesCalvignac on 17/06/2023.
//

import UIKit


class Test: UIViewController {
    
    let totalTimeTest: String = "01:01"
    var isPlaying: Bool = false
    var imageString: String = "play"
    var isFavorite: Bool = true
    var isSmallScreen: Bool = UIScreen.main.bounds.height < 800
    
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
        // slider.addTarget(self, action: #selector(actionSliderValueChanged(_:)), for: .valueChanged)

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
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
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
        // scrollViewContainer.addArrangedSubview(setupPlayerView())
        // scrollViewContainer.addArrangedSubview(descriptionView)
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
            
            
            // descriptionView.rightAnchor.constraint(equalTo: scrollView.rightAnchor, constant: -20),
            // descriptionView.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 20)
        ].forEach{$0.isActive = true}
        
    }
    
    
    private func returnView() {
        
        let marginOnTop = UIView()
        marginOnTop.translatesAutoresizingMaskIntoConstraints = false
        
        let chevronReturn = UIImageView(image: UIImage(named: Assets.Picto.chevronReturn.name))
        chevronReturn.translatesAutoresizingMaskIntoConstraints = false

        let spacingBetweenImageAndTitle = UIView()
        spacingBetweenImageAndTitle.translatesAutoresizingMaskIntoConstraints = false
        
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
        
        
        scrollViewContainer.addArrangedSubview(marginOnTop)
        scrollViewContainer.addArrangedSubview(stackReturnView)

        [
            marginOnTop.heightAnchor.constraint(equalToConstant: 50),
            stackReturnView.heightAnchor.constraint(equalToConstant: 21),
            chevronReturn.widthAnchor.constraint(equalToConstant: 12),
            spacingBetweenImageAndTitle.widthAnchor.constraint(equalToConstant: 10)
        ].forEach{$0.isActive = true}
        
    }


    private func setupPlayerView() {
        
        var horizontalStackTime: UIStackView = {
            var stack = UIStackView()
            stack = stack.horizontalStack()

            stack.addArrangedSubview(spendTime)
            stack.addArrangedSubview(totalTime)
            return stack
        }()
        
        
        // MARK: horizontal Stack Button Player
        var horizontalStackButtonPlayer: UIStackView = {
            var stack = UIStackView()
            stack = stack.horizontalStack()
            stack.alignment = .center
 
            let horizontalViewBetweenGeneralViewAndSeekLessButton = UIView()
            let horizontalViewBetweenSeekLessButtonAndPlayPauseButton = UIView()
            let horizontalViewBetweenPlayPauseButtonAndSeekMoreButton = UIView()
            let horizontalViewBetweenGeneralViewAndSeekMoreButton = UIView()

            [
                horizontalViewBetweenGeneralViewAndSeekLessButton.widthAnchor.constraint(equalToConstant: (UIScreen.main.bounds.width-Constants.widthPlayerButton) / 2),
                horizontalViewBetweenSeekLessButtonAndPlayPauseButton.widthAnchor.constraint(equalToConstant: 35),
                horizontalViewBetweenPlayPauseButtonAndSeekMoreButton.widthAnchor.constraint(equalToConstant: 35)
            ].forEach{$0.isActive = true}
            
            stack.addArrangedSubview(horizontalViewBetweenGeneralViewAndSeekLessButton)
            stack.addArrangedSubview(seekLessButton)
            stack.addArrangedSubview(horizontalViewBetweenSeekLessButtonAndPlayPauseButton)
            stack.addArrangedSubview(playPauseButton)
            stack.addArrangedSubview(horizontalViewBetweenPlayPauseButtonAndSeekMoreButton)
            stack.addArrangedSubview(seekMoreButton)
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
        stackViewPlayer.addArrangedSubview(subtitlePodcast)
        stackViewPlayer.addArrangedSubview(spaceBetweenTitleAndSubtitle)
        stackViewPlayer.addArrangedSubview(slider)
        stackViewPlayer.addArrangedSubview(spaceBetweenSliderAndTime)
        stackViewPlayer.addArrangedSubview(horizontalStackTime)
        stackViewPlayer.addArrangedSubview(spaceBetweenTimeAndButtonPlayer)
        // horzotal stack player btn
        
        [
            // Margin between Stack return and image
            marginOnTop.heightAnchor.constraint(equalToConstant: 25),
            
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
            spaceBetweenTimeAndButtonPlayer.heightAnchor.constraint(equalToConstant: 10)
            
            // Button Player
            
        ].forEach{$0.isActive = true}
        
        
        scrollViewContainer.addArrangedSubview(stackViewPlayer)
    }
    
    
    
    
    
    
}

// Setup Action
private extension Test {
    
    func setupAction() {
        
        // Tap gesture Return n
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapStackReturn(_:)))
        stackReturnView.isUserInteractionEnabled = true
        stackReturnView.addGestureRecognizer(tap)
        
        // Favorite button
        heartButton.addTarget(self, action: #selector(actionPressFavoriteButton(_:)), for: .touchUpInside)
        
        // Slider
        slider.addTarget(self, action: #selector(actionSliderValueChanged(_:)), for: .valueChanged)
        
        // Action Button
        seekLessButton.addTarget(seekLessButton, action: #selector(actionPressButtonLightColor(_:)), for: .touchUpInside)
        seekLessButton.addTarget(seekLessButton, action: #selector(actionPressMoinsSeekButton(_:)), for: .touchDown)
        seekLessButton.addTarget(seekLessButton, action: #selector(actionPressButtonLightColor(_:)), for: .allEvents)
        playPauseButton.addTarget(playPauseButton, action: #selector(actionPressButtonLightColor(_:)), for: .touchUpInside)
        playPauseButton.addTarget(playPauseButton, action: #selector(actionPressPlayPauseButton(_:)), for: .touchDown)
        playPauseButton.addTarget(playPauseButton, action: #selector(actionPressButtonLightColor(_:)), for: .allEvents)
        seekMoreButton.addTarget(seekMoreButton, action: #selector(actionPressButtonLightColor(_:)), for: .touchUpInside)
        seekMoreButton.addTarget(seekMoreButton, action: #selector(actionPressPlusSeekButton(_:)), for: .touchDown)
        seekMoreButton.addTarget(seekMoreButton, action: #selector(actionPressButtonLightColor(_:)), for: .allEvents)
    }
}
   

// MARK: - Set Up Button
private extension Test {
    

}


// MARK: - Action
private extension Test {
    
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
        let playerVC = self.storyboard?.instantiateViewController(withIdentifier: "DescriptionPlayerViewController")
        playerVC?.modalPresentationStyle = .custom
        playerVC?.transitioningDelegate = self
        guard let playerVC = playerVC else {return}
        self.present(playerVC, animated: true, completion: nil)
    }

    @objc func tapStackReturn(_ sender: UITapGestureRecognizer) {
        dismiss(animated: true)
    }

}
