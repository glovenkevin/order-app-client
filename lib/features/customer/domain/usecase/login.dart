import 'package:order_app_client/features/customer/data/request/login_request.dart';
import 'package:order_app_client/features/customer/data/response/base_response.dart';
import 'package:order_app_client/features/customer/domain/repository/auth_repo.dart';
import 'package:order_app_client/infrastructure/dependency_injection/injection.dart';
import 'package:order_app_client/infrastructure/http/constant.dart';
import 'package:order_app_client/infrastructure/lib/constant/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginUseCase {
  AuthRepository repository = getIt<AuthRepository>();
  SharedPreferences prefs = getIt<SharedPreferences>();

  Future<bool> doLogin(String email, String password) async {
    BaseResponse response =
        await repository.login(LoginRequest(email: email, password: password));

    if (response.statusCode != HttpConstant.OK) {
      return Future.error(response.message);
    }

    if (response.data['token'] == "") {
      return Future.error("Fail to get user data!");
    }

    await prefs.setBool(Constants.IS_LOGGED_IN, true);
    await prefs.setString(Constants.USER_ID, response.data['token']);

    return true;
  }
}
