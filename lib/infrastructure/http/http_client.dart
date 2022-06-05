import 'package:dio/dio.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';

import '../dependency_injection/injection.dart';

class API {
  static Dio dio() {
    var remoteConfig = getIt<FirebaseRemoteConfig>();
    var baseUrl = remoteConfig.getString('base_url');

    BaseOptions options = BaseOptions(
      connectTimeout: 10000,
      receiveTimeout: 5000,
      baseUrl: baseUrl,
      headers: {
        "Accept": "application/json",
        'Content-type': 'application/json',
        'X-Requested-With': 'XMLHttpRequest',
      },
    );

    var dio = Dio(options);
    dio.interceptors.add(LogInterceptor(responseBody: true));
    return dio;
  }
}
