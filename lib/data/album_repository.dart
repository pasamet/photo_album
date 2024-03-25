import 'dart:async';

import 'package:get_it/get_it.dart';
import 'package:rxdart/rxdart.dart';

import 'album_api.dart';
import 'entities.dart';

class AlbumRepository implements Disposable {
  final AlbumApi _albumApi;
  late final _albumsSubject = BehaviorSubject<List<Album>>.seeded(
    const [],
    onListen: _onListenAlbums,
  );

  AlbumRepository({required AlbumApi albumApi}) : _albumApi = albumApi;

  Stream<List<Album>> get albumsStream => _albumsSubject.stream;

  Future<Album> addAlbum({required String title}) async {
    var album = await _albumApi.createAlbum(userId: 1, title: title);
    _albumsSubject.value =
        _albumsSubject.value.followedBy([album]).toList(growable: false);
    return album;
  }

  Future<void> removeAlbum(int albumId) async {
    var oldValue = _albumsSubject.value;
    _albumsSubject.value =
        oldValue.where((album) => album.id != albumId).toList(growable: false);
    try {
      await _albumApi.deleteAlbum(albumId);
    } on Exception {
      // Revert
      _albumsSubject.value = oldValue;
      rethrow;
    }
  }

  Future<List<Photo>> getPhotos(int albumId) => _albumApi.getPhotos(albumId);

  void _onListenAlbums() {
    _refreshAlbums();
  }

  Future<void> _refreshAlbums() =>
      _albumsSubject.sink.addStream(Stream.fromFuture(_albumApi.getAlbums()));

  Future<void> loadMoreAlbums() async {
    var albums = await _albumApi.getAlbums();
    _albumsSubject.value = _albumsSubject.value.followedBy(albums).toList();
  }

  @override
  Future<void> onDispose() async {
    await _albumsSubject.close();
  }
}
