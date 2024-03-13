import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/user_repository.dart';

@immutable
class OnboardingState {
  final bool saveEnabled;

  const OnboardingState({
    this.saveEnabled = true,
  });
}

abstract class OnboardingActions {
  void navigateToLogin();
}

class OnboardingCubit extends Cubit<OnboardingState> {
  final UserRepository _userRepository;
  final OnboardingActions _actions;

  OnboardingCubit({
    required UserRepository userRepository,
    required OnboardingActions onboardingActions,
  })  : _userRepository = userRepository,
        _actions = onboardingActions,
        super(const OnboardingState());

  Future<void> onSubmit({
    required String username,
    required String password,
  }) async {
    if (state.saveEnabled) {
      emit(const OnboardingState(saveEnabled: false));
      try {
        await _userRepository.signUp(username: username, password: password);
        _actions.navigateToLogin();
      } on Exception {
        emit(const OnboardingState());
        rethrow;
      }
    }
  }
}
