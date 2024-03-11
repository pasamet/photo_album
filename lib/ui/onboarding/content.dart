import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../common/dimensions.dart';
import 'cubit.dart';
import 'form.dart';

class OnboardingContent extends StatelessWidget {
  const OnboardingContent({super.key});

  @override
  Widget build(BuildContext context) => _buildScaffold();

  Scaffold _buildScaffold() => Scaffold(
        appBar: AppBar(
          title: const Text('Onboard User'),
        ),
        body: Center(
          child: Container(
            padding: containerInsets,
            constraints: const BoxConstraints(maxWidth: maxTextWidth),
            child: BlocBuilder<OnboardingCubit, OnboardingState>(
              builder: (context, state) => _buildForm(state, context),
            ),
          ),
        ),
      );

  Widget _buildForm(OnboardingState state, BuildContext context) {
    var callback = state.saveEnabled
        ? ({
            required String username,
            required String password,
          }) {
            BlocProvider.of<OnboardingCubit>(context).onSubmit(
              username: username,
              password: password,
            );
          }
        : null;
    return OnboardingForm(
      submitCallback: callback,
    );
  }
}
