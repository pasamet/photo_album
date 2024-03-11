import 'package:auto_route/annotations.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import 'content.dart';
import 'cubit.dart';

final _getIt = GetIt.instance;

@RoutePage()
class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (_) => OnboardingCubit(userRepository: _getIt()),
        child: const OnboardingContent(),
      );
}
