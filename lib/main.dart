import 'package:flutter/material.dart';

import 'ui/app/app.dart';
import 'ui/app/di.dart';

Future<void> main() async {
  await setupDependencies();
  runApp(const App());
}
