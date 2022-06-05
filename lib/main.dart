import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:order_app_client/features/customer/view/landing/landing.dart';
import 'package:order_app_client/features/customer/view/routes.dart';
import 'package:order_app_client/infrastructure/dependency_injection/injection.dart';
import 'package:order_app_client/infrastructure/easyoading/easyloading.dart';
import 'package:provider/provider.dart';

import 'features/customer/viewmodel/login/login_vm.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Setup dependency injection
  await configureDependencies();

  // Setup easy loading
  configEasyLoading();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<LoginViewModel>(
          create: (_) => LoginViewModel(),
        ),
      ],
      child: MaterialApp(
        title: 'Order App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          fontFamily: 'OpenSans',
        ),
        home: const LandingPage(),
        routes: Routes.getRoutes(),
        builder: EasyLoading.init(),
      ),
    );
  }
}
