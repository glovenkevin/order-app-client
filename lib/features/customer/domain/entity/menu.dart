class Menu {
  String id;
  String name;
  double price;
  int stock;
  String description;
  String imageUrl;

  Menu({
    required this.id,
    required this.name,
    required this.price,
    required this.description,
    required this.imageUrl,
    required this.stock,
  });

  factory Menu.fromJson(Map<String, dynamic> json) {
    return Menu(
      id: json['id'],
      name: json['name'],
      price: json['price'].toDouble(),
      description: json['description'],
      imageUrl: json['image_url'],
      stock: json['stock'].toInt(),
    );
  }
}
