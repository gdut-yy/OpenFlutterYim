import 'package:flutter/material.dart';
import 'package:flutter_yim/module_wx/pages/tab_chat_page.dart';
import 'package:flutter_yim/module_wx/pages/tab_contact_page.dart';
import 'package:flutter_yim/module_wx/pages/tab_discover_page.dart';
import 'package:flutter_yim/module_wx/pages/tab_me_page.dart';
import 'package:flutter_yim/module_wx/values/colors.dart';
import 'package:flutter_yim/module_wx/values/styles.dart';

/// APP 主页面
/// 2019-03-16
class FlutterAppPage extends StatefulWidget {
  @override
  FlutterAppPageState createState() => FlutterAppPageState();
}

class FlutterAppPageState extends State<FlutterAppPage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(initialIndex: 0, vsync: this, length: 4);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  /// 单个 PopupMenuItem
  _popupMenuItem(String value, String imagePath, String title) {
    return PopupMenuItem<String>(
      value: value,
      child: Row(
        children: <Widget>[
          // icon
          Image.asset(
            imagePath,
            width: 32.0,
            height: 32.0,
          ),
          // text
          Container(
            padding: const EdgeInsets.only(left: 20.0),
            child: Text(
              title,
              style: TextStyle(color: YimColor.popupMenuText),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        /// AppBar
        appBar: AppBar(
          // 背景色
          backgroundColor: YimColor.appBarBackground,
          iconTheme: IconThemeData(color: YimColor.appBarIcon),
          title: Text(
            'FbYim',
            style: TextStyle(color: YimColor.appBarText),
          ),
          // 阴影
          elevation: 0,
          actions: <Widget>[
            new IconButton(
                icon: new Icon(Icons.search),
                onPressed: () {
                  Navigator.pushNamed(context, 'searchPage');
                }),
            new PopupMenuButton<String>(
                icon: new Icon(Icons.add_circle_outline),
                // PopupMenu 出现位置
                offset: Offset(0, 56),
                itemBuilder: (BuildContext context) => <PopupMenuItem<String>>[
                      _popupMenuItem(
                          "1", YimImg.png('wx_pop_faqiqunliao'), "发起群聊"),
                      _popupMenuItem(
                          "2", YimImg.png('wx_pop_tianjiapengyou'), "添加朋友"),
                      _popupMenuItem("3", YimImg.png('wx_pop_saoyisao'), "扫一扫"),
                      _popupMenuItem(
                          "4", YimImg.png('wx_pop_shoufukuan'), "收付款"),
                      _popupMenuItem(
                          "5", YimImg.png('wx_pop_bangzhuyufankui'), "帮助与反馈"),
                    ],
                onSelected: (String action) {
                  switch (action) {
                    case "1":
                      break;
                    case "2":
                      Navigator.pushNamed(context, 'addFriendsPage');
                      break;
                    case "3":
                      break;
                    case "4":
                      break;
                    case "5":
                      break;
                  }
                })
          ],
        ),

        /// body
        body: new TabBarView(controller: _tabController, children: <Widget>[
          new ChatPage(),
          new ContactPage(),
          new DiscoverPage(),
          new MinePage()
        ]),

        /// 底部导航栏
        bottomNavigationBar: new Material(
          // 背景色
          color: YimColor.bottomBarBackground,
          child: new TabBar(
            controller: _tabController,
            // 未选中
            unselectedLabelColor: YimColor.bottomBarNormal,
            unselectedLabelStyle: new TextStyle(fontSize: 14.0),
            // 被选中
            labelColor: YimColor.bottomBarPressed,
            labelStyle: new TextStyle(fontSize: 14.0),
            // 指示器厚度
            indicatorWeight: 0.1,
            tabs: <Tab>[
              new Tab(
                  text: "YIM",
                  icon: new Icon(
                    IconData(0xeb97, fontFamily: "appiconFonts"),
                    size: 21,
                  )),
              new Tab(
                  text: "联系人",
                  icon: new Icon(
                    IconData(0xeb8f, fontFamily: "appiconFonts"),
                    size: 21,
                  )),
              new Tab(
                  text: "发现",
                  icon: new Icon(
                    IconData(0xeba1, fontFamily: "appiconFonts"),
                    size: 21,
                  )),
              new Tab(
                  text: "我",
                  icon: new Icon(
                    IconData(0xeb9e, fontFamily: "appiconFonts"),
                    size: 21,
                  )),
            ],
          ),
        ));
  }
}
