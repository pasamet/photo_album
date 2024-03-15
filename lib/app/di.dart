import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/user_repository.dart';
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
    ..registerLazySingleton(() => AppRouter(userStateProvider: getIt()));
  await getIt.allReady();
}
