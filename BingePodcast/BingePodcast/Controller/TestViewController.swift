//
//  TestViewController.swift
//  BingePodcast
//
//  Created by charlesCalvignac on 17/06/2023.
//

import UIKit

extension Float {
    func convertHoursToFloat(totalTime: String) -> Int{
        let delimiter = ":"
        let token = totalTime.components(separatedBy: delimiter)
        
        var newVal = Int()

        if totalTime.count > 5 {
            newVal = (Int(token[0]) ?? 0 ) * 3600
            newVal += (Int(token[1]) ?? 0 ) * 60
            newVal += (Int(token[2]) ?? 0 )
        }
        else if totalTime.count > 3 {
            newVal += (Int(token[0]) ?? 0 ) * 60
            newVal += (Int(token[1]) ?? 0 )
        }
        else {
            newVal += (Int(token[0]) ?? 0 )
        }
        
        
        return newVal
    }
}

extension String {
    
    
    func secondsToHoursMinutesSecondsToString(_ seconds: Int) -> String {
        let time = [seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60]
        var val = String()
        
        if time[0] != 0 && time[0] < 10 {
            val.append("0\(time[0]):")
        }
        if time[0] != 0 && time[0] >= 10 {
            val.append("\(time[0]):")
        }
        
        if time[1] != 0 && time[1] < 10 {
            val.append("0\(time[1]):")
        }
        if time[1] != 0 && time[1] >= 10 {
            val.append("\(time[1]):")
        }
        if time[1] == 0 {
            val.append("00:")
        }

        if time[2] >= 10 {
            val.append("\(time[2])")
        } else {
            val.append("0\(time[2])")
        }
        
        return val
    }
}

class TestViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = view
        // convertHoursToFloat(totalTime: "02:11:31")
        setupUI()
    }
    
    let totalTimeTest = "01:01"
    
    let isPlaying: Bool = false
    
    
    
    
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
        scrollViewContainer.addArrangedSubview(playerView)
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
    let playerView: UIView = {
        let view = UIView()

        view.heightAnchor.constraint(
            equalToConstant: UIScreen.main.bounds.height - UIScreen.main.bounds.height/4.5
                ).isActive = true

        view.addSubview(stackViewGeneral)

        stackViewGeneral.translatesAutoresizingMaskIntoConstraints = false
        [
            stackViewGeneral.topAnchor.constraint(equalTo: view.topAnchor),
            stackViewGeneral.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            stackViewGeneral.leftAnchor.constraint(equalTo: view.leftAnchor),
            stackViewGeneral.rightAnchor.constraint(equalTo: view.rightAnchor)
        ].forEach{ $0.isActive = true }
        
        let verticalSpacerBetweenImageAndTitle = UIView()
        
        // image view
        stackViewGeneral.addArrangedSubview(verticalStackImage)
        verticalStackImage.topAnchor.constraint(equalTo: stackViewGeneral.topAnchor, constant: 40.0).isActive = true

        stackViewGeneral.addArrangedSubview(verticalSpacerBetweenImageAndTitle)
        
        // title
        stackViewGeneral.addArrangedSubview(horizontalStackTitle)
        
        
        // subtitle
        stackViewGeneral.addArrangedSubview(horizontalStackSubtitle)
        
        // slider
        stackViewGeneral.addArrangedSubview(verticalStackSlider)
        
        // Time - time
        stackViewGeneral.addArrangedSubview(horizontalStackTime)
        
        // button Player
        stackViewGeneral.addArrangedSubview(horizontalStackButtonPlayer)

        [
            verticalStackImage.leftAnchor.constraint(equalTo: stackViewGeneral.leftAnchor, constant: 0),
            verticalStackImage.widthAnchor.constraint(equalTo: stackViewGeneral.widthAnchor, constant: -20),
            
            verticalStackImage.heightAnchor.constraint(equalTo: stackViewGeneral.widthAnchor, constant: -40),
            
            verticalSpacerBetweenImageAndTitle.heightAnchor.constraint(equalToConstant: 10),
            
            
            horizontalStackTitle.leftAnchor.constraint(equalTo: stackViewGeneral.leftAnchor, constant: 10),
            horizontalStackTitle.rightAnchor.constraint(equalTo: stackViewGeneral.rightAnchor, constant: -20),
            horizontalStackSubtitle.leftAnchor.constraint(equalTo: stackViewGeneral.leftAnchor, constant: 10),
            horizontalStackSubtitle.rightAnchor.constraint(equalTo: stackViewGeneral.rightAnchor, constant: -20),
            verticalStackSlider.leftAnchor.constraint(equalTo: stackViewGeneral.leftAnchor, constant: 10),
            verticalStackSlider.rightAnchor.constraint(equalTo: stackViewGeneral.rightAnchor, constant: -20),
            horizontalStackTime.leftAnchor.constraint(equalTo: stackViewGeneral.leftAnchor, constant: 10),
            horizontalStackTime.rightAnchor.constraint(equalTo: stackViewGeneral.rightAnchor, constant: -20),
            horizontalStackButtonPlayer.leftAnchor.constraint(equalTo: stackViewGeneral.leftAnchor, constant: 10),
            horizontalStackButtonPlayer.rightAnchor.constraint(equalTo: stackViewGeneral.rightAnchor, constant: -20)
        ].forEach{$0.isActive = true}

        return view
    }()

    // MARK: - Description View
    let descriptionView: UIView = {
        let view = UIView()
        view.heightAnchor.constraint(equalToConstant: 300).isActive = true
        view.backgroundColor = .blue
        
        let title = UILabel()
        title.text = "Description"
        title.font = UIFont(name: "ProximaNova-Bold", size: 18)
        title.textColor = Colors.yellow.color

        let descritpion = UILabel()
        descritpion.text = """
            Cet été, A bientôt de te revoir accompagne les auditeur·ices avec le meilleur des quatre saisons. Le premier best-of est A bientôt de te revoir accompagne les auditeur·ices avec le meilleur des quatre saisons. Le premier best-of est A bientôt de te revoir accompagne les auditeur·ices avec le meilleur des quatre saisons. Le premier best-of est est A bientôt de te revoir accompagne les auditeur·ices.
            """
        descritpion.setLineSpacing(lineSpacing: 10.0)
        descritpion.numberOfLines = 0
        descritpion.font = UIFont(name: "ProximaNova-semiBold", size: 18)
        descritpion.textColor = Colors.ligthBlue.color
        
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
    
    // MARK: - horizontalStack Title
    static var horizontalStackTitle: UIStackView = {
        
        var stack = UIStackView()
        stack = stack.horizontalStack()

        stack.heightAnchor.constraint(equalToConstant: 30).isActive = true

        let title = UILabel()
        title.text = "À Bientôt de te revoir"
        title.font = UIFont(name: "ProximaNova-Bold", size: 20)
        title.numberOfLines = 1
        title.textColor = Colors.yellow.color
        
        let heartButton = UIButton()
        heartButton.frame.size = CGSize(width: 30, height: 30)
        
        let imageHeart = UIImage(systemName: "heart")
        let imageViewFavorite = UIImageView(image: imageHeart)
        imageViewFavorite.frame.size = CGSize(width: 30, height: 25)
        
        heartButton.addSubview(imageViewFavorite)
        
        imageViewFavorite.rightAnchor.constraint(equalTo: heartButton.rightAnchor).isActive = true

        stack.addArrangedSubview(title)
        stack.addArrangedSubview(heartButton)
        
        heartButton.addTarget(self,
                              action: #selector(actionPressFavoriteButton(_:)),
                              for: .touchUpInside
        )

        return stack
    }()
    
    // MARK: - horizontalStack Subitle
    static var horizontalStackSubtitle: UIStackView = {
        var stack = UIStackView()
        stack = stack.horizontalStack()

        let subtitle = UILabel()
        subtitle.text = "Episode 112"
        subtitle.font = UIFont(name: "ProximaNova-Semibold", size: 17.0)
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
        slider.addTarget(self,
                         action: #selector(actionSliderValueChanged(_:)),
                         for: .valueChanged
        )

        slider.value = 0
        slider.minimumValue = 0
        slider.maximumValue = Float(slider.maximumValue.convertHoursToFloat(totalTime: "03:00:10"))

        slider.thumbTintColor = Colors.darkBlue.color
        slider.maximumTrackTintColor = Colors.ligthBlue.color
        slider.minimumTrackTintColor = Colors.darkBlue.color
        
        var thumbImage = UIImage(systemName: "circlebadge.fill")!.maskWithColor(color: Colors.darkBlue.color)
        var size = CGSizeMake( thumbImage?.size.width ?? 3.0 , thumbImage?.size.height ?? 3.0 )
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
        return spendTime
    }()
    
    // MARK: - Total Time
    static var totalTime: UILabel = {
        let totalTime = UILabel()
        totalTime.text = "11:23"
        totalTime.textAlignment = .right
        totalTime.font = totalTime.font.withSize(12)
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
        
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        // Action Button
        
        seekLessButton.addTarget(self, action: #selector(actionPressButtonLightColor(_:)), for: .touchUpInside)
        seekLessButton.addTarget(self, action: #selector(actionPressMoinsSeekButton(_:)), for: .touchDown)
        playPauseButton.addTarget(self, action: #selector(actionPressButtonLightColor(_:)), for: .touchUpInside)
        playPauseButton.addTarget(self, action: #selector(actionPressPlayPauseButton(_:)), for: .touchDown)
        seekMoreButton.addTarget(self, action: #selector(actionPressButtonLightColor(_:)), for: .touchUpInside)
        seekMoreButton.addTarget(self, action: #selector(actionPressPlusSeekButton(_:)), for: .touchDown)
        
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
        button.generatedButton(width: Constants.widthSquareSeekLessButton,
                               height: Constants.widthSquareSeekLessButton,
                               button: button,
                               image: "arrow.counterclockwise",
                               imageWidth: Constants.widthSquareSeekLessButton / 2,
                               imageHeight: Constants.widthSquareSeekLessButton / 2
        )
        return button
    }()
    
    // MARK: - Seek More Button
    static let seekMoreButton: UIButton = {
        let button = UIButton()
        button.generatedButton(width: Constants.widthSquareSeekMoreButton,
                               height: Constants.widthSquareSeekMoreButton,
                               button: button,
                               image: "arrow.clockwise",
                               imageWidth: Constants.widthSquareSeekMoreButton / 2,
                               imageHeight: Constants.widthSquareSeekMoreButton / 2
        )
        return button
    }()
    
    // MARK: - Play Pause Button
    static let playPauseButton: UIButton = {
        let button = UIButton()
        button.generatedButton(width: Constants.widthSquarePlayPauseButton,
                               height: Constants.widthSquarePlayPauseButton,
                               button: button,
                               image: "pause.fill",
                               imageWidth: 33.0,
                               imageHeight: 40.0
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
    }
    
    @objc func actionPressMoinsSeekButton(_ sender: UIButton) {
        sender.layer.borderColor = Colors.darkBlue.color.withAlphaComponent(0.3).cgColor
        print("@@@ click moins seek")
    }
    
    @objc func actionPressPlayPauseButton(_ sender: UIButton) {
        sender.layer.borderColor = Colors.darkBlue.color.withAlphaComponent(0.3).cgColor
        print("@@@ click play pause")
    }
    
    @objc func actionPressPlusSeekButton(_ sender: UIButton) {
        sender.layer.borderColor = Colors.darkBlue.color.withAlphaComponent(0.3).cgColor
        print("@@@ click plus seek")
    }
}
















extension UIViewController {
 
    
    // ####################    USE THAT
    func generateVerticalStackView() -> UIStackView {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.distribution = .fill
        stack.alignment = .center
        stack.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return stack
    }
    
    func generateStackView() -> UIStackView {
        let stack = UIStackView()
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.alignment = .center
        return stack
    }

    func generateVerticalSpacer(height: CGFloat = 30.0, color: UIColor = Colors.darkBlue.color) -> UIView {
        let view = UIView()
        view.heightAnchor.constraint(equalToConstant: height).isActive = true
        return view
    }

   
    func generateTitleHeader(
        text: String,
        size: CGFloat = 26.0,
        weight: UIFont.Weight = .semibold
    ) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = UIFont.systemFont(ofSize: size, weight: weight)
        label.textColor = .white
        label.numberOfLines = 0
        label.textAlignment = .center
        label.contentMode = .center
        return label
    }

    func generateSingleLineView(color: UIColor) -> UIView {
        let v = UIView(frame: .zero)
        v.backgroundColor = color
        v.translatesAutoresizingMaskIntoConstraints = false
        v.heightAnchor.constraint(equalToConstant: 1.0).isActive = true
        return v
    }
    // ####################
}


