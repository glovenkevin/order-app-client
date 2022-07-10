import 'package:order_app_client/features/customer/domain/entity/cart.dart';

abstract class CartRepository {
  Future<List<Cart>> getUserCarts(String userId);
  Future<bool> save(String userId, List<Cart> carts);
}
