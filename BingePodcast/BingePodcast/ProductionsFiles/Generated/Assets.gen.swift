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
