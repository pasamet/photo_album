import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/album_repository.dart';
import '../../data/entities.dart';

@immutable
class AlbumState {
  final String title;
  final List<Photo> photos;
  const AlbumState({this.title = '', this.photos = const []});
}

abstract class AlbumActions {
  void navigateToPhoto(Photo photo);
  void showErrorToast(String title);
}

class AlbumCubit extends Cubit<AlbumState> {
  final Album _album;
  final AlbumRepository _albumRepository;
  final AlbumActions _actions;

  AlbumCubit({
    required Album album,
    required AlbumRepository albumRepository,
    required AlbumActions albumActions,
  })  : _album = album,
        _albumRepository = albumRepository,
        _actions = albumActions,
        super(const AlbumState()) {
    _albumRepository.getPhotos(_album.id).then(
      (photos) {
        emit(AlbumState(title: _album.title, photos: photos));
      },
      onError: (Object e, s) {
        _actions.showErrorToast('Could not load photos. Reason: $e');
      },
    );
  }

  void onPhotoPressed(int photoId) {
    var photo = state.photos.where((photo) => photo.id == photoId).firstOrNull;
    if (photo != null) {
      _actions.navigateToPhoto(photo);
    }
  }
}
