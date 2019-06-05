import 'package:flutter/material.dart';
import 'package:flutter_yim/module_wx/values/colors.dart';
import 'package:flutter_yim/module_wx/values/styles.dart';

/// AppBar => 搜索
/// 2019-03-17
class SubSearchPage extends StatefulWidget {
  @override
  SubSearchPageState createState() => new SubSearchPageState();
}

class SubSearchPageState extends State<SubSearchPage> {
  // 定义焦点节点
  FocusNode focusNode = new FocusNode();

  // 请求获取焦点
  _requestFocus() {
    FocusScope.of(context).requestFocus(focusNode);
    return focusNode;
  }

  /// "搜索指定内容"
  _searchOption(String text) {
    return TouchCallBack(
      isfeed: false,
      onPressed: () {},
      child: Text(
        text,
        style: TextStyle(fontSize: 16.0, color: YimColor.searchOption),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        elevation: 0,
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back_ios, color: Colors.black45),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),

        /// 顶部导航栏。包括返回按钮、搜索框、麦克风按钮
        title: Container(
          alignment: Alignment.centerLeft,
          height: 45.0,

          /// 搜索框底部边框
          decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(width: 2.0, color: YimColor.searchLine)),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                /// 输入框
                child: TextField(
                  // 请求获取焦点
                  focusNode: _requestFocus(),
                  // 输入后的文字样式
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18.0,
                  ),
                  onChanged: (String text) {},
                  decoration:
                      InputDecoration(hintText: '搜索', border: InputBorder.none),
                  // 光标颜色
                  cursorColor: YimColor.bottomBarPressed,
                ),
              ),
            ],
          ),
        ),
      ),
      body: Container(
        // 顶部距离
        margin: const EdgeInsets.only(top: 25.0),
        // 整体垂直布局
        child: Column(
          // 水平方向居中
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            /// 搜索指定内容
            Container(
              margin: const EdgeInsets.only(top: 20.0),
              child: Text(
                '搜索指定内容',
                style: TextStyle(fontSize: 16.0, color: YimColor.searchHints),
              ),
            ),

            /// 第一行搜索项
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Row(
                // 对齐方式采用均匀对齐
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  _searchOption('Android'),
                  _searchOption('iOS'),
                  _searchOption('Fuchsia'),
                ],
              ),
            ),

            /// 第二行搜索项
            Padding(
              padding: const EdgeInsets.only(left: 30.0, right: 30.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  _searchOption('Flutter'),
                  _searchOption('Dart'),
                  _searchOption('Java'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
