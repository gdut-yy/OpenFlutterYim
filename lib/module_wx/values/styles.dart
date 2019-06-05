/// styles.dart
///
/// FbYim 公用组件抽取
/// 2019-03-18

import 'package:flutter/material.dart';
import 'package:flutter_yim/module_wx/values/colors.dart';
import 'package:flutter_boost/flutter_boost.dart';

/// 发现页面、我页面 列表项
class YimListItem extends StatelessWidget {
  /// 列表名
  final String title;

  /// 图片路径
  final String imagePath;

  /// 图标
  final Icon icon;

  YimListItem({Key key, @required this.title, this.imagePath, this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TouchCallBack(
      onPressed: () {
        // 判断点击的项
        switch (title) {
          case '设置':
            FlutterBoost.singleton.openPage("sample://nativeSettingPage", {});
            break;
          case 'Yim电影':
            Navigator.pushNamed(context, 'moviePage');
            break;
          case 'Yim读书':
            Navigator.pushNamed(context, 'novelPage');
            break;
          case 'Yim音乐':
            Navigator.pushNamed(context, 'musicPage');
            break;
          case '支付':
            Navigator.pushNamed(context, 'walletPage');
            break;
          case '朋友圈':
            Navigator.pushNamed(context, 'momentsPage');
            break;
          default:
            break;
        }
      },

      /// 单个列表
      child: Container(
        // 高度
        height: 50.0,
        child: Row(
          children: <Widget>[
            /// 图标
            Container(
              child: Image.asset(
                imagePath,
                width: 32.0,
                height: 32.0,
              ),
              margin: const EdgeInsets.only(left: 20.0, right: 20.0),
            ),

            /// 文字
            Expanded(
              child: Text(
                title,
                style: TextStyle(fontSize: 16.0, color: YimColor.itemsTitle),
              ),
            ),

            /// 右箭头
            Container(
                margin: const EdgeInsets.only(right: 10.0),
                child: Icon(
                  Icons.navigate_next,
                  color: YimColor.itemsArrow,
                ))
          ],
        ),
      ),
    );
  }
}

/// 发现页面、我页面 的 线
class YimLines extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      // 左边距
      padding: const EdgeInsets.only(left: 72.0),
      child: Divider(
        height: 1.0,
        color: YimColor.itemsLine,
      ),
    );
  }
}

/// 触摸回调组件
class TouchCallBack extends StatefulWidget {
  /// 子组件
  final Widget child;

  /// 回调函数
  final VoidCallback onPressed;

  ///
  final bool isfeed;

  /// 背景色
  final Color background;

  /// 传入参数列表
  TouchCallBack({
    Key key,
    @required this.child,
    @required this.onPressed,
    this.isfeed = true,
    this.background = YimColor.itemsPressedBackground,
  }) : super(key: key);

  @override
  TouchState createState() => TouchState();
}

class TouchState extends State<TouchCallBack> {
  Color color = Colors.transparent;

  @override
  Widget build(BuildContext context) {
    // 返回 GestureDetector 对象
    return GestureDetector(
      // 使用 Container 容器包裹
      child: Container(
        color: color,
        child: widget.child,
      ),
      // onTap 回调
      onTap: widget.onPressed,
      onPanDown: (d) {
        if (widget.isfeed == false) return;
        setState(() {
          color = widget.background;
        });
      },
      onPanCancel: () {
        setState(() {
          color = Colors.transparent;
        });
      },
    );
  }
}

/// 图片资源
class YimImg {
  static String png(String name) {
    return 'assets/mod_wx/wx7/' + name + '.png';
  }
}
