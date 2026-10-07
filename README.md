# Telegram Login

Flutter app (iOS + Android) that signs users in with Telegram's native login
sheet, via the [telegram_login](https://pub.dev/packages/telegram_login) plugin.

## Setup

1. In [@BotFather](https://t.me/botfather) open your bot > **Bot Settings > Login Widget** and register the app:
   - iOS: bundle ID `uz.globalmove.telegramLoginApp`, Apple Team ID `CR87Z3G2A7`,
     redirect URI `tgloginapp://tglogin` (custom scheme)
   - Android: package `com.example.telegram_login_app` and the signing SHA-256
     (debug keystore on this machine: `A2:BC:8F:B7:CF:AA:29:42:B9:A4:AB:39:D5:BA:97:1B:9A:BA:67:3E:70:DF:D0:0E:B2:3A:EB:86:2E:AC:AE:1D`)
2. Put the bot's numeric client ID into the project:
   ```sh
   tool/set_client_id.sh 1234567890
   ```
   This updates `lib/auth/telegram_config.dart`, `android/gradle.properties`
   and `ios/Flutter/Telegram.xcconfig`.
3. iOS signs with team `CR87Z3G2A7` and the wildcard development profile, so it
   returns from Telegram through the custom scheme. To use the universal link
   instead, sign in to that team in Xcode, set
   `CODE_SIGN_ENTITLEMENTS = Runner/Runner.entitlements` on the Runner target and
   drop the iOS branch of `TelegramConfig.redirectUri`.
4. `flutter run` on a device with Telegram installed.

## Before production

The app only decodes the `id_token` to show the profile. Send the token to
your backend and [verify its signature](https://core.telegram.org/bots/telegram-login#validating-id-tokens)
there before trusting it.
