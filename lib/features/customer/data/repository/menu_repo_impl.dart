import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:order_app_client/features/customer/data/response/get_menu_response.dart';
import 'package:order_app_client/features/customer/data/request/get_menu_request.dart';
import 'package:order_app_client/features/customer/domain/entity/menu.dart';
import 'package:order_app_client/features/customer/domain/repository/menu_repo.dart';
import 'package:order_app_client/infrastructure/http/http_client.dart';

class MenuRepositoryImpl extends MenuRepository {
  @override
  Future<GetMenuResponse> getMenues(GetMenuRequest req) async {
    String tracestr = 'MenuRepositoryImpl.getMenues';
    try {
      final resp = await API.dio().get('/menu', queryParameters: req.toJson());
      var list = resp.data['data'];
      List<Menu> data = <Menu>[];
      list.forEach((elem) => {data.add(Menu.fromJson(elem))});
      return GetMenuResponse(data: data);
    } on DioError catch (e) {
      log("$tracestr - Error: ${e.toString()}");
      return GetMenuResponse(data: <Menu>[]);
    } on Exception catch (e) {
      log("$tracestr - Error: ${e.toString()}");
      return GetMenuResponse(data: <Menu>[]);
    }
  }
}
