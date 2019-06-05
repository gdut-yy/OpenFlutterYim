import 'package:flutter/material.dart';
import 'package:flutter_boost/flutter_boost.dart';
import 'package:flutter_yim/main.dart';
import 'package:flutter_yim/module_wx/common/data_model.dart';
import 'package:flutter_yim/module_wx/pages/sub_chat_page.dart';
import 'package:flutter_yim/module_wx/values/colors.dart';
import 'package:flutter_yim/module_wx/values/styles.dart';
import 'package:web_socket_channel/io.dart';

/// 聊天页面
/// 2019-03-16
class ChatPage extends StatefulWidget {
  @override
  ChatPageState createState() => new ChatPageState();
}

class ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// 构造 ListView
      body: ListView.builder(

          /// 传入数据长度
          itemCount: MyAppState.dataList.length,

          /// 构造列表项
          itemBuilder: (BuildContext context, int index) {
            return new ChatItem(MyAppState.dataList[index]);
          }),
    );
  }
}

/// 单个 Item
class ChatItem extends StatelessWidget {
  final DataModel message;

  ChatItem(this.message);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: YimColor.itemsNormalBackground,
        // 仅加一个底部边 这样整个列表的每项信息下面都会有一条边
        border:
            Border(bottom: BorderSide(width: 0.5, color: YimColor.itemsLine)),
      ),
      // 单个 item 高度
      height: 64.0,

      /// 响应点击事件
      child: TouchCallBack(
        onPressed: () {
          if (message.name == 'kolzb001') {
            FlutterBoost.singleton.openPage("sample://nativeChatTo1Page", {});
          } else if (message.name == 'kolzb002') {
            FlutterBoost.singleton.openPage("sample://nativeChatTo2Page", {});
          } else {
            Navigator.of(context).push(
              new MaterialPageRoute(
                builder: (context) => new SubChatPage(
                      title: message.name,
                      channel: new IOWebSocketChannel.connect(
                          'ws://echo.websocket.org'),
                    ),
              ),
            );
          }
        },
        // 整体水平方向布局
        child: Row(
          // 垂直方向居中显示
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            /// 头像
            Container(
              margin: const EdgeInsets.only(left: 12.0, right: 12.0),
              child: Image.asset(
                message.avatarUrl,
                width: 48.0,
                height: 48.0,
              ),
            ),

            /// 昵称和消息
            Expanded(
              // 垂直布局
              child: Column(
                // 垂直方向居中对齐
                mainAxisAlignment: MainAxisAlignment.center,
                // 水平方向靠左对齐
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    message.name,
                    style:
                        TextStyle(fontSize: 16.0, color: YimColor.itemsTitle),
                    maxLines: 1,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                  ),
                  Text(
                    message.msg,
                    style: TextStyle(
                        fontSize: 14.0, color: YimColor.itemsSubTitle),
                    maxLines: 1,
                    // 显示不完的文本用省略号来表示
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),

            /// 时间
            Container(
              // 顶部对齐
              alignment: AlignmentDirectional.topStart,
              margin: const EdgeInsets.only(right: 12.0, top: 12.0),
              child: Text(
                // 格式化时间
                '03:59:59',
                style: TextStyle(fontSize: 14.0, color: YimColor.itemsTime),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
