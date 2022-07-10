import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:order_app_client/features/customer/data/request/get_menu_request.dart';
import 'package:order_app_client/features/customer/data/response/base_response.dart';
import 'package:order_app_client/features/customer/domain/entity/cart.dart';
import 'package:order_app_client/features/customer/domain/entity/menu.dart';
import 'package:order_app_client/features/customer/domain/repository/menu_repo.dart';
import 'package:order_app_client/infrastructure/dependency_injection/injection.dart';
import 'package:order_app_client/infrastructure/http/constant.dart';
import 'package:order_app_client/infrastructure/lib/constant/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeUseCase {
  final MenuRepository _repo = getIt<MenuRepository>();
  final FirebaseDatabase _firebaseDatabase = getIt<FirebaseDatabase>();
  final SharedPreferences _prefs = getIt<SharedPreferences>();

  Future<List<Menu>> getMenues(GetMenuRequest req) async {
    var result = await _repo.getMenues(req);
    return result.data;
  }

  Future<BaseResponse> addMenuToCarts(Menu menu, int quantity) async {
    String userId = _prefs.getString(Constants.USER_ID) ?? "";
    if (userId.trim() == "") {
      await _prefs.clear();
      return Future.error(BaseResponse(
        message: "Fail to get user data, please login again!",
        statusCode: HttpConstant.UNAUTHORIZED,
      ));
    }

    DatabaseReference dbReference = _firebaseDatabase.ref("users/$userId");
    DataSnapshot snapshot = await dbReference.child("carts").get();
    List<Cart> carts = [];
    bool cartItemIsExist = false;
    if (snapshot.exists && snapshot.value != null) {
      var values = snapshot.value as List;
      for (var element in values) {
        var cart = Cart(
            menuId: element['menu_id'],
            desc: element['desc'],
            quantity: element['quantity'] as int);

        if (cart.menuId == menu.id) {
          cart.quantity = quantity;
          cartItemIsExist = true;
        }

        carts.add(cart);
      }
    }

    if (!cartItemIsExist) {
      carts.add(
          Cart(menuId: menu.id, desc: menu.description, quantity: quantity));
    }

    var data = {'carts': jsonDecode(jsonEncode(carts))};
    await dbReference.set(data);

    return BaseResponse(
      message: "Success add item to cart",
      statusCode: 200,
    );
  }
}
