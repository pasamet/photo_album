import 'package:auto_route/auto_route.dart';

import '../ui/home/screen.dart';
import '../ui/login/screen.dart';
import '../ui/onboarding/screen.dart';

part 'router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: OnboardingRoute.page, initial: true),
        AutoRoute(page: LoginRoute.page),
        AutoRoute(page: HomeRoute.page),
      ];
}
