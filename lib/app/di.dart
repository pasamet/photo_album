import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/user_repository.dart';

Future<void> setupDependencies() async {
  var getIt = GetIt.instance;
  await getIt.reset();
  getIt
    ..registerSingletonAsync(
      SharedPreferences.getInstance,
    )
    ..registerLazySingleton(
      () => UserRepository(storage: getIt()),
    );
  await getIt.allReady();
}
