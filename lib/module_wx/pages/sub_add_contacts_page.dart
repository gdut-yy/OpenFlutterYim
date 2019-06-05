import 'package:flutter/material.dart';
import 'package:flutter_yim/module_wx/values/colors.dart';
import 'package:flutter_yim/module_wx/values/styles.dart';

/// PopupMenu => 添加朋友
/// 2019-03-23
class SubAddContactsPage extends StatefulWidget {
  SubAddContactsPage({Key key, this.pageController}) : super(key: key);
  final PageController pageController;

  @override
  _SubAddContactsPageState createState() => new _SubAddContactsPageState();
}

class _SubAddContactsPageState extends State<SubAddContactsPage> {
  Widget searchWrap;

  var _searchController = new TextEditingController();
  var _focusNode = new FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back_ios, color: Colors.black45),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          title: new Text('添加朋友'),
          elevation: 0),
      body: new Container(
          child: new ListView(
        children: <Widget>[
          new Container(
            color: YimColor.itemsNormalBackground,
            padding: new EdgeInsets.all(10.0),
            child: new TextField(
              focusNode: _focusNode,
              decoration: new InputDecoration(
                icon: Icon(Icons.search),
                hintText: '微信号/QQ号/手机号',
                border: InputBorder.none,
              ),
              autofocus: false,
              onSubmitted: (String value) async {
                if (value != null && value != '') {}
              },
              controller: _searchController,
            ),
          ),

          /// 搜索栏
          new Container(
            height: 60.0,
            color: YimColor.bodyBackground,
            alignment: Alignment.center,
            child: new Text('我的 Github: https://github.com/gdut-yy',
                style: new TextStyle(
                    color: Color(0xFF555555), fontWeight: FontWeight.bold)),
          ),
          new Container(
            color: YimColor.itemsNormalBackground,
            child: new TouchCallBack(
                child: new ListTile(
                  leading: Image.asset(
                    YimImg.png('wx_friend_radar'),
                    width: 40.0,
                    height: 40.0,
                  ),
                  title: new Text('雷达加朋友'),
                  subtitle: new Text('添加身边的朋友'),
                ),
                onPressed: () {}),
          ),
          new Divider(height: 2.0, color: Color(0xFFededed)),
          new Container(
            color: YimColor.itemsNormalBackground,
            child: new TouchCallBack(
                child: new ListTile(
                  leading: Image.asset(
                    YimImg.png('wx_join_private_group'),
                    width: 40.0,
                    height: 40.0,
                  ),
                  title: new Text('面对面建群'),
                  subtitle: new Text('与身边的朋友进入同一个群聊'),
                ),
                onPressed: () {}),
          ),
          new Divider(height: 2.0, color: Color(0xFFededed)),
          new Container(
            color: YimColor.itemsNormalBackground,
            child: new TouchCallBack(
                child: new ListTile(
                  leading: Image.asset(
                    YimImg.png('wx_scan'),
                    width: 40.0,
                    height: 40.0,
                  ),
                  title: new Text('扫一扫'),
                  subtitle: new Text('扫描二维码名牌'),
                ),
                onPressed: () {}),
          ),
          new Divider(height: 2.0, color: Color(0xFFededed)),
          new Container(
            color: YimColor.itemsNormalBackground,
            child: new TouchCallBack(
                child: new ListTile(
                  leading: Image.asset(
                    YimImg.png('wx_mobile_contact'),
                    width: 40.0,
                    height: 40.0,
                  ),
                  title: new Text('手机联系人'),
                  subtitle: new Text('添加或邀请通讯录的朋友'),
                ),
                onPressed: () {}),
          ),
          new Divider(height: 2.0, color: Color(0xFFededed)),
          new Container(
            color: YimColor.itemsNormalBackground,
            child: new TouchCallBack(
                child: new ListTile(
                  leading: Image.asset(
                    YimImg.png('wx_official_accounts'),
                    width: 40.0,
                    height: 40.0,
                  ),
                  title: new Text('公众号'),
                  subtitle: new Text('获取更多资讯和服务'),
                ),
                onPressed: () {}),
          ),
          new Divider(height: 2.0, color: Color(0xFFededed)),
          new Container(
            color: YimColor.itemsNormalBackground,
            child: new TouchCallBack(
                child: new ListTile(
                  leading: Image.asset(
                    YimImg.png('wx_wechat_work_contacts'),
                    width: 40.0,
                    height: 40.0,
                  ),
                  title: new Text('企业微信联系人'),
                  subtitle: new Text('通过手机号搜索企业微信用户'),
                ),
                onPressed: () {}),
          ),
        ],
      )),
    );
  }
}
