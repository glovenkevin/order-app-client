import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:order_app_client/features/customer/view/landing/landing.dart';
import 'package:order_app_client/features/customer/view/routes.dart';
import 'package:order_app_client/features/customer/viewmodel/vm_providers.dart';
import 'package:order_app_client/infrastructure/dependency_injection/injection.dart';
import 'package:order_app_client/infrastructure/easyoading/easyloading.dart';
import 'package:provider/provider.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Setup dependency injection
  await configureDependencies();

  // Setup easy loading
  configEasyLoading();

  runApp(const MyClientApp());
}

class MyClientApp extends StatelessWidget {
  const MyClientApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: ViewModelProviders.getProviders(),
      child: MaterialApp(
        title: 'Order App Client',
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
