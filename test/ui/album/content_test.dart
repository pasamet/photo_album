import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';
import 'package:photo_album/data/entities.dart';
import 'package:photo_album/ui/album/content.dart';
import 'package:photo_album/ui/album/cubit.dart';

void main() {
  late _FakeAlbumCubit albumCubit;
  late AlbumContent sut;

  setUp(() {
    sut = const AlbumContent();
    albumCubit = _FakeAlbumCubit();
  });

  testWidgets(
    'When initialized Then displays album title and the photos',
    (tester) => mockNetworkImages(() async {
      await tester.pumpWidget(
        _createApp(albumCubit, sut),
      );

      expect(find.text('Album: Album 1'), findsOneWidget);
      expect(find.text('title1'), findsOneWidget);
      expect(find.text('title2'), findsOneWidget);
    }),
  );

  testWidgets(
    'When a photo is tapped Then navigates to the photo',
    (tester) => mockNetworkImages(() async {
      await tester.pumpWidget(
        _createApp(albumCubit, sut),
      );

      await tester.tap(find.text('title2'));
      await tester.pumpAndSettle();

      expect(albumCubit.onPhotoPressedInvocationCount, 1);
      expect(albumCubit.lastPhotoId, 2);
    }),
  );
}

MaterialApp _createApp(_FakeAlbumCubit albumCubit, AlbumContent sut) =>
    MaterialApp(
      home: BlocProvider<AlbumCubit>.value(
        value: albumCubit,
        child: sut,
      ),
    );

const _state = AlbumState(
  title: 'Album 1',
  photos: [
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
  ],
);

class _FakeAlbumCubit extends Cubit<AlbumState> implements AlbumCubit {
  _FakeAlbumCubit() : super(_state);

  int onPhotoPressedInvocationCount = 0;
  int? lastPhotoId;

  @override
  void onPhotoPressed(int photoId) {
    onPhotoPressedInvocationCount++;
    lastPhotoId = photoId;
  }
}
