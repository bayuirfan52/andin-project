import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    if let registrar = registrar(forPlugin: "AndinAppConfig") {
      let channel = FlutterMethodChannel(
        name: "andin_project/app_config",
        binaryMessenger: registrar.messenger()
      )
      channel.setMethodCallHandler { call, result in
        guard call.method == "getConfig" else {
          result(FlutterMethodNotImplemented)
          return
        }

        let info = Bundle.main.infoDictionary ?? [:]
        result([
          "appName": info["CFBundleDisplayName"] as? String ?? "Staging AVIC",
          "flavor": info["APP_FLAVOR"] as? String ?? "staging"
        ])
      }
    }
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
