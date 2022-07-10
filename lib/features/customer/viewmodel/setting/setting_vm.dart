import 'package:flutter/material.dart';
import 'package:order_app_client/infrastructure/dependency_injection/injection.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingViewModel extends ChangeNotifier {
  final SharedPreferences _prefs = getIt<SharedPreferences>();

  void doLogOut(BuildContext context) {
    _prefs.clear();
    Navigator.pushNamedAndRemoveUntil(context, "/", (route) => false);
  }
}
