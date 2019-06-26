/// 路由定义
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_yim/module_movie/models/pood/video_model.dart';
import 'package:flutter_yim/module_movie/pages/detail/video_detail_page.dart';

var videoDetailRouteHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  String id = params["id"]?.first;
  String timestamp = params["timestamp"]?.first;
  String thumbnail = params["thumbnail"]?.first;
  String name = params["name"]?.first;
  String latest = params["latest"]?.first;
  String generatedAt = params["generatedAt"]?.first;
  return VideoDetailPage(
      videoItem: VideoModel(
    id: id,
    generatedAt: generatedAt,
    name: name,
    latest: latest,
    thumbnail: thumbnail,
    timestamp: timestamp,
  ));
});

var webviewRouteHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  String title = params["title"]?.first;
  String url = params["url"]?.first;
  return Scaffold(
      appBar: AppBar(
    centerTitle: true,
    title: Text('这是一个 webview 页面'),
  ));
});
