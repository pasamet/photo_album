import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'entities.g.dart';

@immutable
@JsonSerializable()
class Album {
  final int userId;
  final int id;
  final String title;

  const Album({
    required this.userId,
    required this.id,
    required this.title,
  });

  factory Album.fromJson(Map<String, Object?> json) => _$AlbumFromJson(json);
  Map<String, Object?> toJson() => _$AlbumToJson(this);
}

@immutable
@JsonSerializable()
class Photo {
  final int albumId;
  final int id;
  final String title;
  final String url;
  final String thumbnailUrl;

  const Photo({
    required this.albumId,
    required this.id,
    required this.title,
    required this.url,
    required this.thumbnailUrl,
  });

  factory Photo.fromJson(Map<String, Object?> json) => _$PhotoFromJson(json);
  Map<String, Object?> toJson() => _$PhotoToJson(this);
}
