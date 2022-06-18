import 'package:order_app_client/features/customer/data/request/login_request.dart';
import 'package:order_app_client/features/customer/data/response/response.dart';
import 'package:order_app_client/features/customer/domain/repository/auth_repo.dart';
import 'package:order_app_client/infrastructure/dependency_injection/injection.dart';
import 'package:order_app_client/infrastructure/http/constant.dart';

class LoginUseCase {
  AuthRepository repository = getIt<AuthRepository>();

  Future<bool> doLogin(String email, String password) async {
    BaseResponse response =
        await repository.login(LoginRequest(email: email, password: password));

    if (response.statusCode != HttpConstant.OK) {
      return Future.error(response.message);
    }
    return true;
  }
}
