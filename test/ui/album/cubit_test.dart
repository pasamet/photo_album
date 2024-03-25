import 'package:flutter_test/flutter_test.dart';
import 'package:photo_album/data/album_repository.dart';
import 'package:photo_album/data/entities.dart';
import 'package:photo_album/ui/album/cubit.dart';

void main() {
  const album = Album(userId: 1, id: 2, title: 'album title');
  late _FakeAlbumRepository albumRepository;
  late _FakeAlbumActions albumActions;
  late AlbumCubit sut;

  setUp(() {
    albumRepository = _FakeAlbumRepository();
    albumActions = _FakeAlbumActions();
    sut = AlbumCubit(
      album: album,
      albumRepository: albumRepository,
      albumActions: albumActions,
    );
  });

  test('When intialized Then emits photos', () async {
    var actual = sut.state;

    expect(actual.title, album.title);
    expect(actual.photos, _photos);
    expect(albumRepository.getPhotosInvocationCount, 1);
    expect(albumRepository.lastAlbumId, album.id);
  });

  test('When a photo is tapped Then navigates to the photo', () async {
    sut.onPhotoPressed(2);

    expect(albumActions.navigateToPhotoInvocationCount, 1);
    expect(albumActions.lastPhoto, _photos[1]);
  });
}

const _photos = [
  Photo(
    albumId: 2,
    id: 1,
    title: 'title1',
    url: 'https://example.com/image1.jpeg',
    thumbnailUrl: 'https://example.com/thumbnail1.jpeg',
  ),
  Photo(
    albumId: 2,
    id: 2,
    title: 'title2',
    url: 'https://example.com/image2.jpeg',
    thumbnailUrl: 'https://example.com/thumbnail2.jpeg',
  ),
];

class _FakeAlbumRepository implements AlbumRepository {
  int getPhotosInvocationCount = 0;
  int? lastAlbumId;

  @override
  Future<List<Photo>> getPhotos(int albumId) async {
    getPhotosInvocationCount++;
    lastAlbumId = albumId;
    return _photos;
  }

  @override
  Future<Album> addAlbum({required String title}) => _notCalled();

  @override
  Stream<List<Album>> get albumsStream => _notCalled();

  @override
  Future<void> onDispose() => _notCalled();

  @override
  Future<void> removeAlbum(int albumId) => _notCalled();

  @override
  Future<void> loadMoreAlbums() {
    // TODO: implement loadMoreAlbums
    throw UnimplementedError();
  }
}

class _FakeAlbumActions implements AlbumActions {
  int navigateToPhotoInvocationCount = 0;
  Photo? lastPhoto;

  @override
  void navigateToPhoto(Photo photo) {
    navigateToPhotoInvocationCount++;
    lastPhoto = photo;
  }

  @override
  void showErrorToast(String title) => _notCalled();
}

Never _notCalled() => throw AssertionError('Should not be called.');
