// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

// swiftformat:disable all

import UIKit

// MARK: - Asset Catalogs

internal enum Assets {
  internal static let accentColor = ColorAsset(name: "AccentColor")
  internal static let launchScreen = ImageAsset(name: "launchScreen")
}

// MARK: - Implementation Details
internal final class ColorAsset {
  internal fileprivate(set) var name: String

  internal typealias Color = UIColor
  internal private(set) lazy var color: Color = {
    guard let color = Color(asset: self) else {
      fatalError("Unable to load color asset named \(name).")
    }
    return color
  }()

  fileprivate init(name: String) {
    self.name = name
  }
}

internal extension ColorAsset.Color {
  convenience init?(asset: ColorAsset) {
    let bundle = BundleToken.bundle
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
  }
}



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
