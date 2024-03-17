import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'app/app.dart';
import 'app/di.dart';
import 'app/router.dart';

final _getIt = GetIt.instance;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupDependencies();
  var router = _getIt<AppRouter>();
  var app = App(
    router: router,
  );
  runApp(app);
}
