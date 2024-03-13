import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../common/dimensions.dart';
import 'cubit.dart';
import 'form.dart';

class LoginContent extends StatelessWidget {
  const LoginContent({super.key});

  @override
  Widget build(BuildContext context) => _buildScaffold();

  Scaffold _buildScaffold() => Scaffold(
        appBar: AppBar(
          title: const Text('Login'),
        ),
        body: Center(
          child: Container(
            padding: containerInsets,
            constraints: const BoxConstraints(maxWidth: maxTextWidth),
            child: BlocBuilder<LoginCubit, LoginState>(
              builder: (context, state) => _buildForm(state, context),
            ),
          ),
        ),
      );

  Widget _buildForm(LoginState state, BuildContext context) {
    var callback = state.logInEnabled
        ? ({
            required String username,
            required String password,
          }) {
            BlocProvider.of<LoginCubit>(context).onLogIn(
              username: username,
              password: password,
            );
          }
        : null;
    return LoginForm(
      loginCallback: callback,
      errorText: state.showInvalidCredentials ? 'Invalid credentials.' : null,
    );
  }
}
