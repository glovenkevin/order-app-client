class GetMenuRequest {
  String? id;
  String? name;
  double? price;
  String? description;
  int? limit = 0;
  int? offset = 0;

  GetMenuRequest({
    this.id,
    this.name,
    this.price,
    this.description,
    this.limit,
    this.offset,
  });

  factory GetMenuRequest.fromJson(Map<String, dynamic> json) => GetMenuRequest(
      id: json['id'],
      name: json['name'],
      price: json['price'],
      description: json['description'],
      limit: json['limit'],
      offset: json['offset']);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['password'] = name;
    data['price'] = price;
    data['description'] = description;
    data['limit'] = limit;
    data['offset'] = offset;
    return data;
  }
}
