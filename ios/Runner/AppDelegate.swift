import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        let controller: FlutterViewController = window?.rootViewController as! FlutterViewController
        let deviceInfoChannel = FlutterMethodChannel(name: "com.misyonbank.misyonbank/device_info",binaryMessenger: controller.binaryMessenger)
        deviceInfoChannel.setMethodCallHandler { (call: FlutterMethodCall, result: @escaping FlutterResult) in
            if call.method == "getDeviceInfo" {
                let deviceInfo = "\(UIDevice.current.systemName) \(UIDevice.current.model)"
                result(deviceInfo)
            } else {
                result(FlutterMethodNotImplemented)
            }
        }

        GeneratedPluginRegistrant.register(with: self)
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
}