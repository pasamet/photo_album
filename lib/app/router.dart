import 'package:auto_route/auto_route.dart';
import 'package:flutter/widgets.dart';

import '../data/entities.dart';
import '../data/user_repository.dart';
import '../ui/album/screen.dart';
import '../ui/home/screen.dart';
import '../ui/login/screen.dart';
import '../ui/onboarding/screen.dart';
import '../ui/photo/screen.dart';

part 'router.gr.dart';

typedef UserStateProvider = UserState Function();

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  final UserStateProvider _userStateProvider;

  late final _UserStateGuard _onboardedGuard = _UserStateGuard(
    userStateProvider: _userStateProvider,
    requiredUserState: UserState.onboarded,
    redirectTarget: const OnboardingRoute(),
  );

  late final _UserStateGuard _loggedInGuard = _UserStateGuard(
    userStateProvider: _userStateProvider,
    requiredUserState: UserState.loggedIn,
    redirectTarget: const LoginRoute(),
  );

  AppRouter({super.navigatorKey, required UserStateProvider userStateProvider})
      : _userStateProvider = userStateProvider;

  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: OnboardingRoute.page),
        AutoRoute(
          page: LoginRoute.page,
          guards: [_onboardedGuard],
        ),
        AutoRoute(
          page: HomeRoute.page,
          initial: true,
          guards: [_onboardedGuard, _loggedInGuard],
        ),
        AutoRoute(
          page: AlbumRoute.page,
          guards: [_onboardedGuard, _loggedInGuard],
        ),
        AutoRoute(
          page: PhotoRoute.page,
          guards: [_onboardedGuard, _loggedInGuard],
        ),
      ];
}

class _UserStateGuard extends AutoRouteGuard {
  final UserStateProvider _userStateProvider;
  final UserState _requiredUserState;
  final PageRouteInfo<Object?> _redirectTarget;

  _UserStateGuard({
    required UserStateProvider userStateProvider,
    required UserState requiredUserState,
    required PageRouteInfo<Object?> redirectTarget,
  })  : _userStateProvider = userStateProvider,
        _requiredUserState = requiredUserState,
        _redirectTarget = redirectTarget;

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    var userState = _userStateProvider();
    if (_isRequiredStateReached(userState)) {
      resolver.next();
    } else {
      resolver.redirect(_redirectTarget);
    }
  }

  bool _isRequiredStateReached(UserState userState) =>
      Enum.compareByIndex(userState, _requiredUserState) >= 0;
}
