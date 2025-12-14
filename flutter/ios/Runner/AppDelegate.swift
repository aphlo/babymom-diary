import FirebaseCore
import Flutter
import UIKit
#if canImport(app_links)
import app_links
#endif

@main
@objc class AppDelegate: FlutterAppDelegate {
  private let deepLinkScheme = "milu"

  private func configureFirebaseIfNeeded() {
    if FirebaseApp.app() != nil { return }

    // Try multiple candidate plists to avoid crashing when the default file is missing.
    let bundle = Bundle.main
    let plistNames = ["GoogleService-Info", "GoogleService-Info-stg", "GoogleService-Info-prod"]
    for name in plistNames {
      if let path = bundle.path(forResource: name, ofType: "plist"),
         let options = FirebaseOptions(contentsOfFile: path) {
        FirebaseApp.configure(options: options)
        break
      }
    }

    if FirebaseApp.app() == nil {
      print("Error: Could not configure Firebase. No valid GoogleService-Info plist file found.")
    }
  }

  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    // Handle widget quick actions that arrive before Dart initializes Firebase.
    configureFirebaseIfNeeded()

    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  override func application(
    _ app: UIApplication,
    open url: URL,
    options: [UIApplication.OpenURLOptionsKey : Any] = [:]
  ) -> Bool {
    configureFirebaseIfNeeded()
    // Short-circuit milu:// links to avoid plugins (e.g., FirebaseAuth) asserting before init.
    if url.scheme == deepLinkScheme {
      #if canImport(app_links)
      AppLinks.shared.handleLink(url: url)
      return true
      #else
      return super.application(app, open: url, options: options)
      #endif
    }
    return super.application(app, open: url, options: options)
  }
}
