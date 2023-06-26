// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

// swiftformat:disable all

import UIKit

// MARK: - Asset Catalogs

internal enum Assets {
  internal static let aBientotDeTeRevoir = ImageAsset(name: "A_Bientot_de_te_revoir")
  internal enum IconNavBar {
    internal static let favorite = ImageAsset(name: "favorite")
    internal static let home = ImageAsset(name: "home")
    internal static let podcast = ImageAsset(name: "podcast")
  }
  internal static let launchScreen = ImageAsset(name: "launchScreen")
  internal enum Picto {
    internal static let arrowRight = ImageAsset(name: "arrow right")
    internal enum Favorite {
      internal static let favoriteSelectedBlue = ImageAsset(name: "favorite_selected_blue")
      internal static let favoriteSelectedWhite = ImageAsset(name: "favorite_selected_white")
      internal static let favoriteUnselectedBlue = ImageAsset(name: "favorite_unselected_blue")
      internal static let favoriteUnselectedWhite = ImageAsset(name: "favorite_unselected_white")
    }
    internal static let fermeture = ImageAsset(name: "fermeture")
    internal static let fullScreen = ImageAsset(name: "fullScreen")
    internal static let pause = ImageAsset(name: "pause")
    internal enum Play {
      internal static let play = ImageAsset(name: "play")
      internal static let playCircle = ImageAsset(name: "playCircle")
    }
    internal static let seekLess = ImageAsset(name: "seekLess")
    internal static let seekMore = ImageAsset(name: "seekMore")
    internal static let thumb = ImageAsset(name: "thumb")
    internal static let timer = ImageAsset(name: "timer")
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
