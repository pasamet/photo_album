import 'package:auto_route/auto_route.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../app/router.dart';
import 'content.dart';
import 'cubit.dart';

final _getIt = GetIt.instance;

@RoutePage()
class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen>
    implements OnboardingActions {
  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (_) => OnboardingCubit(
          userRepository: _getIt(),
          onboardingActions: this,
        ),
        child: const OnboardingContent(),
      );

  @override
  void navigateToLogin() => context.router.replace(const LoginRoute());
}
