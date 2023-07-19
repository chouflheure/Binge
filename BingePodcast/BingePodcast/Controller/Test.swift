
//
//  TestViewController.swift
//  BingePodcast
//
//  Created by charlesCalvignac on 17/06/2023.
//

import UIKit


class Test: UIViewController {
    
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
    
    
    // MARK: - verticalStack Image
    var imageViewPlayer: UIImageView = {
        var imageView = UIImageView()
        
        let image = UIImage(named: Assets.aBientotDeTeRevoir.name)
        imageView = UIImageView(image: image)
        imageView.layer.cornerRadius = 30
        imageView.layer.masksToBounds = true
        imageView.layer.shadowOffset = CGSize(width: 5, height: 5)
        imageView.layer.shadowOpacity = 0.3
        imageView.layer.shadowColor = UIColor.black.cgColor
        imageView.translatesAutoresizingMaskIntoConstraints = false

        return imageView
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

    let stackReturnView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fill
        return stack
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
            scrollViewContainer.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 50), // importtant for scroll
            
            
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
        
        stackViewPlayer.addArrangedSubview(imageViewPlayer)
        stackViewPlayer.addArrangedSubview(stackViewTitleAndFavorite)
        
        [
            // Margin between Stack return and image
            marginOnTop.heightAnchor.constraint(equalToConstant: 25),
            
            // Image Podcast
            imageViewPlayer.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 50),
            
            // Space Image - Title
            spaceBetweenImageAndTitle.heightAnchor.constraint(equalToConstant: 25),
            
            // Title Podcast
            stackViewTitleAndFavorite.heightAnchor.constraint(equalToConstant: 25),
            spacingBetweenTitleAndFavoriteBtn.widthAnchor.constraint(equalToConstant: 10),
            heartButton.widthAnchor.constraint(equalToConstant: 25),
            
            // Space Title - Subtitle
            spaceBetweenTitleAndSubtitle.heightAnchor.constraint(equalToConstant: 10),

            // Subtitle Podcast
            
            // Space Subtitle - Slider
            
            // Slider
            
            // Space Slider - Time timer Podcast
            
            // Time timer Podcast
            
            // Space Title timer Podcast - Button Player
            
            // Button Player
            
        ].forEach{$0.isActive = true}
        
        
        scrollViewContainer.addArrangedSubview(stackViewPlayer)
    }
    
    
    
    
    
    func setupAction() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapStackReturn(_:)))
        stackReturnView.isUserInteractionEnabled = true
        stackReturnView.addGestureRecognizer(tap)
        }
    
    @objc func tapStackReturn(_ sender: UITapGestureRecognizer) {
        dismiss(animated: true)
    }
}

   
