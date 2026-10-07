import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:telegram_login_app/auth/telegram_user.dart';

void main() {
  test('reads the profile from id_token claims', () {
    final payload = base64Url
        .encode(
          utf8.encode(
            jsonEncode({
              'sub': '42',
              'id': 987654321,
              'name': 'John Doe',
              'preferred_username': 'johndoe',
            }),
          ),
        )
        .replaceAll('=', '');
    final user = TelegramUser.fromIdToken('header.$payload.signature');

    expect(user.id, '987654321');
    expect(user.name, 'John Doe');
    expect(user.username, 'johndoe');
    expect(user.photoUrl, isNull);
  });

  test('rejects a token that is not a JWT', () {
    expect(() => TelegramUser.fromIdToken('nope'), throwsFormatException);
  });
}
