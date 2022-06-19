import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:order_app_client/features/customer/data/request/login_request.dart';
import 'package:order_app_client/features/customer/data/request/register_request.dart';
import 'package:order_app_client/features/customer/data/response/response.dart';
import 'package:order_app_client/features/customer/domain/repository/auth_repo.dart';
import 'package:order_app_client/infrastructure/http/constant.dart';
import 'package:order_app_client/infrastructure/http/http_client.dart';

class AuthRepositoryImpl extends AuthRepository with ChangeNotifier {
  @override
  Future<BaseResponse> login(LoginRequest req) async {
    String tracestr = 'AuthRepositoryImpl.login';
    try {
      final resp = await API.dio().post('/auth/login', data: req.toJson());
      BaseResponse response = BaseResponse.fromJson(resp.data);
      response.statusCode = resp.statusCode;
      return response;
    } on DioError catch (e) {
      log("$tracestr - Error: ${e.toString()}");
      return BaseResponse(
          statusCode: e.response?.statusCode ?? HttpConstant.BAD_REQUEST,
          status: e.response?.statusMessage ?? 'Internal Server Error',
          message: e.response?.data['message'] ?? 'Fail to login');
    } on Exception catch (e) {
      log("$tracestr - Error: ${e.toString()}");
      return BaseResponse(
          statusCode: HttpConstant.INTERNAL_SERVER_ERROR,
          status: HttpConstant.internalServerError,
          message: 'Fail to login');
    }
  }

  @override
  Future<BaseResponse> register(RegisterRequest req) async {
    String tracestr = 'AuthRepositoryImpl.register';
    try {
      final resp = await API.dio().put('/auth/register', data: req.toJson());
      BaseResponse response = BaseResponse.fromJson(resp.data);
      response.statusCode = resp.statusCode;
      return response;
    } on DioError catch (e) {
      log("$tracestr - Error: ${e.toString()}");
      return BaseResponse(
          statusCode: e.response?.statusCode ?? HttpConstant.BAD_REQUEST,
          status: e.response?.statusMessage ?? 'Internal Server Error',
          message: e.response?.data['message'] ?? 'Internal Server Error');
    } on Exception catch (e) {
      log("$tracestr - Error: ${e.toString()}");
      return BaseResponse(
          statusCode: HttpConstant.INTERNAL_SERVER_ERROR,
          status: HttpConstant.internalServerError,
          message: HttpConstant.internalServerError);
    }
  }
}
