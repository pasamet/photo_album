import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../app/router.dart';
import '../../data/entities.dart';
import 'content.dart';
import 'cubit.dart';

final _getIt = GetIt.instance;

@RoutePage()
class AlbumScreen extends StatefulWidget {
  final Album album;

  const AlbumScreen({super.key, required this.album});

  @override
  State<AlbumScreen> createState() => _AlbumScreenState();
}

class _AlbumScreenState extends State<AlbumScreen> implements AlbumActions {
  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (_) => AlbumCubit(
          album: widget.album,
          albumRepository: _getIt(),
          albumActions: this,
        ),
        child: const AlbumContent(),
      );

  @override
  void navigateToPhoto(Photo photo) =>
      context.router.push(PhotoRoute(photo: photo));

  @override
  void showErrorToast(String title) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(title)));
  }
}
