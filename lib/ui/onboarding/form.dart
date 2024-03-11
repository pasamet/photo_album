import 'package:flutter/material.dart';

import '../common/dimensions.dart';
import '../common/validators.dart';

typedef SubmitCallback = void Function({
  required String username,
  required String password,
});

class OnboardingForm extends StatefulWidget {
  final SubmitCallback? submitCallback;

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
  Widget build(BuildContext context) {
    var callback = widget.submitCallback;
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _usernameController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Username',
            ),
            validator: textNotBlankValidator,
          ),
          gap16,
          TextFormField(
            controller: _passwordController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Password',
            ),
            obscureText: true,
            validator: textNotBlankValidator,
          ),
          gap16,
          OutlinedButton(
            onPressed: callback == null ? null : () => _onSubmit(callback),
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _onSubmit(SubmitCallback callback) {
    if (_formKey.currentState!.validate()) {
      callback(
        username: _usernameController.text,
        password: _passwordController.text,
      );
    }
  }
}
