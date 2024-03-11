import 'package:flutter/material.dart';

import '../common/dimensions.dart';

typedef SubmitCallback = void Function({
  required String username,
  required String password,
});

class OnboardingForm extends StatefulWidget {
  final SubmitCallback submitCallback;

  const OnboardingForm({super.key, required this.submitCallback});

  @override
  State<OnboardingForm> createState() => _OnboardingFormState();
}

class _OnboardingFormState extends State<OnboardingForm> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              controller: _usernameController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Username',
              ),
              validator: _textNotBlankValidator,
            ),
            gap16,
            TextFormField(
              controller: _passwordController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Password',
              ),
              obscureText: true,
              validator: _textNotBlankValidator,
            ),
            gap16,
            OutlinedButton(onPressed: _onSubmit, child: const Text('Save')),
          ],
        ),
      );

  void _onSubmit() {
    if (_formKey.currentState!.validate()) {
      widget.submitCallback(
        username: _usernameController.text,
        password: _passwordController.text,
      );
    }
  }

  String? _textNotBlankValidator(String? text) =>
      (text?.trim().isEmpty ?? true) ? 'Should not be blank.' : null;
}
