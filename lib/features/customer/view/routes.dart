import 'package:flutter/material.dart';
import 'package:order_app_client/features/customer/view/auth/register.dart';

import 'auth/login.dart';

class Routes {
  static Map<String, WidgetBuilder> getRoutes() => {
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegisterPage(),
      };
}
