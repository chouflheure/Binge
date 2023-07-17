//
//  Constants.swift
//  BingePodcast
//
//  Created by charlesCalvignac on 19/06/2023.
//

import Foundation

class Constants {
    static let widthSquarePlayPauseButton: CGFloat = 70
    static let widthSquareSeekLessButton: CGFloat = 50
    static let widthSquareSeekMoreButton: CGFloat = 50
    static let verticalGeneralMargin: CGFloat = 60
    static let spacerBetweenButton: CGFloat = 35
    static let borderRadiusButton: CGFloat = 2.5
    static let widthPlayerButton: CGFloat = widthSquarePlayPauseButton + widthSquareSeekLessButton + widthSquareSeekMoreButton + spacerBetweenButton + spacerBetweenButton + verticalGeneralMargin
    static let verticalSmallSpacer: CGFloat = 20
    static let verticalMediumSpacer: CGFloat = 30
    static let verticalLargeSpacer: CGFloat = 50
}

class Constants_SwitchPlayer {
    static let leftTextMinConstrait: CGFloat = 25
    static let leftTextMaxConstrait: CGFloat = 105
    static let marginContainerImage: CGFloat = 7
}

class Constants_HomeViewController {
    static let imageViewHeight: CGFloat = 260
    static let horizontalMarginLeftAndRightMolecule: CGFloat = 35
    static let heightSwipePlayer: CGFloat = 102
}

class Constants_FavoritesViewController {
    static let heightCell: CGFloat = 100.0
    static let heightHeader: CGFloat = 40.0
}
