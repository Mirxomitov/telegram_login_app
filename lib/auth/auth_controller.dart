import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:telegram_login/telegram_login.dart';

import 'telegram_config.dart';
import 'telegram_user.dart';

class AuthController extends ChangeNotifier {
  static const _tokenKey = 'telegram_id_token';

  final _telegram = TelegramLogin();
  final _storage = const FlutterSecureStorage();

  TelegramUser? user;
  String? idToken;
  String? error;
  bool isLoading = false;
  bool isReady = false;

  /// Restores a previous session, if any.
  Future<void> init() async {
    try {
      final saved = await _storage.read(key: _tokenKey);
      if (saved != null) _setToken(saved);
    } catch (_) {
      await _storage.delete(key: _tokenKey);
    }
    isReady = true;
    notifyListeners();
  }

  Future<void> login() async {
    if (isLoading) return;
    if (!TelegramConfig.isSet) {
      error = 'Set your bot client ID first: tool/set_client_id.sh <id>';
      notifyListeners();
      return;
    }
    isLoading = true;
    error = null;
    notifyListeners();
    try {
      await _telegram.configure(
        TelegramLoginConfiguration(
          clientId: TelegramConfig.clientId,
          redirectUri: TelegramConfig.redirectUri,
          scopes: TelegramConfig.scopes,
          fallbackScheme: TelegramConfig.fallbackScheme,
        ),
      );
      final result = await _telegram.login();
      _setToken(result.idToken);
      await _storage.write(key: _tokenKey, value: result.idToken);
    } on TelegramLoginError catch (e) {
      if (e.code != TelegramLoginErrorCode.cancelled) {
        error = e.message ?? 'Login failed (${e.code.name})';
      }
    } catch (e) {
      error = 'Login failed: $e';
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  /// Abandons a login that is waiting on the Telegram app.
  Future<void> cancelLogin() => _telegram.cancelLogin();

  Future<void> logout() async {
    await _storage.delete(key: _tokenKey);
    user = null;
    idToken = null;
    notifyListeners();
  }

  void _setToken(String token) {
    user = TelegramUser.fromIdToken(token);
    idToken = token;
  }
}
