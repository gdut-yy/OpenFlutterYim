import 'package:dio/dio.dart';

/// 网络请求工具类
BaseOptions options = BaseOptions(headers: {
  "Content-Type": "application/json",
  "Accept": "application/json",
});

class HttpUtil {
  // get
  static Future get(String url, Map<String, dynamic> params) async {
    Response response = await Dio(options).get(url, queryParameters: params);
    return response;
  }

  // post
  static Future post(String url, Map<String, dynamic> params) async {
    Response response = await Dio(options).post(url, data: params);
    return response;
  }
}
