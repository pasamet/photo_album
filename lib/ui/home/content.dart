import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/entities.dart';
import 'cubit.dart';

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Home'),
        ),
        body: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) => _buildList(state, context),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: BlocProvider.of<HomeCubit>(context).onAddAlbum,
          tooltip: 'Add new album',
          child: const Icon(Icons.add),
        ),
      );

  Widget _buildList(HomeState state, BuildContext context) {
    var length = state.albums.length;
    return ListView.builder(
      restorationId: 'albumsList',
      itemCount: length + 1,
      itemBuilder: (context, index) {
        if (index == length) {
          return _buildLoadMoreItem(context);
        } else {
          return _buildListItem(
            context,
            state.albums[index],
          );
        }
      },
    );
  }

  Widget _buildLoadMoreItem(BuildContext context) {
    HomeCubit cubit() => BlocProvider.of<HomeCubit>(context);
    cubit().loadMore();
    return const SizedBox(
      width: 48,
      height: 48,
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildListItem(BuildContext context, Album album) {
    HomeCubit cubit() => context.read<HomeCubit>();

    var colorScheme = Theme.of(context).colorScheme;
    var listTile = ListTile(
      title: Text(album.title),
      trailing: Text(album.id.toString()),
      onTap: () => cubit().onAlbumPressed(album.id),
    );
    var deleteIcon = Icon(
      Icons.delete,
      color: colorScheme.onError,
    );
    var background = Container(
      color: colorScheme.error,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          deleteIcon,
          const Spacer(),
          deleteIcon,
        ],
      ),
    );
    return Dismissible(
      key: ValueKey(album.id),
      onDismissed: (direction) => cubit().onRemoveAlbum(album.id),
      background: background,
      child: listTile,
    );
  }
}
