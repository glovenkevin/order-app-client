import 'package:order_app_client/features/customer/domain/entity/menu.dart';

class GetMenuResponse {
  List<Menu> data;

  GetMenuResponse({required this.data});

  factory GetMenuResponse.fromJson(Map<String, dynamic> json) =>
      GetMenuResponse(data: json["data"]);

  Map<String, dynamic> toJson() => {
        "data": data,
      };
}
