//
//  TestViewController.swift
//  BingePodcast
//
//  Created by charlesCalvignac on 17/06/2023.
//

import UIKit


class PlayerViewController_old: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = view
        setupUI()
    }


    let totalTimeTest: String = "01:01"
    var isPlaying: Bool = false
    var imageString: String = "play"
    var isFavorite: Bool = true
    var isSmallScreen: Bool = UIScreen.main.bounds.height < 800
    

    internal override func viewWillAppear(_ animated: Bool) {
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    private func setupUI() {
        setupGenralView()
        setupScrollView()
        
    }

    private func setupGenralView() {
        gradient.frame = view.bounds
        view.layer.addSublayer(gradient)
    }
    
    lazy var gradient: CAGradientLayer = {
        let gradient = CAGradientLayer()
        gradient.type = .axial
        gradient.colors = [
            Colors.purpleGradientMax.color.cgColor,
            Colors.orangeGradientMin.color.cgColor
        ]
        gradient.locations = [0, 1, 1]
        return gradient
    }()
    
    // MARK: - Var initialisation
    // Scroll View
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()

    private func setupScrollView() {
        view.addSubview(scrollView)
        scrollView.addSubview(scrollViewContainer)
        scrollViewContainer.addArrangedSubview(setupPlayerView())
        scrollViewContainer.addArrangedSubview(descriptionView)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollViewContainer.translatesAutoresizingMaskIntoConstraints = false
        [
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: -40),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            scrollViewContainer.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            scrollViewContainer.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            scrollViewContainer.topAnchor.constraint(equalTo: scrollView.topAnchor),
            scrollViewContainer.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -10),
            scrollViewContainer.widthAnchor.constraint(equalTo: scrollView.widthAnchor), // importtant for scroll
            
            descriptionView.rightAnchor.constraint(equalTo: scrollView.rightAnchor, constant: -20),
            descriptionView.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 20)
        ].forEach{$0.isActive = true}
    }
    
    let scrollViewContainer: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - PlayerView
    func setupPlayerView() -> UIView{
        let view = UIView()

        view.heightAnchor.constraint(
            equalToConstant: UIScreen.main.bounds.height - UIScreen.main.bounds.height - 100
                ).isActive = true

        view.addSubview(PlayerViewController_old.stackViewGeneral)

        PlayerViewController_old.stackViewGeneral.translatesAutoresizingMaskIntoConstraints = false
        [
            PlayerViewController_old.stackViewGeneral.topAnchor.constraint(equalTo: view.topAnchor),
            PlayerViewController_old.stackViewGeneral.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            PlayerViewController_old.stackViewGeneral.leftAnchor.constraint(equalTo: view.leftAnchor),
            PlayerViewController_old.stackViewGeneral.rightAnchor.constraint(equalTo: view.rightAnchor)
        ].forEach{ $0.isActive = true }
        
        let verticalSpacerBetweenImageAndTitle = UIView()
        let verticalSpacerBetweenTitleAndSubtitle = UIView()
        let verticalSpacerBetweenSubtitleAndSlider = UIView()
        let verticalSpacerBetweenSliderAndTime = UIView()
        let verticalSpacerBetweenTimeAndPlayer = UIView()

        // image view
        PlayerViewController_old.stackViewGeneral.addArrangedSubview(PlayerViewController_old.verticalStackImage)
        PlayerViewController_old.verticalStackImage.topAnchor.constraint(equalTo: PlayerViewController_old.stackViewGeneral.topAnchor, constant: 40.0).isActive = true

        PlayerViewController_old.stackViewGeneral.addArrangedSubview(verticalSpacerBetweenImageAndTitle)
        // title
        PlayerViewController_old.stackViewGeneral.addArrangedSubview(PlayerViewController_old.horizontalStackTitle)
        // vertical spacer
        PlayerViewController_old.stackViewGeneral.addArrangedSubview(verticalSpacerBetweenTitleAndSubtitle)
        // subtitle
        PlayerViewController_old.stackViewGeneral.addArrangedSubview(PlayerViewController_old.horizontalStackSubtitle)
        // vertical spacer
        PlayerViewController_old.stackViewGeneral.addArrangedSubview(verticalSpacerBetweenSubtitleAndSlider)
        // slider
        PlayerViewController_old.stackViewGeneral.addArrangedSubview(PlayerViewController_old.verticalStackSlider)
        // vertical spacer
        PlayerViewController_old.stackViewGeneral.addArrangedSubview(verticalSpacerBetweenSliderAndTime)
        // time
        PlayerViewController_old.stackViewGeneral.addArrangedSubview(PlayerViewController_old.horizontalStackTime)
        // vertical spacer
        PlayerViewController_old.stackViewGeneral.addArrangedSubview(verticalSpacerBetweenTimeAndPlayer)
        // button Player
        PlayerViewController_old.stackViewGeneral.addArrangedSubview(PlayerViewController_old.horizontalStackButtonPlayer)

        [
            // image view
            PlayerViewController_old.verticalStackImage.leftAnchor.constraint(equalTo: PlayerViewController_old.stackViewGeneral.leftAnchor, constant: 0),
            PlayerViewController_old.verticalStackImage.widthAnchor.constraint(equalTo: PlayerViewController_old.stackViewGeneral.widthAnchor, constant: -20),
            PlayerViewController_old.verticalStackImage.heightAnchor.constraint(equalTo: PlayerViewController_old.stackViewGeneral.widthAnchor, constant: -40),
            verticalSpacerBetweenImageAndTitle.heightAnchor.constraint(equalToConstant: isSmallScreen ? Constants.verticalSmallSpacer : Constants.verticalLargeSpacer),
            
            // title
            PlayerViewController_old.horizontalStackTitle.leftAnchor.constraint(equalTo: PlayerViewController_old.stackViewGeneral.leftAnchor, constant: 0),
            PlayerViewController_old.horizontalStackTitle.rightAnchor.constraint(equalTo: PlayerViewController_old.stackViewGeneral.rightAnchor, constant: -20),
            verticalSpacerBetweenTitleAndSubtitle.heightAnchor.constraint(equalToConstant: 0),
            
            // subtitle
            PlayerViewController_old.horizontalStackSubtitle.leftAnchor.constraint(equalTo: PlayerViewController_old.stackViewGeneral.leftAnchor, constant: 0),
            PlayerViewController_old.horizontalStackSubtitle.rightAnchor.constraint(equalTo: PlayerViewController_old.stackViewGeneral.rightAnchor, constant: -20),
            PlayerViewController_old.horizontalStackSubtitle.heightAnchor.constraint(equalToConstant: 25),
            verticalSpacerBetweenSubtitleAndSlider.heightAnchor.constraint(equalToConstant: isSmallScreen ? Constants.verticalSmallSpacer : Constants.verticalMediumSpacer),
            
            // slider
            PlayerViewController_old.verticalStackSlider.leftAnchor.constraint(equalTo: PlayerViewController_old.stackViewGeneral.leftAnchor, constant: 0),
            PlayerViewController_old.verticalStackSlider.rightAnchor.constraint(equalTo: PlayerViewController_old.stackViewGeneral.rightAnchor, constant: -20),
            PlayerViewController_old.verticalStackSlider.heightAnchor.constraint(equalToConstant: 20),
            verticalSpacerBetweenSliderAndTime.heightAnchor.constraint(equalToConstant: 0),
            
            // time
            PlayerViewController_old.horizontalStackTime.leftAnchor.constraint(equalTo: PlayerViewController_old.stackViewGeneral.leftAnchor, constant: 0),
            PlayerViewController_old.horizontalStackTime.rightAnchor.constraint(equalTo: PlayerViewController_old.stackViewGeneral.rightAnchor, constant: -20),
            PlayerViewController_old.horizontalStackTime.heightAnchor.constraint(equalToConstant: 15),
            verticalSpacerBetweenTimeAndPlayer.heightAnchor.constraint(equalToConstant: 10),
            
            // player
            PlayerViewController_old.horizontalStackButtonPlayer.leftAnchor.constraint(equalTo: PlayerViewController_old.stackViewGeneral.leftAnchor, constant: 0),
            PlayerViewController_old.horizontalStackButtonPlayer.rightAnchor.constraint(equalTo: PlayerViewController_old.stackViewGeneral.rightAnchor, constant: -20),
            PlayerViewController_old.horizontalStackButtonPlayer.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: isSmallScreen ? -Constants.verticalSmallSpacer : -Constants.verticalMediumSpacer)

        ].forEach{$0.isActive = true}
        
        return view
    }

    // MARK: - Description View
    let descriptionView: UIView = {
        let view = UIView()
        view.heightAnchor.constraint(equalToConstant: 300).isActive = true
        view.backgroundColor = .blue
        
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
            stackTitleAndFullScreen.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackTitleAndFullScreen.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20)
        ].forEach{ $0.isActive = true }
        
        descritpion.translatesAutoresizingMaskIntoConstraints = false
        [
            descritpion.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 15),
            descritpion.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
            descritpion.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            descritpion.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20)
        ].forEach{ $0.isActive = true }

        return view
    }()
    


}

extension UIStackView {
    
    func horizontalStack() -> UIStackView {
        let stack = UIStackView()
        stack.distribution = .fill
        stack.axis = .horizontal
        return stack
    }

    func verticalStack() -> UIStackView {
        let stack = UIStackView()
        stack.distribution = .fill
        stack.axis = .vertical
        return stack
    }
}

// MARK: - Static Var
private extension PlayerViewController_old {

    // MARK: - stackView General
    static var stackViewGeneral: UIStackView = {
        let stack = UIStackView()
        stack.distribution = .fill
        stack.axis = .vertical
        return stack
    }()

    // MARK: - verticalStack Image
    static var verticalStackImage: UIStackView = {
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
    
    // MARK: - heart Button
    static let heartButton: UIButton = {
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
    
    // MARK: - horizontalStack Title
    static var horizontalStackTitle: UIStackView = {
        
        var stack = UIStackView()
        stack = stack.horizontalStack()

        stack.heightAnchor.constraint(equalToConstant: 30).isActive = true

        let title = UILabel()
        title.text = "À Bientôt de te revoir"
        title.font = UIFont(name: .fonts.proximaNova_Semibold.fontName(), size: 20)
        title.numberOfLines = 1
        title.textColor = Colors.yellow.color

        stack.addArrangedSubview(title)
        stack.addArrangedSubview(heartButton)

        heartButton.addTarget(self, action: #selector(actionPressFavoriteButton(_:)), for: .touchUpInside)

        return stack
    }()
    
    // MARK: - horizontalStack Subitle
    static var horizontalStackSubtitle: UIStackView = {
        var stack = UIStackView()
        stack = stack.horizontalStack()

        let subtitle = UILabel()
        subtitle.text = "Episode 112"
        subtitle.font = UIFont(name: .fonts.proximaNova_Regular.fontName(), size: 17.0)
        subtitle.textColor = .white
        subtitle.numberOfLines = 1
        let viewSpacer = UIView()
        viewSpacer.frame.size.width = 30

        stack.addArrangedSubview(subtitle)
        stack.addArrangedSubview(viewSpacer)
        return stack
    }()

    // MARK: - Slider
    static var slider: UISlider = {
        let slider = UISlider()
        slider.addTarget(self, action: #selector(actionSliderValueChanged(_:)), for: .valueChanged)

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
    
    // MARK: - VerticalStack Title
    static var verticalStackSlider: UIStackView = {
        var stack = UIStackView()
        stack = stack.verticalStack()
        stack.addArrangedSubview(slider)
        return stack
    }()

    // MARK: - Spend Time
    static var spendTime: UILabel = {
        let spendTime = UILabel()
        spendTime.text = "00:00"
        spendTime.font = spendTime.font.withSize(12)
        spendTime.textColor = .white
        return spendTime
    }()
    
    // MARK: - Total Time
    static var totalTime: UILabel = {
        let totalTime = UILabel()
        totalTime.text = "03:00:10"
        totalTime.textAlignment = .right
        totalTime.font = totalTime.font.withSize(12)
        totalTime.textColor = .white
        return totalTime
    }()

    // MARK: - HorizontalStack Time
    static var horizontalStackTime: UIStackView = {
        var stack = UIStackView()
        stack = stack.horizontalStack()

        stack.addArrangedSubview(spendTime)
        stack.addArrangedSubview(totalTime)
        return stack
    }()

    
    // MARK: horizontal Stack Button Player
    static var horizontalStackButtonPlayer: UIStackView = {
        var stack = UIStackView()
        stack = stack.horizontalStack()
        stack.alignment = .center
        
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
    
}


// MARK: - Set Up Button
private extension PlayerViewController_old {
    
    // MARK: - Seek Less Button
    static let seekLessButton: UIButton = {
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
    static let seekMoreButton: UIButton = {
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
    static let playPauseButton: UIButton = {
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
}


// MARK: - Action
private extension PlayerViewController_old {
    
    @objc func actionSliderValueChanged(_ sender: Any) {
        PlayerViewController_old.spendTime.text = PlayerViewController_old.spendTime.text?.secondsToHoursMinutesSecondsToString(Int(PlayerViewController_old.slider.value))
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
}