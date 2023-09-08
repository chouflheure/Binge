import Foundation
import CoreMedia
import UIKit

extension PlayerViewController {
    
    @objc func actionSliderValueChanged(_ sender: Any) {
        player.pause()
        spendTime.text = spendTime.text?.secondsToHoursMinutesSecondsToString(Int(slider.value))
    }
    
    @objc func sliderDidEndSliding(_ sender: Any) {
        print("@@@ action Slider, spendTime = \(spendTime.text)")
        print("@@@ sliderValue = \(slider.value)")
    }
    
    @objc func actionPressButtonLightColor(_ sender: UIButton) {
        UIView.animate(withDuration: 0.1, delay: 0.1) {
            sender.layer.borderColor = Colors.darkBlue.color.withAlphaComponent(1).cgColor
        }
    }
    
    @objc func actionPressFavoriteButton(_ sender: UIButton) {
        Task {
            await favoriteButtonClick(sender: sender)
        }
    }
    
    private func toggleFavoriteButton(sender: UIButton) {
        var imageString = String()
        if isFavorite {
            imageString = Assets.Picto.Favorite.favoriteSelectedWhite.name
        } else {
            imageString = Assets.Picto.Favorite.favoriteUnselectedWhite.name
        }
        
        
        sender.changeSizeButton(button: sender, imageString: imageString)
    }
    
    @objc func actionPressMoinsSeekButton(_ sender: UIButton) {
        sender.layer.borderColor = Colors.darkBlue.color.withAlphaComponent(0.3).cgColor
        /*
        player.pause()
        let timescale = player.leftOffPlaybackTime.timescale
        if player.leftOffPlaybackTime.value > player.leftOffPlaybackTime.timescale {
            player.leftOffPlaybackTime.value -= (10 * Int64(timescale))
        } else {
            player.leftOffPlaybackTime.value = 0
        }
        player.playResume()
         */
    }
    
    @objc func actionPressPlayPauseButton(_ sender: UIButton) {
        sender.layer.borderColor = Colors.darkBlue.color.withAlphaComponent(0.3).cgColor

        var imageString = String()
        if isPlaying {
            imageString = Assets.Picto.pause.name
            //player.playResume()
        } else {
            imageString = Assets.Picto.Play.play.name
            player.pause()
        }
        isPlaying = !isPlaying

        sender.changeSizeButton(button: sender,
                                imageString: imageString
        )

    }
    
    @objc func actionPressPlusSeekButton(_ sender: UIButton) {
        sender.layer.borderColor = Colors.darkBlue.color.withAlphaComponent(0.3).cgColor
        player.pause()
       /*
        let timescale = player.leftOffPlaybackTime.timescale
        player.leftOffPlaybackTime.value += (10 * Int64(timescale))
        player.playResume()
        */
    }
    
    @objc func actionFullScreenButton(_ sender: UIButton) {
        let playerVC = self.storyboard?.instantiateViewController(withIdentifier: "DescriptionPlayerViewController") as? DescriptionPlayerViewController
        playerVC?.modalPresentationStyle = .custom
        playerVC?.transitioningDelegate = self
        playerVC?.descriptionText = """
        Cet été, A bientôt de te revoir accompagne les auditeur·ices avec le meilleur des quatre saisons. Le premier best-of est A bientôt de te revoir accompagne les auditeur·ices avec le meilleur des quatre saisons. Le premier best-of est est A bientôt de te revoir accompagne les auditeur·ices avec le meilleur des quatre saisons. Le premier best-of est est A bientôt de te revoir accompagne les auditeur·ices. Cet été, A bientôt de te revoir accompagne les auditeur·ices avec le meilleur des quatre saisons. Le premier best-of est A bientôt de te revoir accompagne les auditeur·ices avec le meilleur des quatre saisons. Le premier best-of est est A bientôt de te revoir accompagne les auditeur·ices avec le meilleur des quatre saisons. Le premier best-of est est A bientôt de te revoir accompagne les auditeur·ices. Cet été, A bientôt de te revoir accompagne les auditeur·ices avec le meilleur des quatre saisons. Le premier best-of est A bientôt de te revoir accompagne les auditeur·ices avec le meilleur des quatre saisons. Le premier best-of est est A bientôt de te revoir accompagne les auditeur·ices avec le meilleur des quatre saisons. Le premier best-of est est A bientôt de te revoir accompagne les auditeur·ices.<3 <3 <3 <3 <3 <3 <3 <3 <3 <3 <3 <3 <3 <3 <3 <3 <3 <3 <3 <3 <3 <3 <3 <3 <3 <3 <3 <3 <3 <3 <3 <3 <3 <3 <3 <3 <3 <3 <3 <3
        """
        playerVC?.titleText = "A bietot de te revoir"
        playerVC?.authorName = "Remi Sourcier"
        playerVC?.imageAuthorName = Assets.aBientotDeTeRevoir.name

        guard let playerVC = playerVC else {return}
        self.present(playerVC, animated: true, completion: nil)
    }

    @objc func tapStackReturn(_ sender: UITapGestureRecognizer) {
        dismiss(animated: true)
    }
    
    @objc func shareAll(_ sender: UITapGestureRecognizer) {
        let text = "Écoute ce podcast sur Binge Audio"
        let linkPodcast = URL(string:"https://www.binge.audio/podcast/le-coeur-sur-la-table/romance-et-soumission-premiere-partie")
        if let linkPodcast = linkPodcast {
            let shareAll = [text, linkPodcast] as [Any]
            let activityViewController = UIActivityViewController(activityItems: shareAll, applicationActivities: nil)
            activityViewController.popoverPresentationController?.sourceView = self.view
            self.present(activityViewController, animated: true, completion: nil)
        }
        // MARK: - Add message error to open
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
        /*
        slider.addTarget(self, action: #selector(actionSliderValueChanged(_:)), for: .valueChanged)
        slider.addTarget(self, action: #selector(sliderDidEndSliding(_:)), for: .touchUpInside)
         */
        slider.addTarget(self, action: #selector(audioPlaybackSlider), for: .touchUpInside)
        
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

    func favoriteButtonClick(sender: UIButton) async {
        let favorite = isFavorite
        if !favorite {
            await coreDataManager.addEpisodeInFavorite(title: titlePodcast.text ?? "",
                                                      subtitle: subtitlePodcast.text ?? "",
                                                      description: "",//descriptionPodcast.text ?? "",
                                                      totalTime: "",
                                                      imageUrl: imageString,
                                                      playerUrl: "",
                                                      podcastName: podcastTitle
            )
        } else {
            await coreDataManager.removeEpisodeFromFavorite(titlePodcast: titlePodcast.text ?? "")
        }

        coreDataManager.fetchFavoriteEpisode()
        isFavorite = !favorite
        toggleFavoriteButton(sender: sender )
    }
}
