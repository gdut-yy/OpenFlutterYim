import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter_yim/module_douban/public.dart';

import 'home_list_view.dart';

/// Yim豆瓣入口
/// 2019-05-20
class ModDoubanPage extends StatefulWidget {
  final Widget child;

  ModDoubanPage({Key key, this.child}) : super(key: key);

  _ModDoubanPageState createState() => _ModDoubanPageState();
}

class _ModDoubanPageState extends State<ModDoubanPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          brightness: Brightness.light,
          title: Text('Yim电影'),
          backgroundColor: AppColor.white,
          //  app bar 阴影
          elevation: 0,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () =>
                  showSearch(context: context, delegate: SearchBarDelegate()),
            ),
          ],
        ),
        body: HomeListView());
  }
}
