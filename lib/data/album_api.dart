import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:http/http.dart';

import 'entities.dart';

const _jsonMimeType = 'application/json; charset=utf-8';
const _receiveJsonHeaders = {
  HttpHeaders.acceptHeader: _jsonMimeType,
};

const _sendJsonHeaders = {
  HttpHeaders.contentTypeHeader: _jsonMimeType,
};

const _sendAndReceiveJsonHeaders = <String, String>{
  ..._sendJsonHeaders,
  ..._receiveJsonHeaders,
};

class AlbumApi {
  final Client _client;
  final Uri _baseUri;

  AlbumApi({required Client client, required Uri baseUri})
      : _client = client,
        _baseUri = baseUri;

  Future<List<Album>> getAlbums() async {
    var url = _resolveUri(['albums']);
    var response = await _client.get(url, headers: _receiveJsonHeaders);
    if (response.statusCode == 200 && _isContentTypeJson(response)) {
      var jsonObject = _toJsonObject(response);
      if (jsonObject is List<Object?>) {
        return jsonObject
            .whereType<Map<String, Object?>>()
            .map(Album.fromJson)
            .toList(growable: false);
      }
    }
    _fail(response);
  }

  Future<void> deleteAlbum(int albumId) async {
    var url = _resolveUri(['albums', '$albumId']);
    var response = await _client.delete(url);
    if (response.statusCode == 200) {
      return;
    }
    _fail(response);
  }

  Future<Album> createAlbum({
    required int userId,
    required String title,
  }) async {
    var url = _resolveUri(['albums']);

    var jsonObject = <String, Object?>{
      'userId': userId,
      'title': title,
    };
    var requestBody = _toBytes(jsonObject);

    var response = await _client.post(
      url,
      headers: _sendAndReceiveJsonHeaders,
      body: requestBody,
    );

    if (response.statusCode == 201) {
      var jsonObject = _toJsonObject(response);
      if (jsonObject is Map<String, Object?>) {
        return Album.fromJson(jsonObject);
      }
    }
    _fail(response);
  }

  Future<List<Photo>> getPhotos(int albumId) async {
    var url = _resolveUri(['albums', '$albumId', 'photos']);

    var response = await _client.get(url, headers: _receiveJsonHeaders);
    if (response.statusCode == 200 && _isContentTypeJson(response)) {
      var jsonObject = _toJsonObject(response);
      if (jsonObject is List<Object?>) {
        return jsonObject
            .whereType<Map<String, Object?>>()
            .map(Photo.fromJson)
            .toList(growable: false);
      }
    }
    _fail(response);
  }

  Object? _toJsonObject(Response response) {
    var jsonString = utf8.decode(response.bodyBytes);
    var jsonObject = json.decode(jsonString);
    return jsonObject;
  }

  Uint8List _toBytes(Object jsonObject) {
    var jsonString = json.encode(jsonObject);
    var jsonBytes = utf8.encode(jsonString);
    return jsonBytes;
  }

  bool _isContentTypeJson(Response response) {
    var values = response.headersSplitValues[HttpHeaders.contentTypeHeader];
    return values?.length == 1 &&
        values!.first.toLowerCase().startsWith('application/json');
  }

  Uri _resolveUri(Iterable<String> pathSegments) => _baseUri.resolveUri(
        Uri(pathSegments: pathSegments),
      );

  Never _fail(Response response) => throw HttpException(
        'Unexpected response: ${response.statusCode} ${response.reasonPhrase}',
        uri: response.request?.url,
      );
}
