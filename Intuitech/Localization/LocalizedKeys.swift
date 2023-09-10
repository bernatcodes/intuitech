// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
public enum LocalizedKeys {
  /// Létrehozás dátuma
  public static let repositoryDetailCreatedAtTitle = LocalizedKeys.tr("Localizable", "repository_detail_created_at_title", fallback: "Létrehozás dátuma")
  /// Leírás
  public static let repositoryDetailDescriptionTitle = LocalizedKeys.tr("Localizable", "repository_detail_description_title", fallback: "Leírás")
  /// Leágazások száma
  public static let repositoryDetailNumberOfForksTitle = LocalizedKeys.tr("Localizable", "repository_detail_number_of_forks_title", fallback: "Leágazások száma")
  /// Csillagok száma
  public static let repositoryDetailNumberOfStarsTitle = LocalizedKeys.tr("Localizable", "repository_detail_number_of_stars_title", fallback: "Csillagok száma")
  /// Tulajdonos neve
  public static let repositoryDetailOwnerNameTitle = LocalizedKeys.tr("Localizable", "repository_detail_owner_name_title", fallback: "Tulajdonos neve")
  /// Utolsó frissítés dátuma
  public static let repositoryDetailUpdatedAtTitle = LocalizedKeys.tr("Localizable", "repository_detail_updated_at_title", fallback: "Utolsó frissítés dátuma")
  /// Még nem kerestél repository-kat.
  public static let repositoryListEmptyListTitle = LocalizedKeys.tr("Localizable", "repository_list_empty_list_title", fallback: "Még nem kerestél repository-kat.")
  /// Sajnálom, hiba történt.
  /// Kérem próbálja meg később.
  public static let repositoryListErrorTitle = LocalizedKeys.tr("Localizable", "repository_list_error_title", fallback: "Sajnálom, hiba történt.\nKérem próbálja meg később.")
  /// Nem található repository a megadott keresési értékkel.
  public static let repositoryListNoRepositoriesFoundTitle = LocalizedKeys.tr("Localizable", "repository_list_no_repositories_found_title", fallback: "Nem található repository a megadott keresési értékkel.")
  /// Keresés
  public static let repositoryListSearchButtonTitle = LocalizedKeys.tr("Localizable", "repository_list_search_button_title", fallback: "Keresés")
  /// Itt tudsz keresni repository-kat
  public static let repositoryListSearchTextfieldPlaceholderText = LocalizedKeys.tr("Localizable", "repository_list_search_textfield_placeholder_text", fallback: "Itt tudsz keresni repository-kat")
  /// Repository lista
  public static let repositoryListTitle = LocalizedKeys.tr("Localizable", "repository_list_title", fallback: "Repository lista")
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension LocalizedKeys {
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
