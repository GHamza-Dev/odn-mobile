import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureTokenStorage {
  static const _key = 'token';
  static final _secure = FlutterSecureStorage();

  static Future<void> save(String token) =>
      _secure.write(key: _key, value: token);

  static Future<String?> read() => _secure.read(key: _key);

  static Future<void> clear() => _secure.delete(key: _key);
}
