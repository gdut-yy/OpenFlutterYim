import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_yim/module_movie/route/route_handlers.dart';

/// 路由配置
/// 2019-04-01
class Routes {
  static String root = "/";
  static String webview = "/webview";
  static String themeList = "/themeList";
  static String videoDetail = "/videoDetail";

  static void configureRoutes(Router router) {
    router.define(webview, handler: webviewRouteHandler);
    router.define(videoDetail, handler: videoDetailRouteHandler);

    router.notFoundHandler = Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      print("ROUTE WAS NOT FOUND !!!");
    });
  }
}
