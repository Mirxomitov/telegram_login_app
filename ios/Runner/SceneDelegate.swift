import Flutter
import UIKit
import telegram_login

class SceneDelegate: FlutterSceneDelegate {

  // The telegram_login plugin only listens for app-delegate URL callbacks,
  // which iOS does not send to scene-based apps, so hand them over here.
  override func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
    super.scene(scene, openURLContexts: URLContexts)
    if let url = URLContexts.first?.url {
      TelegramLogin.handle(url)
    }
  }

  override func scene(_ scene: UIScene, continue userActivity: NSUserActivity) {
    super.scene(scene, continue: userActivity)
    if userActivity.activityType == NSUserActivityTypeBrowsingWeb,
      let url = userActivity.webpageURL
    {
      TelegramLogin.handle(url)
    }
  }
}
