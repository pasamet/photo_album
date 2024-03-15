import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';
import 'package:photo_album/data/album_api.dart';

void main() {
  late AlbumApi sut;
  Response? response;
  Request? request;

  setUp(() {
    request = null;
    var client = MockClient((req) async {
      request = req;
      return response!;
    });
    sut = AlbumApi(
      client: client,
      baseUri: Uri.https('example.com'),
    );
  });

  test('When albums are requested Then result is not empty', () async {
    response = Response(
      '['
      '{"id":1,"userId":5,"title":"title1"},'
      '{"id":2,"userId":5,"title":"title2"}'
      ']',
      200,
      headers: {
        'content-type': 'application/json; charset=utf-8',
      },
    );

    var actual = await sut.getAlbums();

    expect(request?.url.toString(), 'https://example.com/albums');
    expect(request?.method, 'GET');
    expect(actual, hasLength(2));
  });

  test('When delete album requested Then response is successful', () async {
    response = Response(
      '',
      200,
    );

    await sut.deleteAlbum(3);

    expect(request?.url.toString(), 'https://example.com/albums/3');
    expect(request?.method, 'DELETE');
  });

  test('When create album requested Then title and user ID is set', () async {
    response = Response(
      '{"id":1,"userId":5,"title":"title1"}',
      201,
      headers: {
        'content-type': 'application/json; charset=utf-8',
      },
    );

    var actual = await sut.createAlbum(
      userId: 5,
      title: 'title1',
    );

    expect(request?.url.toString(), 'https://example.com/albums');
    expect(request?.method, 'POST');
    expect(actual.id, 1);
    expect(actual.userId, 5);
    expect(actual.title, 'title1');
  });

  test('When photos are requested Then result is not empty', () async {
    response = Response(
      '['
      '{"id":101,"albumId":5,"title":"title1","url":"https://example.com/image101.jpeg","thumbnailUrl":"https://example.com/thumbnail101.jpeg"},'
      '{"id":102,"albumId":5,"title":"title2","url":"https://example.com/image101.jpeg","thumbnailUrl":"https://example.com/thumbnail102.jpeg"}'
      ']',
      200,
      headers: {
        'content-type': 'application/json; charset=utf-8',
      },
    );

    var actual = await sut.getPhotos(5);

    expect(request?.url.toString(), 'https://example.com/albums/5/photos');
    expect(request?.method, 'GET');
    expect(actual, hasLength(2));
  });
}
