import Flutter
import UIKit
import GoogleSignIn // GoogleSignIn китепканасын импорттоо

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  // Google Каттоодон кайтып келген URL дарегин иштетүү үчүн бул методду кошуңуз
  override func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
    var handled: Bool

    handled = GIDSignIn.sharedInstance.handle(url)
    if handled {
      return true
    }

    // Башка URL схемаларын иштетүү керек болсо, бул жерге кошуңуз
    // If not handled by Google Sign-In, pass it to other handlers if any

    return false
  }
}
