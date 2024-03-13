import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../app/router.dart';
import 'content.dart';
import 'cubit.dart';

final _getIt = GetIt.instance;

@RoutePage()
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> implements LoginActions {
  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (_) => LoginCubit(
          userRepository: _getIt(),
          loginActions: this,
        ),
        child: const LoginContent(),
      );

  @override
  void navigateToHome() => context.router.replace(const HomeRoute());
}
