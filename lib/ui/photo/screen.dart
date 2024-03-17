import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';

import '../../data/entities.dart';

@RoutePage()
class PhotoScreen extends StatelessWidget {
  final Photo photo;

  const PhotoScreen({super.key, required this.photo});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text('Photo: ${photo.title}'),
        ),
        body: SizedBox.expand(
          child: InteractiveViewer(
            child: Image.network(photo.url),
          ),
        ),
      );
}
