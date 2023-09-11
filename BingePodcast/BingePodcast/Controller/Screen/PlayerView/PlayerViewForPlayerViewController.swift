
import Foundation
import UIKit

extension PlayerViewController {
    
    // MARK: - Player View Set up
    // This methode generate the player view ( image, titile, subtitle, slider, time and controller )
    func setupPlayerView() {
        
        let horizontalStackTime: UIStackView = {
            var stack = UIStackView()
            stack = stack.horizontalStack()

            stack.addArrangedSubview(spendTime)
            stack.addArrangedSubview(totalTime)
            return stack
        }()
        
        // horizontal Stack Button Player, stack where player button are created
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
        // horizontal stack player btn
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
            
            // Space Title timer Podcast - Button Player
            spaceBetweenTimeAndButtonPlayer.heightAnchor.constraint(equalToConstant: 10),
            
            // Button Player
            playPauseButton.widthAnchor.constraint(equalToConstant: Constants.widthSquarePlayPauseButton),
            playPauseButton.heightAnchor.constraint(equalToConstant: Constants.widthSquarePlayPauseButton)
            
        ].forEach{$0.isActive = true}

        scrollViewContainer.addArrangedSubview(stackViewPlayer)
        
    }
}
