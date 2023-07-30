
import Foundation
import UIKit

extension PlayerViewController {
    
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
    
    @objc func shareAll(_ sender: UITapGestureRecognizer) {
        let text = "Écoute ce podcast sur Binge Audio"
        let myWebsite = NSURL(string:"https://www.binge.audio/podcast/le-coeur-sur-la-table/romance-et-soumission-premiere-partie")
        let shareAll = [text, myWebsite!] as [Any]
        let activityViewController = UIActivityViewController(activityItems: shareAll, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        self.present(activityViewController, animated: true, completion: nil)
    }

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
