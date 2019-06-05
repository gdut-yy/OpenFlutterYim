import 'package:flutter/material.dart';
import 'package:flutter_yim/module_wx/values/colors.dart';
import 'package:flutter_yim/module_wx/values/styles.dart';

/// 发现页面
/// 2019-03-16
class DiscoverPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          /// 朋友圈
          Container(
            color: YimColor.itemsNormalBackground,
            child: YimListItem(
              title: '朋友圈',
              imagePath: YimImg.png('wx_pengyouquan'),
            ),
          ),

          /// 扫一扫 & 摇一摇
          Container(
              margin: const EdgeInsets.only(top: 10.0),
              color: YimColor.itemsNormalBackground,
              child: Column(children: <Widget>[
                YimListItem(
                  imagePath: YimImg.png('wx_saoyisao'),
                  title: '扫一扫',
                ),
                YimLines(),
                YimListItem(
                  imagePath: YimImg.png('wx_yaoyiyao'),
                  title: '摇一摇',
                )
              ])),

          /// 看一看 & 搜一搜
          Container(
              margin: const EdgeInsets.only(top: 10.0),
              color: YimColor.itemsNormalBackground,
              child: Column(children: <Widget>[
                YimListItem(
                  imagePath: YimImg.png('wx_kanyikan'),
                  title: '看一看',
                ),
                YimLines(),
                YimListItem(
                  imagePath: YimImg.png('wx_souyisou'),
                  title: '搜一搜',
                )
              ])),

          /// 附件的人 & 漂流瓶 & 附件的餐厅
          Container(
              margin: const EdgeInsets.only(top: 10.0),
              color: YimColor.itemsNormalBackground,
              child: Column(children: <Widget>[
                YimListItem(
                  imagePath: YimImg.png('wx_fujinderen'),
                  title: 'Yim电影',
                ),
                YimLines(),
                YimListItem(
                  imagePath: YimImg.png('wx_piaoliuping'),
                  title: 'Yim读书',
                ),
                YimLines(),
                YimListItem(
                  imagePath: YimImg.png('wx_fujindecanting'),
                  title: 'Yim音乐',
                ),
              ])),

          /// 购物 & 游戏
          Container(
            margin: const EdgeInsets.only(top: 10.0),
            color: YimColor.itemsNormalBackground,
            child: Column(
              children: <Widget>[
                YimListItem(
                  imagePath: YimImg.png('wx_gouwu'),
                  title: '购物',
                ),
                YimLines(),
                YimListItem(
                  imagePath: YimImg.png('wx_youxi'),
                  title: '游戏',
                )
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 10.0),
            color: YimColor.itemsNormalBackground,
            child: YimListItem(
              imagePath: YimImg.png('wx_xiaochengxu'),
              title: '小程序',
            ),
          )
        ],
      ),
    );
  }
}
