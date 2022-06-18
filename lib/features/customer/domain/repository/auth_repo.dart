import 'package:order_app_client/features/customer/data/request/login_request.dart';
import 'package:order_app_client/features/customer/data/request/register_request.dart';
import 'package:order_app_client/features/customer/data/response/response.dart';

abstract class AuthRepository {
  Future<BaseResponse> login(LoginRequest req);
  Future<BaseResponse> register(RegisterRequest req);
}
