import AVFoundation
import Flutter
import UIKit
import UserNotifications

@main
@objc class AppDelegate: FlutterAppDelegate, FlutterImplicitEngineDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    // Uygulama açıkken yerel bildirimlerin gösterilmesi ve dokunuşların Flutter'a ulaşması için.
    UNUserNotificationCenter.current().delegate = self
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  // UIScene + implicit engine yapısında bu çağrı eklentilere ulaşmıyor; uygulama açıkken
  // gösterilen yerel bildirimler (Dart tarafı zaten açık sohbeti filtreliyor) burada sunulur.
  override func userNotificationCenter(
    _ center: UNUserNotificationCenter,
    willPresent notification: UNNotification,
    withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void
  ) {
    completionHandler([.banner, .list, .sound])
  }

  func didInitializeImplicitFlutterEngine(_ engineBridge: FlutterImplicitEngineBridge) {
    GeneratedPluginRegistrant.register(with: engineBridge.pluginRegistry)
    if let registrar = engineBridge.pluginRegistry.registrar(forPlugin: "VeyloAvPermissions") {
      VeyloAvPermissions.register(with: registrar)
    }
  }
}

/// Mikrofon / kamera izni doğrudan iOS API'siyle. permission_handler'ın Swift Package
/// sürümü Xcode'dan derlenince izinleri derleme dışı bırakıp sormadan "reddedildi" diyor;
/// bu kanal derleme yönteminden bağımsız olarak sistem iznini sorar.
final class VeyloAvPermissions: NSObject, FlutterPlugin {
  static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(
      name: "veylo/av_permissions", binaryMessenger: registrar.messenger())
    registrar.addMethodCallDelegate(VeyloAvPermissions(), channel: channel)
  }

  func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    let kind = (call.arguments as? String) ?? "microphone"
    let media: AVMediaType = kind == "camera" ? .video : .audio
    switch call.method {
    case "status":
      switch AVCaptureDevice.authorizationStatus(for: media) {
      case .authorized: result("granted")
      case .notDetermined: result("undetermined")
      default: result("denied")
      }
    case "request":
      AVCaptureDevice.requestAccess(for: media) { granted in
        DispatchQueue.main.async { result(granted) }
      }
    case "openSettings":
      if let url = URL(string: UIApplication.openSettingsURLString) {
        UIApplication.shared.open(url)
      }
      result(nil)
    default:
      result(FlutterMethodNotImplemented)
    }
  }
}
