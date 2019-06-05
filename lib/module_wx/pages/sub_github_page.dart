import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

/// GitHub WebView 页面
/// 2019-050-14
class GithubPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("GitHub WebView"),
      ),
      body: new WebView(
        key: GlobalKey(),
        initialUrl: 'https://github.com/gdut-yy',
      ),
    );
  }
}
