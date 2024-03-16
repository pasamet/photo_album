import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/album_repository.dart';
import '../../data/entities.dart';

@immutable
class HomeState {
  final List<Album> albums;
  const HomeState({this.albums = const []});
}

abstract class HomeActions {
  void navigateToAlbum(int albumId);
  void showCreateAlbumDialog(void Function(String title) onSubmit);
  void showErrorToast(String title);
}

class HomeCubit extends Cubit<HomeState> {
  final AlbumRepository _albumRepository;
  final HomeActions _actions;

  late final StreamSubscription<void> _albumsSubscription;

  HomeCubit({
    required AlbumRepository albumRepository,
    required HomeActions homeActions,
  })  : _albumRepository = albumRepository,
        _actions = homeActions,
        super(const HomeState()) {
    _albumsSubscription = _albumRepository.albumsStream.listen(
      (albums) {
        emit(HomeState(albums: albums));
      },
      onError: (Object e, s) {
        _actions.showErrorToast('Could not load albums. Reason: $e');
      },
    );
  }

  @override
  Future<void> close() async {
    await _albumsSubscription.cancel();
    await super.close();
  }

  void onAlbumPressed(int albumId) {
    _actions.navigateToAlbum(albumId);
  }

  void onAddAlbum() {
    _actions.showCreateAlbumDialog(_onCreateAlbumDialogSubmit);
  }

  Future<void> onRemoveAlbum(int albumId) async {
    try {
      await _albumRepository.removeAlbum(albumId);
    } on Exception catch (e) {
      _actions.showErrorToast('Could not remove the album. Reason: $e');
    }
  }

  Future<void> _onCreateAlbumDialogSubmit(String title) async {
    try {
      await _albumRepository.addAlbum(title: title);
    } on Exception catch (e) {
      _actions.showErrorToast('Could not create the album. Reason: $e');
    }
  }
}
