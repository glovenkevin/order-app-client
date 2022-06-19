import 'package:dio/dio.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:order_app_client/infrastructure/dependency_injection/injection.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class API {
  static Dio dio() {
    var remoteConfig = getIt<FirebaseRemoteConfig>();
    var baseUrl = remoteConfig.getString('base_url');

    String env = const String.fromEnvironment('ENV', defaultValue: "PROD");
    if (env.isNotEmpty && env == 'DEV') {
      baseUrl = 'http://10.0.2.2:8000/api/v1';
    }
    if (env.isNotEmpty && env == 'STAGING') {
      baseUrl = remoteConfig.getString('base_url_staging');
    }

    BaseOptions options = BaseOptions(
      connectTimeout: 1000,
      baseUrl: baseUrl,
      headers: {
        "Accept": "application/json",
        'Content-type': 'application/json',
        'X-Requested-With': 'XMLHttpRequest',
      },
    );

    var dio = Dio(options);
    dio.interceptors.add(PrettyDioLogger(
        requestBody: true, responseBody: true, error: true, compact: true));
    return dio;
  }
}
