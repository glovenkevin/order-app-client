import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:get_it/get_it.dart';
import 'package:order_app_client/features/customer/data/repository/auth_repo_impl.dart';
import 'package:order_app_client/features/customer/domain/repository/auth_repo.dart';
import 'package:order_app_client/features/customer/domain/usecase/login.dart';
import 'package:order_app_client/features/customer/domain/usecase/register.dart';
import 'package:order_app_client/infrastructure/firebase/remote_config.dart';

import '../firebase/firebase.dart';

final GetIt getIt = GetIt.instance;

Future<void> configureDependencies() async {
  // Repository -.
  getIt.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl());

  // UseCase -.
  getIt.registerLazySingleton<LoginUseCase>(() => LoginUseCase());
  getIt.registerLazySingleton<RegisterUseCase>(() => RegisterUseCase());

  // Firebase -.
  getIt.registerSingleton<FirebaseApp>(await FirebaseAppHelper.getInstance());
  getIt.registerSingleton<FirebaseRemoteConfig>(
      await RemoteConfigHelper.getInstance());
  getIt.registerSingleton<FirebaseMessaging>(FirebaseMessaging.instance);
}
