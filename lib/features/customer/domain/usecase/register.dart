import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:order_app_client/features/customer/data/request/register_request.dart';
import 'package:order_app_client/features/customer/data/response/response.dart';
import 'package:order_app_client/features/customer/domain/repository/auth_repo.dart';
import 'package:order_app_client/infrastructure/dependency_injection/injection.dart';
import 'package:order_app_client/infrastructure/http/constant.dart';

class RegisterUseCase {
  AuthRepository repository = getIt<AuthRepository>();
  FirebaseMessaging fm = getIt<FirebaseMessaging>();

  Future<bool> register({
    required String email,
    required String password,
    required String name,
    required String phoneNumber,
  }) async {
    RegisterRequest req = RegisterRequest(
        email: email,
        password: password,
        name: name,
        phoneNumber: phoneNumber,
        fcmToken: "");

    try {
      final fcmToken = await fm.getToken();
      if (fcmToken == null) {
        return Future.error("Failed to get token");
      }
      req.fcmToken = fcmToken;
    } on Exception catch (e) {
      log("RegisterUseCase.register - Error: ${e.toString()}");
      return Future.error("Failed to get token");
    }

    BaseResponse res = await repository.register(req);
    if (res.statusCode != HttpConstant.CREATED) {
      log("RegisterUseCase - Error: ${res.message}");
      return Future.error(res.message);
    }
    return true;
  }
}
