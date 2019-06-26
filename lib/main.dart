import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_boost/flutter_boost.dart';
import 'package:flutter_yim/module_wx/pages/flutter_app_page.dart';
import 'package:flutter_yim/module_wx/pages/sub_add_contacts_page.dart';
import 'package:flutter_yim/module_wx/pages/sub_moments_page.dart';
import 'package:flutter_yim/module_wx/pages/sub_pay_page.dart';
import 'package:flutter_yim/module_wx/pages/sub_search_page.dart';
import 'package:flutter_yim/module_wx/values/colors.dart';

import 'module_cloud_music/page/home_page.dart';
import 'module_movie/pages/movie/mod_movie_page.dart';
import 'module_novel/home/mod_novel_page.dart';
import 'module_wx/common/data_model.dart';
import 'module_wx/pages/sub_github_page.dart';

/// 主入口
/// 2019-03-16
void main() => runApp(App());

class App extends StatefulWidget {
  @override
  MyAppState createState() => MyAppState();
}

/// 集成 阿里 Flutter-Boost 框架
class MyAppState extends State<App> {
  static List<DataModel> dataList = List();

  @override
  void initState() {
    super.initState();

    /// register page widget builders,the key is pageName
    FlutterBoost.singleton.registerPageBuilders({
      'flutterPage': (pageName, params, _) => FlutterAppPage(),
    });

    /// query current top page and load it
    FlutterBoost.handleOnStartPage();

    loadData();
  }

  /// 预加载聊天页面数据
  void loadData() async {
    rootBundle.loadString('assets/mod_wx/wx_mock.json').then((value) {
      Map countyMap = json.decode(value);
      List list = countyMap['data'];
      list.forEach((value) {
        dataList.add(DataModel(
            avatarUrl: value['avatarUrl'],
            name: value['name'],
            msg: value['msg']));
      });
    });
  }

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'FbYim',

        /// 是否显示 DEBUG 条
        debugShowCheckedModeBanner: true,

        /// 定义应用所使用的主体颜色
        theme: mDefaultTheme,

        /// init container manager
        builder: FlutterBoost.init(),
        home: Container(),

        /// 定义应用中页面跳转规则
        routes: routeMap,
      );
}

final ThemeData mDefaultTheme = new ThemeData(
    // PopupMenuItem 颜色
    cardColor: YimColor.popupMenuBackground,
    scaffoldBackgroundColor: YimColor.bodyBackground,
    primaryColor: YimColor.appBarBackground);

/// 静态路由
final routeMap = <String, WidgetBuilder>{
  /// => github webview
  "/github": (BuildContext context) => new GithubPage(),

  /// => 搜索
  'searchPage': (BuildContext context) => new SubSearchPage(),

  /// => 支付
  'walletPage': (BuildContext context) => new SubPaymentPage(),

  /// => 添加朋友
  'addFriendsPage': (BuildContext context) => new SubAddContactsPage(),

  /// => 朋友圈
  'momentsPage': (BuildContext context) => new SubMomentsPage(),

  /// => Yim豆瓣模块入口
  'moviePage': (BuildContext context) => new ModMoviePage(),

  /// => Yim读书模块入口
  'novelPage': (BuildContext context) => new ModNovelPage(),

  /// => Yim云音乐模块入口
  'musicPage': (BuildContext context) => new ModCloudMusicPage(),
};
