import 'package:flutter/material.dart';
import 'package:order_app_client/features/customer/view/auth/register.dart';
import 'package:order_app_client/features/customer/view/main/main_panel.dart';

import 'auth/login.dart';

class Routes {
  static Map<String, WidgetBuilder> getRoutes() => {
        '/login': (_) => const LoginPage(),
        '/register': (_) => const RegisterPage(),
        '/main': (_) => const MainPanelPage(),
      };
}
