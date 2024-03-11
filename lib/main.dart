import 'package:flutter/material.dart';

import 'ui/onboarding/onboarding_screen.dart';

void main() {
  runApp(const PhotoAlbumApp());
}

class PhotoAlbumApp extends StatelessWidget {
  const PhotoAlbumApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'Photo Album',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          useMaterial3: true,
        ),
        home: const OnboardingScreen(),
      );
}
