import 'package:order_app_client/features/customer/data/request/get_menu_request.dart';
import 'package:order_app_client/features/customer/domain/entity/menu.dart';
import 'package:order_app_client/features/customer/domain/repository/menu_repo.dart';
import 'package:order_app_client/infrastructure/dependency_injection/injection.dart';

class HomeUseCase {
  MenuRepository repo = getIt<MenuRepository>();

  Future<List<Menu>> getMenues(GetMenuRequest req) async {
    var result = await repo.getMenues(req);
    return result.data;
  }
}
