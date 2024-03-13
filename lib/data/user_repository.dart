import 'package:shared_preferences/shared_preferences.dart';

const _usernameKey = 'username';
const _passwordKey = 'password';
const _loggedInKey = 'loggedIn';

class UserRepository {
  final SharedPreferences _storage;

  UserRepository({required SharedPreferences storage}) : _storage = storage;

  Future<void> signUp({
    required String username,
    required String password,
  }) async {
    username = username.trim();
    password = password.trim();
    assert(username.isNotEmpty);
    assert(password.isNotEmpty);
    await _storage.setString(_usernameKey, username);
    await _storage.setString(_passwordKey, password);
  }

  Future<LoginResult> logIn({
    required String username,
    required String password,
  }) async {
    username = username.trim();
    password = password.trim();
    assert(username.isNotEmpty);
    assert(password.isNotEmpty);

    if (username != _storage.getString(_usernameKey) ||
        password != _storage.getString(_passwordKey)) {
      return LoginResult.invalidCredentials;
    }

    await _storage.setBool(_loggedInKey, true);
    return LoginResult.successful;
  }
}

enum LoginResult {
  successful,
  invalidCredentials,
}
