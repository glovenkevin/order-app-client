import 'package:order_app_client/features/customer/data/request/get_menu_request.dart';
import 'package:order_app_client/features/customer/data/response/get_menu_response.dart';

abstract class MenuRepository {
  Future<GetMenuResponse> getMenues(GetMenuRequest req);
}
