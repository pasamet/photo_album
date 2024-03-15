import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  final RootStackRouter router;

  const App({
    super.key,
    required this.router,
  });

  @override
  Widget build(BuildContext context) => MaterialApp.router(
        title: 'Photo Album',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          useMaterial3: true,
        ),
        routerConfig: router.config(),
      );
}
