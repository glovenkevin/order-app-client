import 'package:order_app_client/features/customer/data/request/login_request.dart';
import 'package:order_app_client/features/customer/data/response/response.dart';
import 'package:order_app_client/features/customer/domain/repository/auth_repo.dart';
import 'package:order_app_client/infrastructure/dependency_injection/injection.dart';
import 'package:order_app_client/infrastructure/http/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:order_app_client/infrastructure/lib/constant/constant.dart'
    as constants;

class LoginUseCase {
  AuthRepository repository = getIt<AuthRepository>();
  SharedPreferences prefs = getIt<SharedPreferences>();

  Future<bool> doLogin(String email, String password) async {
    BaseResponse response =
        await repository.login(LoginRequest(email: email, password: password));

    if (response.statusCode != HttpConstant.OK) {
      return Future.error(response.message);
    }

    await prefs.setBool(constants.isLoggedIn, true);
    return true;
  }
}
