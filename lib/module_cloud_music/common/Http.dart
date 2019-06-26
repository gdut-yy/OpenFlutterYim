import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter_yim/module_cloud_music/common/dao/EventDao.dart';

class Http {
  Dio dio;

  Http({bool loading: true}) {
    dio = Dio();
    setConfig();
    setInterceptor(loading: loading);
  }

  request(String path, {Map data, Options options}) async {
    Response request;
    try {
      request = await dio.request(path, data: data, options: options);
    } catch (e) {
      return e;
    }
    return request;
  }

  get(String path, {Map data, Options options}) async {
    dio.clear();
    Response request;
    try {
      request = await dio.get(path, queryParameters: data, options: options);
    } catch (e) {
      rethrow;
    }
    return request;
  }

  static all(List<Future> list, {bool loading = false}) async {
    List results;
    if (loading) Loading.show();

    try {
      results = await Future.wait(list);
    } catch (e) {
      rethrow;
    }

    if (loading) Loading.hide();
    return results;
  }

  setConfig() {
    dio.options.baseUrl = "http://106.13.32.37:3000";
    dio.options.connectTimeout = 3000;
    dio.options.receiveTimeout = 5000;
  }

  setInterceptor({bool loading}) {}
}
