//
//  TestViewController.swift
//  BingePodcast
//
//  Created by charlesCalvignac on 17/06/2023.
//

import UIKit

enum SizeScreen {
    case small
    case medium
    case large
}

class TestViewController: UIViewController {
    
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
    

    private func setupUI() {
        setupGenralView()
        setupScrollView()

        // TODO: Drag and drop dans un bouton

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
            equalToConstant: UIScreen.main.bounds.height - UIScreen.main.bounds.height/4.5
                ).isActive = true

        view.addSubview(TestViewController.stackViewGeneral)

        TestViewController.stackViewGeneral.translatesAutoresizingMaskIntoConstraints = false
        [
            TestViewController.stackViewGeneral.topAnchor.constraint(equalTo: view.topAnchor),
            TestViewController.stackViewGeneral.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            TestViewController.stackViewGeneral.leftAnchor.constraint(equalTo: view.leftAnchor),
            TestViewController.stackViewGeneral.rightAnchor.constraint(equalTo: view.rightAnchor)
        ].forEach{ $0.isActive = true }
        
        let verticalSpacerBetweenImageAndTitle = UIView()
        let verticalSpacerBetweenTitleAndSubtitle = UIView()
        let verticalSpacerBetweenSubtitleAndSlider = UIView()
        let verticalSpacerBetweenSliderAndTime = UIView()
        let verticalSpacerBetweenTimeAndPlayer = UIView()

        // image view
        TestViewController.stackViewGeneral.addArrangedSubview(TestViewController.verticalStackImage)
        TestViewController.verticalStackImage.topAnchor.constraint(equalTo: TestViewController.stackViewGeneral.topAnchor, constant: 40.0).isActive = true

        TestViewController.stackViewGeneral.addArrangedSubview(verticalSpacerBetweenImageAndTitle)
        
        // title
        TestViewController.stackViewGeneral.addArrangedSubview(TestViewController.horizontalStackTitle)
        // vertical spacer
        TestViewController.stackViewGeneral.addArrangedSubview(verticalSpacerBetweenTitleAndSubtitle)
        // subtitle
        TestViewController.stackViewGeneral.addArrangedSubview(TestViewController.horizontalStackSubtitle)
        // vertical spacer
        TestViewController.stackViewGeneral.addArrangedSubview(verticalSpacerBetweenSubtitleAndSlider)
        // slider
        TestViewController.stackViewGeneral.addArrangedSubview(TestViewController.verticalStackSlider)
        // vertical spacer
        TestViewController.stackViewGeneral.addArrangedSubview(verticalSpacerBetweenSliderAndTime)
        // time
        TestViewController.stackViewGeneral.addArrangedSubview(TestViewController.horizontalStackTime)
        // vertical spacer
        TestViewController.stackViewGeneral.addArrangedSubview(verticalSpacerBetweenTimeAndPlayer)
        // button Player
        TestViewController.stackViewGeneral.addArrangedSubview(TestViewController.horizontalStackButtonPlayer)

        [
            // image view
            TestViewController.verticalStackImage.leftAnchor.constraint(equalTo: TestViewController.stackViewGeneral.leftAnchor, constant: 0),
            TestViewController.verticalStackImage.widthAnchor.constraint(equalTo: TestViewController.stackViewGeneral.widthAnchor, constant: -20),
            TestViewController.verticalStackImage.heightAnchor.constraint(equalTo: TestViewController.stackViewGeneral.widthAnchor, constant: -40),
            verticalSpacerBetweenImageAndTitle.heightAnchor.constraint(equalToConstant: isSmallScreen ? Constants.verticalSmallSpacer : Constants.verticalLargeSpacer),
            
            // title
            TestViewController.horizontalStackTitle.leftAnchor.constraint(equalTo: TestViewController.stackViewGeneral.leftAnchor, constant: 0),
            TestViewController.horizontalStackTitle.rightAnchor.constraint(equalTo: TestViewController.stackViewGeneral.rightAnchor, constant: -20),
            verticalSpacerBetweenTitleAndSubtitle.heightAnchor.constraint(equalToConstant: 0),
            
            // subtitle
            TestViewController.horizontalStackSubtitle.leftAnchor.constraint(equalTo: TestViewController.stackViewGeneral.leftAnchor, constant: 0),
            TestViewController.horizontalStackSubtitle.rightAnchor.constraint(equalTo: TestViewController.stackViewGeneral.rightAnchor, constant: -20),
            TestViewController.horizontalStackSubtitle.heightAnchor.constraint(equalToConstant: 30),
            verticalSpacerBetweenSubtitleAndSlider.heightAnchor.constraint(equalToConstant: isSmallScreen ? Constants.verticalSmallSpacer : Constants.verticalLargeSpacer),
            
            // slider
            TestViewController.verticalStackSlider.leftAnchor.constraint(equalTo: TestViewController.stackViewGeneral.leftAnchor, constant: 0),
            TestViewController.verticalStackSlider.rightAnchor.constraint(equalTo: TestViewController.stackViewGeneral.rightAnchor, constant: -20),
            verticalSpacerBetweenSliderAndTime.heightAnchor.constraint(equalToConstant: 10),
            
            // time
            TestViewController.horizontalStackTime.leftAnchor.constraint(equalTo: TestViewController.stackViewGeneral.leftAnchor, constant: 0),
            TestViewController.horizontalStackTime.rightAnchor.constraint(equalTo: TestViewController.stackViewGeneral.rightAnchor, constant: -20),
            TestViewController.horizontalStackTime.heightAnchor.constraint(equalToConstant: 15),
            verticalSpacerBetweenTimeAndPlayer.heightAnchor.constraint(equalToConstant: 0),
            
            // player
            TestViewController.horizontalStackButtonPlayer.leftAnchor.constraint(equalTo: TestViewController.stackViewGeneral.leftAnchor, constant: 0),
            TestViewController.horizontalStackButtonPlayer.rightAnchor.constraint(equalTo: TestViewController.stackViewGeneral.rightAnchor, constant: -20),
            TestViewController.horizontalStackButtonPlayer.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: isSmallScreen ? -Constants.verticalSmallSpacer : -Constants.verticalMediumSpacer)

        ].forEach{$0.isActive = true}
        
        return view
    }

    // MARK: - Description View
    let descriptionView: UIView = {
        let view = UIView()
        view.heightAnchor.constraint(equalToConstant: 300).isActive = true
        view.backgroundColor = .blue
        
        let title = UILabel()
        title.text = "Description"
        title.font = UIFont(name: .fonts.proximaNova_Alt_Bold.fontName(), size: 18)
        title.textColor = Colors.yellow.color

        let descritpion = UILabel()
        descritpion.text = """
            Cet été, A bientôt de te revoir accompagne les auditeur·ices avec le meilleur des quatre saisons. Le premier best-of est A bientôt de te revoir accompagne les auditeur·ices avec le meilleur des quatre saisons. Le premier best-of est A bientôt de te revoir accompagne les auditeur·ices avec le meilleur des quatre saisons. Le premier best-of est est A bientôt de te revoir accompagne les auditeur·ices.
            """
        descritpion.setLineSpacing(lineSpacing: 8.0)
        descritpion.numberOfLines = 0
        descritpion.font = UIFont(name: .fonts.proximaNova_Alt_Thin.fontName(), size: 16)
        descritpion.textColor = .white
        
        view.layer.cornerRadius = 20
        view.backgroundColor = Colors.purpleGradientMax.color.withAlphaComponent(0.8)
        view.addSubview(title)
        view.addSubview(descritpion)

        title.translatesAutoresizingMaskIntoConstraints = false
        [
            title.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            title.heightAnchor.constraint(equalToConstant: 30),
            title.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            title.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20)
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
private extension TestViewController {

    // MARK: - stackView General
    static var stackViewGeneral: UIStackView = {
        let stack = UIStackView()
        stack.distribution = .fill
        stack.axis = .vertical
        // stack.backgroundColor = .gray
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
                               image: "heart",
                               imageWidth: Constants.widthSquareSeekLessButton / 2,
                               color: .white
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
        subtitle.font = UIFont(name: .fonts.proximaNova_Bold.fontName(), size: 17.0)
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
        
        var thumbImage = UIImage(systemName: "circlebadge.fill")!.maskWithColor(color: Colors.darkBlue.color)
        var size = CGSizeMake(thumbImage?.size.width ?? 3.0 , thumbImage?.size.height ?? 3.0)
        slider.setThumbImage(thumbImage, for: .normal)
        slider.setThumbImage(thumbImage, for: .highlighted)

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
private extension TestViewController {
    
    // MARK: - Seek Less Button
    static let seekLessButton: UIButton = {
        let button = UIButton()
        button.generatedButton(isBordering: true,
                               width: Constants.widthSquareSeekLessButton,
                               height: Constants.widthSquareSeekLessButton,
                               button: button,
                               image: "arrow.counterclockwise",
                               imageWidth: Constants.widthSquareSeekLessButton / 2,
                               color: Colors.yellow.color
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
                               image: "arrow.clockwise",
                               imageWidth: Constants.widthSquareSeekMoreButton / 2,
                               color: Colors.yellow.color
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
                               image: "pause.fill",
                               imageWidth: Constants.widthSquarePlayPauseButton / 2,
                               color: Colors.yellow.color
        )
        return button
    }()
}


// MARK: - Action
private extension TestViewController {
    
    @objc func actionSliderValueChanged(_ sender: Any) {
        TestViewController.spendTime.text = TestViewController.spendTime.text?.secondsToHoursMinutesSecondsToString(Int(TestViewController.slider.value))
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
            imageString = "heart.fill"
        } else {
            imageString = "heart"
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
            imageString = "pause.fill"
        } else {
            imageString = "play.fill"
        }
        isPlaying = !isPlaying

        sender.changeSizeButton(button: sender, imageWidth: Constants.widthSquarePlayPauseButton / 2, imageString: imageString)
        print("@@@ click play pause")
    }
    
    @objc func actionPressPlusSeekButton(_ sender: UIButton) {
        sender.layer.borderColor = Colors.darkBlue.color.withAlphaComponent(0.3).cgColor
        print("@@@ click plus seek")
    }
}
