import 'package:flutter/material.dart';

import 'login/login.dart';

class Routes {
  static Map<String, WidgetBuilder> getRoutes() => {
        '/login': (context) => const LoginPage(),
      };
}
