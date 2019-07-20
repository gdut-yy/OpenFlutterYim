import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:share/share.dart';

import 'package:flutter_yim/module_douban/public.dart';
import 'package:webview_flutter/webview_flutter.dart';

/// WebView 页面
/// 2019-05-21
class WebViewScene extends StatefulWidget {
  final String url;
  final String title;

  WebViewScene({@required this.url, this.title});

  _WebViewSceneState createState() => _WebViewSceneState();
}

class _WebViewSceneState extends State<WebViewScene> {
  @override
  void deactivate() {
    print('webview deactivate');
    super.deactivate();
  }

  @override
  void dispose() {
    Screen.updateStatusBarStyle(SystemUiOverlayStyle.light);
    print('webview dispose');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
//    return WebviewScaffold(
//      url: this.widget.url,
//      appBar: AppBar(
//        elevation: 0,
//        title: Text(this.widget.title ?? ''),
//        leading: GestureDetector(
//          onTap: back,
//          child: Image.asset('images/icon_arrow_back_black.png'),
//        ),
//        actions: <Widget>[
//          GestureDetector(
//            onTap: () {
//              Share.share(this.widget.url);
//            },
//            child: Image.asset('images/icon_menu_share.png'),
//          ),
//        ],
//      ),
//      withZoom: true,
//      withLocalStorage: true,
//      hidden: true,
//      initialChild: Container(
//        child: const Center(child: CupertinoActivityIndicator()),
//      ),
//    );
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(this.widget.title ?? ''),
        leading: GestureDetector(
          onTap: back,
          child: Image.asset('assets/mod_douban/img/icon_arrow_back_black.png'),
        ),
        actions: <Widget>[
          GestureDetector(
            onTap: () {
              Share.share(this.widget.url);
            },
            child: Image.asset('assets/mod_douban/img/icon_menu_share.png'),
          ),
        ],
      ),
      body: new WebView(
        key: GlobalKey(),
        initialUrl: this.widget.url,
      ),
    );
  }

  // 返回上个页面
  back() {
    Navigator.pop(context);
  }
}
