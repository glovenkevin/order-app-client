import 'package:flutter/material.dart';
import 'package:order_app_client/features/customer/domain/entity/menu.dart';

class TabHomeViewModel extends ChangeNotifier {
  int _bannerIndex = 0;
  List<String> _images = [
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQTIZccfNPnqalhrWev-Xo7uBhkor57_rKbkw&usqp=CAU",
    "https://wallpaperaccess.com/full/2637581.jpg"
  ];
  List<Menu> _menus = <Menu>[
    Menu(
        id: "1",
        name: "ote-ote",
        price: 9000,
        description: "Isi babi dan rmput laut",
        imageUrl: 'https://via.placeholder.com/150',
        createdAt: "2022-0607"),
    Menu(
        id: "2",
        name: "ote-ote",
        price: 7000,
        description: "Isi ayam dan rmput laut",
        imageUrl: 'https://via.placeholder.com/150',
        createdAt: "2022-0607"),
    Menu(
        id: "3",
        name: "ote-ote makasar",
        price: 7000,
        description: "Isi ayam dan rmput laut dan dunia",
        imageUrl: 'https://via.placeholder.com/150',
        createdAt: "2022-0607"),
  ];

  int get bannerIndex => _bannerIndex;
  List<String> get images => _images;
  List<Menu> get menus => _menus;

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
}
