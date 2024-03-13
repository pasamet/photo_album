import 'package:flutter/material.dart';

import '../common/dimensions.dart';
import '../common/validators.dart';

typedef LoginCallback = void Function({
  required String username,
  required String password,
});

class LoginForm extends StatefulWidget {
  final LoginCallback? loginCallback;
  final String? errorText;

  const LoginForm({
    super.key,
    required this.loginCallback,
    this.errorText,
  });

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
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
    var callback = widget.loginCallback;
    var errorText = widget.errorText;

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
          if (errorText != null) ...[
            gap16,
            Text(
              errorText,
              style: TextStyle(color: Theme.of(context).colorScheme.error),
            ),
          ],
          gap16,
          OutlinedButton(
            onPressed: callback == null ? null : () => _onSubmit(callback),
            child: const Text('Log in'),
          ),
        ],
      ),
    );
  }

  void _onSubmit(LoginCallback callback) {
    if (_formKey.currentState!.validate()) {
      callback(
        username: _usernameController.text,
        password: _passwordController.text,
      );
    }
  }
}
