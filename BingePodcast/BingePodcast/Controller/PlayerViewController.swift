//
//  PlayerViewController.swift
//  BingePodcast
//
//  Created by charlesCalvignac on 15/06/2023.
//

import UIKit

class PlayerViewController: UIViewController {

    
    @IBOutlet var globalView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titlePodcast: UILabel!
    @IBOutlet weak var subtitlePodcast: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var sliderTime: UISlider!
    @IBOutlet weak var timeSpent: UILabel!
    @IBOutlet weak var totalTime: UILabel!
    @IBOutlet weak var buttonMoinsSeek: UIButton!
    @IBOutlet weak var buttonPlayPause: UIButton!
    @IBOutlet weak var buttonPlusSeek: UIButton!
    @IBOutlet weak var descriptionPodcast: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // TODO:
        // . Delegate Pattern
        // . Call model
        // . Update UI
        // . Segue pour description

        // setUpUI()
    }
    
    
    
    @IBAction func actionSliderValueChanged(_ sender: Any) {
        print("@@@ slider call change")
        timeSpent.text = String(sliderTime.value)
    }
    
    @IBAction func actionPressFavoriteButton(_ sender: Any) {
        print("@@@ click favorite")
    }
    
    @IBAction func actionPressMoinsSeekButton(_ sender: Any) {
        print("@@@ click moins seed")
    }
    
    @IBAction func actionPressPlayPauseButton(_ sender: Any) {
        print("@@@ click play pause")
    }
    
    @IBAction func actionPressPlusSeekButton(_ sender: Any) {
        print("@@@ click plus seed")
    }


}

// Setup
private extension PlayerViewController {
    
    func setupDelegate() {
        // recipeService.searchDelegate = self
    }
}

// UI
private extension PlayerViewController {
    
    func setUpUI() {
        backgroundColorGradient()
        setUpsliderUI()
        setUpData()
        setUpButton()
        isFavoritePodcast()
        editFont()
        setUIImageView()
        setUpButton()
    }
    
    func backgroundColorGradient() {
        // implement le gradient view color
        // globalView.backgroundColor = .black
    }
    
    func setUpsliderUI() {
        sliderTime.value = 0
        // sliderTime.minimumValue = totalTime.text
        // sliderTime.maximumValue = 100
        timeSpent.text = String(sliderTime.value)
        
        sliderTime.thumbTintColor = Colors.darkBlue.color
        sliderTime.maximumTrackTintColor = Colors.ligthBlue.color
        sliderTime.minimumTrackTintColor = Colors.darkBlue.color
        
        sliderTime.trackRect(forBounds: CGRect(x: 0, y: 0, width: 1, height: 1))
    }
    
    func labelTimeEvolution() {}
    
    func setUpData() {
        // timeSpent.text = "00:10"
        totalTime.text = "09:30"
        totalTime.tintColor = .black
        
        titlePodcast.text = "À Bientot de te revoir"
        titlePodcast.tintColor = .black
        
        subtitlePodcast.text = "Episode 112"
        subtitlePodcast.tintColor = .black
    }
    
    func isFavoritePodcast() {
        let imageHeart = UIImage(systemName: "heart")
        let imageViewFavorite = UIImageView(image: imageHeart)
        imageViewFavorite.frame.size = CGSize(width: 38, height: 35)

        favoriteButton.tintColor = Colors.darkBlue.color
        favoriteButton.addSubview(imageViewFavorite)
    }
    
    func editFont() {}
    
    func setUIImageView() {
        imageView.layer.cornerRadius = 30
        imageView.layer.shadowRadius = 3
        imageView.layer.shadowOffset = CGSize(width: 5, height: 5)
        imageView.layer.shadowOpacity = 0.3
        imageView.layer.shadowColor = UIColor.black.cgColor
        imageView.layer.masksToBounds = false

    }
    
    func setUpButton() {
        setUpButton(width: 33.0, height: 40.0, button: buttonPlayPause, image: "play.fill")
        setUpButton(width: 25.0, height: 31.0, button: buttonMoinsSeek, image: "arrow.counterclockwise")
        setUpButton(width: 25.0, height: 31.0, button: buttonPlusSeek, image: "arrow.clockwise")
    }
    
    func setUpButton(width: CGFloat, height: CGFloat, button: UIButton, image: String) {
        
        button.layer.cornerRadius = button.frame.height / 2
        button.layer.borderWidth = 2.5
        button.layer.borderColor = Colors.darkBlue.color.cgColor

        let image = UIImage(systemName: image)
        let imageView = UIImageView(image: image)
        imageView.frame.size = CGSize(width: width, height: height)
        imageView.tintColor = Colors.yellow.color

        button.addSubview(imageView)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        [
            imageView.centerXAnchor.constraint(equalTo: button.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: button.centerYAnchor),
            imageView.widthAnchor.constraint(equalToConstant: width),
            imageView.heightAnchor.constraint(equalToConstant: height)
        ].forEach{ $0.isActive = true }
    }
    
}

class CustomSlider: UISlider {
    override func trackRect(forBounds bounds: CGRect) -> CGRect {
        let point = CGPoint(x: bounds.minX, y: bounds.midY)
        return CGRect(origin: point, size: CGSize(width: bounds.width, height: 20))
    }
}
