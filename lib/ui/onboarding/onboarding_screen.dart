import 'package:flutter/material.dart';

import '../common/dimensions.dart';
import 'onboarding_form.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Onboard User'),
        ),
        body: Center(
          child: Container(
            padding: containerInsets,
            constraints: const BoxConstraints(maxWidth: maxTextWidth),
            child: OnboardingForm(
              submitCallback: ({required username, required password}) {
                // TODO: Submit credentials.
              },
            ),
          ),
        ),
      );
}
