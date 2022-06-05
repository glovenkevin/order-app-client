import 'package:order_app_client/features/customer/data/response/response.dart';
import 'package:order_app_client/infrastructure/dependency_injection/injection.dart';

import '../../data/request/login_request.dart';
import '../repository/auth_repo.dart';

class AuthUsecase {
  AuthRepository repository = getIt<AuthRepository>();

  Future<bool> doLogin(String email, String password) async {
    BaseResponse response =
        await repository.login(LoginRequest(email: email, password: password));

    if (response.statusCode != 200) {
      return Future.error(response.message);
    }

    return true;
  }
}
