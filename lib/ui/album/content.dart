import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/entities.dart';
import 'cubit.dart';

class AlbumContent extends StatelessWidget {
  const AlbumContent({super.key});

  @override
  Widget build(BuildContext context) => BlocBuilder<AlbumCubit, AlbumState>(
        builder: (context, state) => Scaffold(
          appBar: AppBar(
            title: Text('Album: ${state.title}'),
          ),
          body: _buildList(state, context),
        ),
      );

  Widget _buildList(AlbumState state, BuildContext context) => GridView.builder(
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 150,
        ),
        itemCount: state.photos.length,
        itemBuilder: (context, index) => _buildGridItem(
          context,
          state.photos[index],
        ),
      );

  Widget _buildGridItem(BuildContext context, Photo photo) {
    AlbumCubit cubit() => BlocProvider.of<AlbumCubit>(context);

    return GridTile(
      footer: GridTileBar(title: Text(photo.title)),
      child: InkResponse(
        child: Image.network(photo.thumbnailUrl),
        onTap: () => cubit().onPhotoPressed(photo.id),
      ),
    );
  }
}
