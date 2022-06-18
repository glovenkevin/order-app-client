import 'package:order_app_client/features/customer/viewmodel/auth/register_vm.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import 'auth/login_vm.dart';

class ViewModelProviders {
  static List<SingleChildWidget> getProviders() => [
        ChangeNotifierProvider<LoginViewModel>(
          create: (_) => LoginViewModel(),
        ),
        ChangeNotifierProvider<RegisterViewModel>(
            create: (_) => RegisterViewModel()),
      ];
}
