class Menu {
  String id;
  String name;
  double price;
  String description;
  String imageUrl;
  String createdAt;
  String? updatedAt;

  Menu({
    required this.id,
    required this.name,
    required this.price,
    required this.description,
    required this.imageUrl,
    required this.createdAt,
    this.updatedAt,
  });

  factory Menu.fromJson(Map<String, dynamic> json) {
    return Menu(
      id: json['id'],
      name: json['name'],
      price: json['price'],
      description: json['description'],
      imageUrl: json['image_url'],
      createdAt: json['createdat'],
      updatedAt: json['updatedat'],
    );
  }
}
