import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/user_repository.dart';

@immutable
class LoginState {
  final bool logInEnabled;
  final bool showInvalidCredentials;
  const LoginState({
    this.logInEnabled = true,
    this.showInvalidCredentials = false,
  });
}

abstract class LoginActions {
  void navigateToHome();
}

class LoginCubit extends Cubit<LoginState> {
  final UserRepository _userRepository;
  final LoginActions _actions;

  LoginCubit({
    required UserRepository userRepository,
    required LoginActions loginActions,
  })  : _userRepository = userRepository,
        _actions = loginActions,
        super(const LoginState());

  Future<void> onLogIn({
    required String username,
    required String password,
  }) async {
    if (state.logInEnabled) {
      emit(const LoginState(logInEnabled: false));
      try {
        var result = await _userRepository.logIn(
          username: username,
          password: password,
        );
        switch (result) {
          case LoginResult.successful:
            _actions.navigateToHome();
          case LoginResult.invalidCredentials:
            emit(const LoginState(showInvalidCredentials: true));
        }
      } on Exception {
        emit(const LoginState());
        rethrow;
      }
    }
  }
}
