import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  override func application(
    _ app: UIApplication,
    open url: URL,
    options: [UIApplication.OpenURLOptionsKey : Any] = [:]
  ) -> Bool {
    if let scheme = url.scheme,
        scheme.localizedCaseInsensitiveCompare("yangjataekil") == .orderedSame,
        let view = window?.rootViewController as? FlutterViewController {
        let channel = FlutterMethodChannel(name: "yangjataekil.detail/channel", binaryMessenger: view.binaryMessenger)
        channel.invokeMethod("initialLink", arguments: url.absoluteString)
    }
    return false
  }
}
