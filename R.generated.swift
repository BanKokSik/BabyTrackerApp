//
// This is a generated file, do not edit!
// Generated by R.swift, see https://github.com/mac-cain13/R.swift
//

import Foundation
import RswiftResources
import UIKit

private class BundleFinder {}
let R = _R(bundle: Bundle(for: BundleFinder.self))

struct _R {
  let bundle: Foundation.Bundle
  var color: color { .init(bundle: bundle) }
  var image: image { .init(bundle: bundle) }
  var info: info { .init(bundle: bundle) }
  var font: font { .init(bundle: bundle) }
  var file: file { .init(bundle: bundle) }
  var storyboard: storyboard { .init(bundle: bundle) }

  func color(bundle: Foundation.Bundle) -> color {
    .init(bundle: bundle)
  }
  func image(bundle: Foundation.Bundle) -> image {
    .init(bundle: bundle)
  }
  func info(bundle: Foundation.Bundle) -> info {
    .init(bundle: bundle)
  }
  func font(bundle: Foundation.Bundle) -> font {
    .init(bundle: bundle)
  }
  func file(bundle: Foundation.Bundle) -> file {
    .init(bundle: bundle)
  }
  func storyboard(bundle: Foundation.Bundle) -> storyboard {
    .init(bundle: bundle)
  }
  func validate() throws {
    try self.font.validate()
    try self.storyboard.validate()
  }

  struct project {
    let developmentRegion = "en"
    struct knownAssetTags: Sequence {
      let new = "New"
      func makeIterator() -> IndexingIterator<[String]> {
        [new].makeIterator()
      }
    }
  }

  /// This `_R.color` struct is generated, and contains static references to 31 colors.
  struct color {
    let bundle: Foundation.Bundle

    /// Color `AccentColor`.
    var accentColor: RswiftResources.ColorResource { .init(name: "AccentColor", path: [], bundle: bundle) }

    /// Color `Alabaster`.
    var alabaster: RswiftResources.ColorResource { .init(name: "Alabaster", path: [], bundle: bundle) }

    /// Color `Bittersweet`.
    var bittersweet: RswiftResources.ColorResource { .init(name: "Bittersweet", path: [], bundle: bundle) }

    /// Color `BittersweetLight`.
    var bittersweetLight: RswiftResources.ColorResource { .init(name: "BittersweetLight", path: [], bundle: bundle) }

    /// Color `Black`.
    var black: RswiftResources.ColorResource { .init(name: "Black", path: [], bundle: bundle) }

    /// Color `BlueChalk`.
    var blueChalk: RswiftResources.ColorResource { .init(name: "BlueChalk", path: [], bundle: bundle) }

    /// Color `BridalHealth`.
    var bridalHealth: RswiftResources.ColorResource { .init(name: "BridalHealth", path: [], bundle: bundle) }

    /// Color `ChetwodeBlue`.
    var chetwodeBlue: RswiftResources.ColorResource { .init(name: "ChetwodeBlue", path: [], bundle: bundle) }

    /// Color `Concrete`.
    var concrete: RswiftResources.ColorResource { .init(name: "Concrete", path: [], bundle: bundle) }

    /// Color `Conifer`.
    var conifer: RswiftResources.ColorResource { .init(name: "Conifer", path: [], bundle: bundle) }

    /// Color `DodgerBlue`.
    var dodgerBlue: RswiftResources.ColorResource { .init(name: "DodgerBlue", path: [], bundle: bundle) }

    /// Color `DodgerBlueLight`.
    var dodgerBlueLight: RswiftResources.ColorResource { .init(name: "DodgerBlueLight", path: [], bundle: bundle) }

    /// Color `EggSour`.
    var eggSour: RswiftResources.ColorResource { .init(name: "EggSour", path: [], bundle: bundle) }

    /// Color `Heliotrope`.
    var heliotrope: RswiftResources.ColorResource { .init(name: "Heliotrope", path: [], bundle: bundle) }

    /// Color `HeliotropeLight`.
    var heliotropeLight: RswiftResources.ColorResource { .init(name: "HeliotropeLight", path: [], bundle: bundle) }

    /// Color `HeliotropeLighther`.
    var heliotropeLighther: RswiftResources.ColorResource { .init(name: "HeliotropeLighther", path: [], bundle: bundle) }

    /// Color `MacaroniAndCheese`.
    var macaroniAndCheese: RswiftResources.ColorResource { .init(name: "MacaroniAndCheese", path: [], bundle: bundle) }

    /// Color `Mauve`.
    var mauve: RswiftResources.ColorResource { .init(name: "Mauve", path: [], bundle: bundle) }

    /// Color `Mercury`.
    var mercury: RswiftResources.ColorResource { .init(name: "Mercury", path: [], bundle: bundle) }

    /// Color `MySin`.
    var mySin: RswiftResources.ColorResource { .init(name: "MySin", path: [], bundle: bundle) }

    /// Color `MySinLight`.
    var mySinLight: RswiftResources.ColorResource { .init(name: "MySinLight", path: [], bundle: bundle) }

    /// Color `Nobel`.
    var nobel: RswiftResources.ColorResource { .init(name: "Nobel", path: [], bundle: bundle) }

    /// Color `RazzleDazzleRose`.
    var razzleDazzleRose: RswiftResources.ColorResource { .init(name: "RazzleDazzleRose", path: [], bundle: bundle) }

    /// Color `RazzleDazzleRoseLight`.
    var razzleDazzleRoseLight: RswiftResources.ColorResource { .init(name: "RazzleDazzleRoseLight", path: [], bundle: bundle) }

    /// Color `SandyBeach`.
    var sandyBeach: RswiftResources.ColorResource { .init(name: "SandyBeach", path: [], bundle: bundle) }

    /// Color `Silver`.
    var silver: RswiftResources.ColorResource { .init(name: "Silver", path: [], bundle: bundle) }

    /// Color `TorquoiseBlue`.
    var torquoiseBlue: RswiftResources.ColorResource { .init(name: "TorquoiseBlue", path: [], bundle: bundle) }

    /// Color `VividTangarine`.
    var vividTangarine: RswiftResources.ColorResource { .init(name: "VividTangarine", path: [], bundle: bundle) }

    /// Color `White`.
    var white: RswiftResources.ColorResource { .init(name: "White", path: [], bundle: bundle) }

    /// Color `WildSand`.
    var wildSand: RswiftResources.ColorResource { .init(name: "WildSand", path: [], bundle: bundle) }

    /// Color `YellowOrange`.
    var yellowOrange: RswiftResources.ColorResource { .init(name: "YellowOrange", path: [], bundle: bundle) }
  }

  /// This `_R.image` struct is generated, and contains static references to 2 images.
  struct image {
    let bundle: Foundation.Bundle

    /// Image `Icon`.
    var icon: RswiftResources.ImageResource { .init(name: "Icon", path: [], bundle: bundle, locale: nil, onDemandResourceTags: nil) }

    /// Image `calendar`.
    var calendar: RswiftResources.ImageResource { .init(name: "calendar", path: [], bundle: bundle, locale: nil, onDemandResourceTags: nil) }
  }

  /// This `_R.info` struct is generated, and contains static references to 1 properties.
  struct info {
    let bundle: Foundation.Bundle
    var uiApplicationSceneManifest: uiApplicationSceneManifest { .init(bundle: bundle) }

    func uiApplicationSceneManifest(bundle: Foundation.Bundle) -> uiApplicationSceneManifest {
      .init(bundle: bundle)
    }

    struct uiApplicationSceneManifest {
      let bundle: Foundation.Bundle

      let uiApplicationSupportsMultipleScenes: Bool = false

      var _key: String { bundle.infoDictionaryString(path: ["UIApplicationSceneManifest"], key: "_key") ?? "UIApplicationSceneManifest" }
      var uiSceneConfigurations: uiSceneConfigurations { .init(bundle: bundle) }

      func uiSceneConfigurations(bundle: Foundation.Bundle) -> uiSceneConfigurations {
        .init(bundle: bundle)
      }

      struct uiSceneConfigurations {
        let bundle: Foundation.Bundle
        var _key: String { bundle.infoDictionaryString(path: ["UIApplicationSceneManifest", "UISceneConfigurations"], key: "_key") ?? "UISceneConfigurations" }
        var uiWindowSceneSessionRoleApplication: uiWindowSceneSessionRoleApplication { .init(bundle: bundle) }

        func uiWindowSceneSessionRoleApplication(bundle: Foundation.Bundle) -> uiWindowSceneSessionRoleApplication {
          .init(bundle: bundle)
        }

        struct uiWindowSceneSessionRoleApplication {
          let bundle: Foundation.Bundle
          var defaultConfiguration: defaultConfiguration { .init(bundle: bundle) }

          func defaultConfiguration(bundle: Foundation.Bundle) -> defaultConfiguration {
            .init(bundle: bundle)
          }

          struct defaultConfiguration {
            let bundle: Foundation.Bundle
            var uiSceneConfigurationName: String { bundle.infoDictionaryString(path: ["UIApplicationSceneManifest", "UISceneConfigurations", "UIWindowSceneSessionRoleApplication"], key: "UISceneConfigurationName") ?? "Default Configuration" }
            var uiSceneDelegateClassName: String { bundle.infoDictionaryString(path: ["UIApplicationSceneManifest", "UISceneConfigurations", "UIWindowSceneSessionRoleApplication"], key: "UISceneDelegateClassName") ?? "$(PRODUCT_MODULE_NAME).SceneDelegate" }
          }
        }
      }
    }
  }

  /// This `_R.font` struct is generated, and contains static references to 7 fonts.
  struct font: Sequence {
    let bundle: Foundation.Bundle

    /// Font `Gilroy-Bold`.
    var gilroyBold: RswiftResources.FontResource { .init(name: "Gilroy-Bold", bundle: bundle, filename: "Gilroy-Bold.ttf") }

    /// Font `Gilroy-ExtraBold`.
    var gilroyExtraBold: RswiftResources.FontResource { .init(name: "Gilroy-ExtraBold", bundle: bundle, filename: "Gilroy-ExtraBold.ttf") }

    /// Font `Gilroy-Light`.
    var gilroyLight: RswiftResources.FontResource { .init(name: "Gilroy-Light", bundle: bundle, filename: "Gilroy-Light.ttf") }

    /// Font `Gilroy-Medium`.
    var gilroyMedium: RswiftResources.FontResource { .init(name: "Gilroy-Medium", bundle: bundle, filename: "Gilroy-Medium.ttf") }

    /// Font `Gilroy-Regular`.
    var gilroyRegular: RswiftResources.FontResource { .init(name: "Gilroy-Regular", bundle: bundle, filename: "Gilroy-Regular.ttf") }

    /// Font `Gilroy-SemiBold`.
    var gilroySemiBold: RswiftResources.FontResource { .init(name: "Gilroy-SemiBold", bundle: bundle, filename: "Gilroy-SemiBold.ttf") }

    /// Font `teaspoon`.
    var teaspoon: RswiftResources.FontResource { .init(name: "teaspoon", bundle: bundle, filename: "Teaspoon.ttf") }

    func makeIterator() -> IndexingIterator<[RswiftResources.FontResource]> {
      [gilroyBold, gilroyExtraBold, gilroyLight, gilroyMedium, gilroyRegular, gilroySemiBold, teaspoon].makeIterator()
    }
    func validate() throws {
      for font in self {
        if !font.canBeLoaded() { throw RswiftResources.ValidationError("[R.swift] Font '\(font.name)' could not be loaded, is '\(font.filename)' added to the UIAppFonts array in this targets Info.plist?") }
      }
    }
  }

  /// This `_R.file` struct is generated, and contains static references to 7 resource files.
  struct file {
    let bundle: Foundation.Bundle

    /// Resource file `Gilroy-Bold.ttf`.
    var gilroyBoldTtf: RswiftResources.FileResource { .init(name: "Gilroy-Bold", pathExtension: "ttf", bundle: bundle, locale: LocaleReference.none) }

    /// Resource file `Gilroy-ExtraBold.ttf`.
    var gilroyExtraBoldTtf: RswiftResources.FileResource { .init(name: "Gilroy-ExtraBold", pathExtension: "ttf", bundle: bundle, locale: LocaleReference.none) }

    /// Resource file `Gilroy-Light.ttf`.
    var gilroyLightTtf: RswiftResources.FileResource { .init(name: "Gilroy-Light", pathExtension: "ttf", bundle: bundle, locale: LocaleReference.none) }

    /// Resource file `Gilroy-Medium.ttf`.
    var gilroyMediumTtf: RswiftResources.FileResource { .init(name: "Gilroy-Medium", pathExtension: "ttf", bundle: bundle, locale: LocaleReference.none) }

    /// Resource file `Gilroy-Regular.ttf`.
    var gilroyRegularTtf: RswiftResources.FileResource { .init(name: "Gilroy-Regular", pathExtension: "ttf", bundle: bundle, locale: LocaleReference.none) }

    /// Resource file `Gilroy-SemiBold.ttf`.
    var gilroySemiBoldTtf: RswiftResources.FileResource { .init(name: "Gilroy-SemiBold", pathExtension: "ttf", bundle: bundle, locale: LocaleReference.none) }

    /// Resource file `Teaspoon.ttf`.
    var teaspoonTtf: RswiftResources.FileResource { .init(name: "Teaspoon", pathExtension: "ttf", bundle: bundle, locale: LocaleReference.none) }
  }

  /// This `_R.storyboard` struct is generated, and contains static references to 1 storyboards.
  struct storyboard {
    let bundle: Foundation.Bundle
    var launchScreen: launchScreen { .init(bundle: bundle) }

    func launchScreen(bundle: Foundation.Bundle) -> launchScreen {
      .init(bundle: bundle)
    }
    func validate() throws {
      try self.launchScreen.validate()
    }


    /// Storyboard `LaunchScreen`.
    struct launchScreen: RswiftResources.StoryboardReference, RswiftResources.InitialControllerContainer {
      typealias InitialController = UIKit.UIViewController

      let bundle: Foundation.Bundle

      let name = "LaunchScreen"
      func validate() throws {

      }
    }
  }
}