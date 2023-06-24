// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

// swiftformat:disable all

import UIKit

// MARK: - Asset Catalogs

internal enum Assets {
  internal static let aBientotDeTeRevoir = ImageAsset(name: "A_Bientot_de_te_revoir")
  internal enum IconNavBar {
    internal static let favoriteSelect = ImageAsset(name: "favorite_select")
    internal static let favoriteUnselect = ImageAsset(name: "favorite_unselect")
    internal static let homeSelect = ImageAsset(name: "home_select")
    internal static let homeUnselect = ImageAsset(name: "home_unselect")
    internal static let podcastSelect = ImageAsset(name: "podcast_select")
    internal static let podcastUnselect = ImageAsset(name: "podcast_unselect")
  }
  internal static let launchScreen = ImageAsset(name: "launchScreen")
  internal enum Picto {
    internal static let favoriteSelectBlue = ImageAsset(name: "favorite_select_blue")
    internal static let favoriteSelectedWhite = ImageAsset(name: "favorite_selected_white")
    internal static let favoriteUnselectBlue = ImageAsset(name: "favorite_unselect_blue")
    internal static let favoriteUnselectedWhite = ImageAsset(name: "favorite_unselected_white")
    internal static let fullScreen = ImageAsset(name: "fullScreen")
    internal static let pause = ImageAsset(name: "pause")
    internal static let play = ImageAsset(name: "play")
    internal static let reductFullScreen = ImageAsset(name: "reductFullScreen")
    internal static let seekLess = ImageAsset(name: "seekLess")
    internal static let seekMore = ImageAsset(name: "seekMore")
    internal static let thumb = ImageAsset(name: "thumb")
    internal static let timerClock1 = ImageAsset(name: "timerClock 1")
    internal static let timerClock = ImageAsset(name: "timerClock")
  }
}

// MARK: - Implementation Details


internal struct ImageAsset {
  internal fileprivate(set) var name: String

  internal typealias Image = UIImage

  internal var image: Image {
    let bundle = BundleToken.bundle
    let image = Image(named: name, in: bundle, compatibleWith: nil)
    guard let result = image else {
      fatalError("Unable to load image asset named \(name).")
    }
    return result
  }
}

private final class BundleToken {
    static let bundle: Bundle = {
        return Bundle(for: BundleToken.self)
    }()
}
