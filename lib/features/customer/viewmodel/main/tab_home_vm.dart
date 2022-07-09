import 'package:flutter/material.dart';
import 'package:order_app_client/features/customer/data/request/get_menu_request.dart';
import 'package:order_app_client/features/customer/data/response/base_response.dart';
import 'package:order_app_client/features/customer/domain/entity/menu.dart';
import 'package:order_app_client/features/customer/domain/usecase/home.dart';
import 'package:order_app_client/infrastructure/dependency_injection/injection.dart';

class TabHomeViewModel extends ChangeNotifier {
  final HomeUseCase _useCase = getIt<HomeUseCase>();

  int _bannerIndex = 0;
  List<String> _images = [
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQTIZccfNPnqalhrWev-Xo7uBhkor57_rKbkw&usqp=CAU",
    "https://wallpaperaccess.com/full/2637581.jpg"
  ];
  List<Menu> _menus = [];
  final Map<String, int> _carts = {};

  int get bannerIndex => _bannerIndex;
  List<String> get images => _images;
  List<Menu> get menus => _menus;
  Map<String, int> get carts => _carts;

  void setBannerIndex(int index) {
    _bannerIndex = index;
    notifyListeners();
  }

  void setImages(List<String> images) {
    _images = images;
    notifyListeners();
  }

  void setMenus(List<Menu> menus) {
    _menus = menus;
    notifyListeners();
  }

  void setCarts(String key, int quantity) {
    _carts[key] = quantity;
    notifyListeners();
  }

  void incrementCarts(String key) {
    if (_carts[key] != null) {
      var qty = _carts[key]!;
      _carts[key] = qty + 1;
      notifyListeners();
    }
  }

  void decrementCarts(String key) {
    if (_carts[key] != null && _carts[key] != 1) {
      var qty = _carts[key]!;
      _carts[key] = qty - 1;
      notifyListeners();
    }
  }

  Future<void> retrieveMenues() async {
    var menues = await _useCase.getMenues(GetMenuRequest());
    for (var element in menues) {
      {
        _carts[element.id] = 1;
      }
    }
    setMenus(menues);
  }

  Future<BaseResponse> addToCarts(Menu menu) async {
    return await _useCase.addMenuToCarts(menu, _carts[menu.id] ?? 1);
  }
}
