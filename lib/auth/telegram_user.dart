import 'dart:convert';

/// Profile read from the claims of a Telegram `id_token`.
///
/// The token is only decoded here, not verified: the signature must be checked
/// on a backend before the user is trusted for anything server-side.
class TelegramUser {
  const TelegramUser({
    required this.id,
    required this.name,
    this.username,
    this.photoUrl,
    this.phoneNumber,
  });

  final String id;
  final String name;
  final String? username;
  final String? photoUrl;
  final String? phoneNumber;

  factory TelegramUser.fromIdToken(String idToken) {
    final parts = idToken.split('.');
    if (parts.length != 3) {
      throw const FormatException('id_token is not a JWT');
    }
    final claims =
        jsonDecode(utf8.decode(base64Url.decode(base64Url.normalize(parts[1]))))
            as Map<String, dynamic>;
    return TelegramUser(
      id: (claims['id'] ?? claims['sub']).toString(),
      name: claims['name'] as String? ?? 'Telegram user',
      username: claims['preferred_username'] as String?,
      photoUrl: claims['picture'] as String?,
      phoneNumber: claims['phone_number'] as String?,
    );
  }
}
