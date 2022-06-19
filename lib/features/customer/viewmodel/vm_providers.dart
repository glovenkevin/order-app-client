import 'package:order_app_client/features/customer/viewmodel/auth/login_vm.dart';
import 'package:order_app_client/features/customer/viewmodel/auth/register_vm.dart';
import 'package:order_app_client/features/customer/viewmodel/main/tab_home_vm.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class ViewModelProviders {
  static List<SingleChildWidget> getProviders() => [
        ChangeNotifierProvider<LoginViewModel>(
          create: (_) => LoginViewModel(),
        ),
        ChangeNotifierProvider<RegisterViewModel>(
          create: (_) => RegisterViewModel(),
        ),
        ChangeNotifierProvider<TabHomeViewModel>(
          create: (_) => TabHomeViewModel(),
        ),
      ];
}
