import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../app/router.dart';
import '../../data/entities.dart';
import 'content.dart';
import 'cubit.dart';
import 'dialog.dart';

final _getIt = GetIt.instance;

@RoutePage()
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> implements HomeActions {
  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (_) => HomeCubit(
          albumRepository: _getIt(),
          homeActions: this,
        ),
        child: const HomeContent(),
      );

  @override
  void navigateToAlbum(Album album) =>
      context.router.navigate(AlbumRoute(album: album));

  @override
  Future<void> showCreateAlbumDialog(
    void Function(String title) onSubmit,
  ) async {
    var title = await showAdaptiveDialog<String>(
      context: context,
      builder: (context) => const CreateAlbumDialog(),
    );
    if (title != null) {
      onSubmit(title);
    }
  }

  @override
  void showErrorToast(String title) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(title)));
  }
}
