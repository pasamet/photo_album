import 'package:shared_preferences/shared_preferences.dart';

const _usernameKey = 'username';
const _passwordKey = 'password';
const _loggedInKey = 'loggedIn';

enum UserState {
  initial,
  onboarded,
  loggedIn,
}

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

    if (username != _username || password != _password) {
      return LoginResult.invalidCredentials;
    }

    await _storage.setBool(_loggedInKey, true);
    return LoginResult.successful;
  }

  UserState get state => switch (_isLoggedIn) {
        true => UserState.loggedIn,
        _ when _password != null && _username != null => UserState.onboarded,
        _ => UserState.initial,
      };

  String? get _password => _storage.getString(_passwordKey);
  String? get _username => _storage.getString(_usernameKey);
  bool get _isLoggedIn => _storage.getBool(_loggedInKey) ?? false;
}

enum LoginResult {
  successful,
  invalidCredentials,
}
