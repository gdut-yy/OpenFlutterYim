import 'package:flutter/material.dart';
import 'package:flutter_boost/flutter_boost.dart';
import 'package:flutter_yim/module_wx/common/data_model.dart';
import 'package:flutter_yim/module_wx/pages/sub_chat_page.dart';
import 'package:flutter_yim/module_wx/values/colors.dart';
import 'package:flutter_yim/module_wx/values/styles.dart';
import 'package:web_socket_channel/io.dart';

/// 通讯录 => 详细
/// 2019-03-23
class SubDetailPage extends StatelessWidget {
  final DataModel dataModel;

  SubDetailPage({Key key, @required this.dataModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back_ios, color: Colors.black45),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        backgroundColor: YimColor.detailAppBar,
        elevation: 0,
      ),
      body: new Container(
        color: YimColor.bodyBackground,
        child: new Column(
          children: <Widget>[
            /// 头部
            new Container(
              color: YimColor.itemsNormalBackground,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  /// 头像
                  Container(
                    margin: EdgeInsets.only(left: 15, top: 20.0),
                    child: Image.asset(
                      dataModel.avatarUrl,
                      width: 70.0,
                      height: 70.0,
                    ),
                  ),

                  /// 昵称 & 微信号 & 地区
                  Container(
                    margin: EdgeInsets.only(left: 25, top: 15, bottom: 35),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Text(
                              dataModel.name + " ",
                              style: TextStyle(
                                color: YimColor.detailTitleText,
                                fontSize: 20,
                              ),
                            ),

                            /// 性别
                            dataModel.sex == "male"
                                ? Image.asset(
                                    YimImg.png('wx_male'),
                                    width: 16,
                                    height: 16,
                                  )
                                : Image.asset(
                                    YimImg.png('wx_female'),
                                    width: 16,
                                    height: 16,
                                  ),
                          ],
                        ),
                        Divider(
                          height: 2,
                        ),
                        Text(
                          "昵称：" + dataModel.name,
                          style: TextStyle(
                            color: YimColor.detailSubTitleText,
                            fontSize: 14,
                          ),
                        ),
                        Divider(
                          height: 1,
                        ),
                        Text(
                          "微信号：qq461625996",
                          style: TextStyle(
                            color: YimColor.detailSubTitleText,
                            fontSize: 14,
                          ),
                        ),
                        Divider(
                          height: 1,
                        ),
                        Text(
                          "地区：广东 广州",
                          style: TextStyle(
                            color: YimColor.detailSubTitleText,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              height: 0.5,
              color: YimColor.itemsLine,
            ),

            /// 设置备注和标签
            new Container(
              height: 50,
              color: YimColor.itemsNormalBackground,
              child: TouchCallBack(
                onPressed: () {},
                child: Row(
                  children: <Widget>[
                    /// 文字
                    Expanded(
                      child: Text(
                        "   设置备注和标签",
                        style: TextStyle(
                            fontSize: 16.0, color: YimColor.itemsTitle),
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
            ),
            Divider(
              height: 0.5,
              color: YimColor.itemsLine,
            ),

            /// 朋友圈
            new Container(
              margin: EdgeInsets.only(top: 20),
              height: 50,
              color: YimColor.itemsNormalBackground,
              child: TouchCallBack(
                onPressed: () {},
                child: Row(
                  children: <Widget>[
                    /// 文字
                    Expanded(
                      child: Text(
                        "   朋友圈",
                        style: TextStyle(
                            fontSize: 16.0, color: YimColor.itemsTitle),
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
            ),
            Divider(
              height: 0.5,
              color: YimColor.itemsLine,
            ),

            /// 更多信息
            new Container(
              height: 50,
              color: YimColor.itemsNormalBackground,
              child: TouchCallBack(
                onPressed: () {},
                child: Row(
                  children: <Widget>[
                    /// 文字
                    Expanded(
                      child: Text(
                        "   更多信息",
                        style: TextStyle(
                            fontSize: 16.0, color: YimColor.itemsTitle),
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
            ),
            Divider(
              height: 0.5,
              color: YimColor.itemsLine,
            ),

            /// 发消息按钮
            new Container(
              margin: EdgeInsets.only(top: 20),
              height: 50,
              color: YimColor.itemsNormalBackground,
              child: TouchCallBack(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.asset(
                        YimImg.png('wx_faxiaoxi'),
                        width: 26,
                        height: 26,
                      ),
                      Text(
                        "  发消息",
                        style: TextStyle(
                            color: YimColor.detailButton, fontSize: 17),
                      )
                    ],
                  ),
                  onPressed: () {
                    if (dataModel.name == 'kolzb001') {
                      FlutterBoost.singleton
                          .openPage("sample://nativeChatTo1Page", {});
                    } else if (dataModel.name == 'kolzb002') {
                      FlutterBoost.singleton
                          .openPage("sample://nativeChatTo2Page", {});
                    } else {
                      Navigator.of(context).push(
                        new MaterialPageRoute(
                          builder: (context) => new SubChatPage(
                                title: dataModel.name,
                                channel: new IOWebSocketChannel.connect(
                                    'ws://echo.websocket.org'),
                              ),
                        ),
                      );
                    }
                  }),
            ),
            Divider(
              height: 0.5,
              color: YimColor.itemsLine,
            ),

            /// 音视频通话按钮
            new Container(
              height: 50,
              color: YimColor.itemsNormalBackground,
              child: TouchCallBack(
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.asset(
                        YimImg.png('wx_yinshipintonghua'),
                        width: 26,
                        height: 26,
                      ),
                      Text(
                        "  音视频通话",
                        style: TextStyle(
                            color: YimColor.detailButton, fontSize: 17),
                      )
                    ],
                  ),
                  onPressed: () {}),
            ),
          ],
        ),
      ),
    );
  }
}
