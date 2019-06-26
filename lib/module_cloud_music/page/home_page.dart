import 'package:flutter/material.dart';

import 'find/RecommendPage.dart';

/// 云音乐模块入口
/// 2019-04-01
class ModCloudMusicPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

        appBar: AppBar(
            leading: new IconButton(
              icon: new Icon(Icons.arrow_back_ios, color: Colors.white),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            backgroundColor: Color(0xffdd4137),
            elevation: 0,
            title: new Text(
              "Yim音乐",
              style: TextStyle(color: Colors.white),
            )),

        /// 自定义 TabBarView
        body: RecommendPage());
  }
}
