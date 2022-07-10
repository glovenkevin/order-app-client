import 'dart:convert';
import 'dart:developer';

import 'package:firebase_database/firebase_database.dart';
import 'package:order_app_client/features/customer/domain/entity/cart.dart';
import 'package:order_app_client/features/customer/domain/repository/cart_repo.dart';
import 'package:order_app_client/infrastructure/dependency_injection/injection.dart';

class CartRepositoryImpl extends CartRepository {
  final _firebaseDatabase = getIt.get<FirebaseDatabase>();
  final _dbRef = 'users';
  final _childRef = 'carts';

  @override
  Future<List<Cart>> getUserCarts(String userId) async {
    List<Cart> carts = [];
    if (userId == "") {
      return carts;
    }

    DatabaseReference dbReference = _firebaseDatabase.ref('$_dbRef/$userId');
    DataSnapshot snapshot = await dbReference.child(_childRef).get();

    if (snapshot.exists && snapshot.value != null) {
      var values = snapshot.value as List;
      for (var element in values) {
        carts.add(Cart(
            menuId: element['menu_id'],
            desc: element['desc'],
            quantity: element['quantity'] as int));
      }
    }

    return carts;
  }

  @override
  Future<bool> save(String userId, List<Cart> carts) async {
    if (userId == "") {
      return false;
    }

    DatabaseReference dbReference = _firebaseDatabase.ref('$_dbRef/$userId');
    var data = {'carts': jsonDecode(jsonEncode(carts))};

    try {
      await dbReference.set(data);
    } on Exception catch (e) {
      log(e.toString());
      return Future.error(false);
    }

    return true;
  }
}
