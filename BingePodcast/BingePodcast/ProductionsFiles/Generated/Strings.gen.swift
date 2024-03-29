// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {
  /// Tous les épisodes
  internal static let allEpisodes = L10n.tr("Strings", "allEpisodes", fallback: "Tous les épisodes")
  /// Description
  internal static let description = L10n.tr("Strings", "description", fallback: "Description")
  /// Aucun Podcast enregistré dans vos favoris. Cette rubrique vous permet de retrouver vos podcasts préférés. Pour les mettres en favoris, il suffit de les enregistrer en cliquant sur le coeur dans le player.
  internal static let emptyFavoritePodcast = L10n.tr("Strings", "emptyFavoritePodcast", fallback: "Aucun Podcast enregistré dans vos favoris. Cette rubrique vous permet de retrouver vos podcasts préférés. Pour les mettres en favoris, il suffit de les enregistrer en cliquant sur le coeur dans le player.")
  /// Favoris
  internal static let favorite = L10n.tr("Strings", "favorite", fallback: "Favoris")
  /// Podcasts
  internal static let podcast = L10n.tr("Strings", "podcast", fallback: "Podcasts")
  /// A écouter
  internal static let seeLater = L10n.tr("Strings", "seeLater", fallback: "A écouter")
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg..., fallback value: String) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: value, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
