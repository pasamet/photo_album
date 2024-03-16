import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/user_repository.dart';
import '../data/album_api.dart';
import '../data/album_repository.dart';
import 'router.dart';

Future<void> setupDependencies() async {
  var getIt = GetIt.instance;
  await getIt.reset();
  getIt
    ..registerSingletonAsync(
      SharedPreferences.getInstance,
    )
    ..registerLazySingleton(
      () => UserRepository(storage: getIt()),
    )
    ..registerLazySingleton<UserStateProvider>(
      () => () => getIt<UserRepository>().state,
    )
    ..registerLazySingleton(Client.new, dispose: (instance) => instance.close())
    ..registerLazySingleton(
      () => AlbumApi(
        client: getIt(),
        baseUri: Uri.https('jsonplaceholder.typicode.com'),
      ),
    )
    ..registerLazySingleton(() => AlbumRepository(albumApi: getIt()))
    ..registerLazySingleton(() => AppRouter(userStateProvider: getIt()));
  await getIt.allReady();
}
