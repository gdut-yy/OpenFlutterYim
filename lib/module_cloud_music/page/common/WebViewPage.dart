import 'package:flutter/material.dart';

class WebViewPage extends StatefulWidget {
  final String url;
  final AppBar appBar;
  final String title;

  WebViewPage(this.url, {this.appBar, this.title = ""});

  @override
  State<StatefulWidget> createState() {
    return _WebViewPage();
  }
}

class _WebViewPage extends State<WebViewPage> {
  String webviewTitle = "";

  @override
  void initState() {
    super.initState();

    _addListen();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  _addListen() {
    _addOnStateChanged();
  }

  _addOnStateChanged() {}

  @override
  void dispose() {
    super.dispose();
  }
}
