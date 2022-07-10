import 'package:order_app_client/features/customer/data/repository/firebase/cart_repo_impl.dart';
import 'package:order_app_client/features/customer/data/request/get_menu_request.dart';
import 'package:order_app_client/features/customer/data/response/base_response.dart';
import 'package:order_app_client/features/customer/domain/entity/cart.dart';
import 'package:order_app_client/features/customer/domain/entity/menu.dart';
import 'package:order_app_client/features/customer/domain/repository/cart_repo.dart';
import 'package:order_app_client/features/customer/domain/repository/menu_repo.dart';
import 'package:order_app_client/infrastructure/dependency_injection/injection.dart';
import 'package:order_app_client/infrastructure/http/constant.dart';
import 'package:order_app_client/infrastructure/lib/constant/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeUseCase {
  final MenuRepository _menuRepo = getIt<MenuRepository>();
  final CartRepository _cartRepo = getIt<CartRepositoryImpl>();
  final SharedPreferences _prefs = getIt<SharedPreferences>();

  Future<List<Menu>> getMenues(GetMenuRequest req) async {
    var result = await _menuRepo.getMenues(req);

    String userId = _prefs.getString(Constants.USER_ID) ?? '';
    if (userId != '') {
      var carts = await _cartRepo.getUserCarts(userId);
      Map<String, Menu> mapMenu = {};
      for (var elem in result.data) {
        mapMenu[elem.id] = elem;
      }

      for (var cart in carts) {
        mapMenu[cart.menuId]?.quantity = cart.quantity;
      }
    }

    return result.data;
  }

  Future<BaseResponse> addMenuToCarts(Menu menu, int quantity) async {
    String userId = _prefs.getString(Constants.USER_ID) ?? '';
    if (userId.trim() == '') {
      await _prefs.clear();
      return Future.error(BaseResponse(
        message: 'Fail to get user data, please login again!',
        statusCode: HttpConstant.UNAUTHORIZED,
      ));
    }

    List<Cart> carts = await _cartRepo.getUserCarts(userId);
    bool cartItemIsExist = false;
    for (var cart in carts) {
      if (cart.menuId == menu.id) {
        cart.quantity = quantity;
        cartItemIsExist = true;
      }
    }

    if (!cartItemIsExist) {
      carts.add(
          Cart(menuId: menu.id, desc: menu.description, quantity: quantity));
    }

    bool result = await _cartRepo.save(userId, carts);
    if (!result) {
      return Future.error(BaseResponse(
        message: 'Fail to update cart',
        statusCode: HttpConstant.INTERNAL_SERVER_ERROR,
      ));
    }

    return BaseResponse(
      message: 'Success add item to cart',
      statusCode: 200,
    );
  }
}
