// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

// swiftformat:disable all

import UIKit

// MARK: - Asset Catalogs

internal enum Colors {
  internal static let darkBlue = ColorAsset(name: "DarkBlue")
  internal static let lightBlueTabBar = ColorAsset(name: "LightBlueTabBar")
  internal static let ligthBlue = ColorAsset(name: "LigthBlue")
  internal static let white = ColorAsset(name: "White")
  internal static let yellow = ColorAsset(name: "Yellow")
  internal static let orangeGradientMin = ColorAsset(name: "orangeGradientMin")
  internal static let purpleGradientMax = ColorAsset(name: "purpleGradientMax")
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



private final class BundleToken {
    static let bundle: Bundle = {
        return Bundle(for: BundleToken.self)
    }()
}
