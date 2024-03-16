import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';

@RoutePage()
class AlbumScreen extends StatelessWidget {
  final int albumId;

  const AlbumScreen({super.key, required this.albumId});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Album'),
        ),
      );
}
