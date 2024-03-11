import 'package:shared_preferences/shared_preferences.dart';

class UserRepository {
  final SharedPreferences _storage;

  UserRepository({required SharedPreferences storage}) : _storage = storage;

  Future<void> signup({
    required String username,
    required String password,
  }) async {
    username = username.trim();
    password = password.trim();
    assert(username.isNotEmpty);
    assert(password.isNotEmpty);
    await _storage.setString('username', username);
    await _storage.setString('password', password);
  }
}
