import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:get_it/get_it.dart';
import 'package:order_app_client/features/customer/data/repository/api/auth_repo_impl.dart';
import 'package:order_app_client/features/customer/data/repository/api/menu_repo_impl.dart';
import 'package:order_app_client/features/customer/data/repository/firebase/cart_repo_impl.dart';
import 'package:order_app_client/features/customer/domain/repository/auth_repo.dart';
import 'package:order_app_client/features/customer/domain/repository/menu_repo.dart';
import 'package:order_app_client/features/customer/domain/usecase/home.dart';
import 'package:order_app_client/features/customer/domain/usecase/login.dart';
import 'package:order_app_client/features/customer/domain/usecase/register.dart';
import 'package:order_app_client/infrastructure/firebase/remote_config.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../firebase/firebase.dart';

final GetIt getIt = GetIt.instance;

Future<void> configureDependencies() async {
  // Repository -.
  getIt.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl());
  getIt.registerLazySingleton<MenuRepository>(() => MenuRepositoryImpl());
  getIt.registerLazySingleton<CartRepositoryImpl>(() => CartRepositoryImpl());

  // UseCase -.
  getIt.registerLazySingleton<LoginUseCase>(() => LoginUseCase());
  getIt.registerLazySingleton<RegisterUseCase>(() => RegisterUseCase());
  getIt.registerLazySingleton<HomeUseCase>(() => HomeUseCase());

  // Firebase -.
  getIt.registerSingleton<FirebaseApp>(await FirebaseAppHelper.getInstance());
  getIt.registerSingletonAsync<FirebaseRemoteConfig>(
    () => RemoteConfigHelper.getInstance(),
  );
  getIt.registerSingletonAsync<FirebaseMessaging>(
      () => Future(() => FirebaseMessaging.instance));
  getIt.registerSingletonAsync<FirebaseDatabase>(
      () => Future(() => FirebaseDatabase.instanceFor(
            app: Firebase.app(),
            databaseURL:
                "https://order-app-ot-default-rtdb.asia-southeast1.firebasedatabase.app",
          )));

  // Miscellaneous -.
  getIt.registerSingleton<SharedPreferences>(
      await SharedPreferences.getInstance());
}
