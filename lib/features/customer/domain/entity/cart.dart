class Cart {
  String menuId;
  String desc;
  int quantity;

  Cart({
    required this.menuId,
    required this.desc,
    required this.quantity,
  });

  Map<String, dynamic> toJson() => {
        "menu_id": menuId,
        "desc": desc,
        "quantity": quantity,
      };
}
