//
//  PlayerViewController.swift
//  BingePodcast
//
//  Created by charlesCalvignac on 15/06/2023.
//

import UIKit

class PlayerViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titlePodcast: UILabel!
    @IBOutlet weak var subtitlePodcast: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var sliderTime: UISlider!
    @IBOutlet weak var timeSpent: UILabel!
    @IBOutlet weak var totalTime: UILabel!
    @IBOutlet weak var buttonMoinsSeed: UIButton!
    @IBOutlet weak var buttonPlayPause: UIButton!
    @IBOutlet weak var buttonPlusSeed: UIButton!
    @IBOutlet weak var descriptionPodcast: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // TODO:
        // . Delegate Pattern
        // . Call model
        // . Update UI
        // . Segue pour description
        
        titlePodcast.text = "À Bientot de te revoir"
        subtitlePodcast.text = "Episode 112"
        
        timeSpent.text = "00:10"
        totalTime.text = "09:30"
        
        let image = UIImage(systemName: "star")
        let test = UIImageView(image: image)
        test.frame.size = CGSize(width: 38, height: 35)
        // favoriteButton.setImage(image, for: .normal)
        favoriteButton.addSubview(test)
        
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func actionPressFavoriteButton(_ sender: Any) {
        print("@@@ click favorite")
    }
    
    @IBAction func actionPressPlusSeedButton(_ sender: Any) {
        print("@@@ click plus seed")
    }
    
    @IBAction func actionPressPlayPauseButton(_ sender: Any) {
        print("@@@ click play pause")
    }
    @IBAction func actionPressMoinsSeedButton(_ sender: Any) {
        print("@@@ click moins seed")
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
    
    func backgroundColorGradient() {}
    
    func sliderTimeEvolution() {}
    
    func labelTimeEvolution() {}
    
    func editData() {}
    
    func isFavoritePodcast() {}
    
    func editFont() {}
    
    func editUIImageView() {}
    
    func editUIPlayerButton() {}
    
}
