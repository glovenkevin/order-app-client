import 'package:flutter/material.dart';
import 'package:order_app_client/infrastructure/dependency_injection/injection.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:order_app_client/infrastructure/lib/constant/constant.dart'
    as constants;

class LandingViewModel extends ChangeNotifier {
  final SharedPreferences _prefs = getIt<SharedPreferences>();

  void checkIsAlreadyLogIn(BuildContext context) {
    if (_prefs.containsKey(constants.isLoggedIn)) {
      bool isLoggedIn = _prefs.getBool(constants.isLoggedIn) ?? false;
      if (isLoggedIn) {
        Navigator.pushNamed(context, '/main');
      }
    }
  }
}
