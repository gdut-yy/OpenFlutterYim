import 'package:flutter/material.dart';
import 'package:flutter_yim/module_wx/values/colors.dart';
import 'package:flutter_yim/module_wx/values/styles.dart';

/// 我页面
/// 2019-03-16
class MinePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          /// 头部
          Container(
            color: YimColor.itemsNormalBackground,
            height: 80.0,
            child: TouchCallBack(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  /// 头像
                  Container(
                    margin: const EdgeInsets.only(
                        left: 12.0, top: 10, right: 15.0, bottom: 10),
                    child: Image.asset(
                      'assets/mod_wx/gdut_yy.jpg',
                      width: 70.0,
                      height: 70.0,
                    ),
                  ),

                  /// 用户名、帐号
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          '张逸扬',
                          style: TextStyle(
                            fontSize: 18.0,
                            color: YimColor.itemsTitle,
                          ),
                        ),
                        Text(
                          'GitHub：https://github.com/gdut-yy',
                          style: TextStyle(
                            fontSize: 14.0,
                            color: YimColor.itemsSubTitle,
                          ),
                        ),
                      ],
                    ),
                  ),

                  /// 二维码图标
                  Container(
                    margin: const EdgeInsets.only(left: 12.0, right: 15.0),
                    child: Image.asset(
                      YimImg.png('wx_qrcode'),
                      width: 16.0,
                      height: 16.0,
                    ),
                  ),
                ],
              ),
              onPressed: () {
                // 使用 Webview 打开
                Navigator.pushNamed(context, '/github');
              },
            ),
          ),

          /// 以下是列表项
          Container(
            margin: const EdgeInsets.only(top: 10.0),
            color: YimColor.itemsNormalBackground,

            /// 列表项-支付
            child: YimListItem(
              title: '支付',
              imagePath: YimImg.png('wx_zhifu'),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 10.0),
            color: YimColor.itemsNormalBackground,
            child: Column(
              children: <Widget>[
                /// 列表项-收藏
                YimListItem(
                  imagePath: YimImg.png('wx_shoucang'),
                  title: '收藏',
                ),
                YimLines(),

                /// 列表项-相册
                YimListItem(
                  imagePath: YimImg.png('wx_xiangce'),
                  title: '相册',
                ),
                YimLines(),

                /// 列表项-卡包
                YimListItem(
                  imagePath: YimImg.png('wx_kabao'),
                  title: '卡包',
                ),
                YimLines(),

                /// 列表项-表情
                YimListItem(
                  imagePath: YimImg.png('wx_biaoqing'),
                  title: '表情',
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 10.0),
            color: YimColor.itemsNormalBackground,

            /// 列表项-设置
            child: YimListItem(
              title: '设置',
              imagePath: YimImg.png('wx_shezhi'),
            ),
          ),
        ],
      ),
    );
  }
}
