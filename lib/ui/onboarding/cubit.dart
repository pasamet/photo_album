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

class OnboardingCubit extends Cubit<OnboardingState> {
  final UserRepository _userRepository;

  OnboardingCubit({
    required UserRepository userRepository,
  })  : _userRepository = userRepository,
        super(const OnboardingState());

  Future<void> onSubmit({
    required String username,
    required String password,
  }) async {
    if (state.saveEnabled) {
      emit(const OnboardingState(saveEnabled: false));
      try {
        await _userRepository.signup(username: username, password: password);
      } on Exception {
        emit(const OnboardingState());
        rethrow;
      }
      // TODO: Navigate to login
    }
  }
}
