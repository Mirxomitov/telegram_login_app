import 'package:flutter/foundation.dart';

/// Telegram Login settings. Run `tool/set_client_id.sh <id>` to change the
/// client ID here and in the native projects in one go.
class TelegramConfig {
  /// Numeric bot ID from @BotFather (Bot Settings > Login Widget).
  static const clientId = '8991968189';

  /// Custom URL scheme registered in Info.plist.
  static const fallbackScheme = 'tgloginapp';

  /// iOS returns through the custom scheme, because the universal link needs
  /// the Associated Domains entitlement, which the current signing profile
  /// does not carry. Android returns through its verified App Link.
  static String get redirectUri => defaultTargetPlatform == TargetPlatform.iOS
      ? '$fallbackScheme://tglogin'
      : 'https://app$clientId-login.tg.dev';

  static const scopes = ['profile'];

  static bool get isSet => clientId != '0000000000';
}
