import 'package:flutter/material.dart';
import 'package:flutter_yim/module_wx/values/colors.dart';
import 'package:flutter_yim/module_wx/values/styles.dart';

/// 我 => 支付
/// 2019-03-23
class SubPaymentPage extends StatefulWidget {
  @override
  _SubPaymentPageState createState() => new _SubPaymentPageState();
}

class _SubPaymentPageState extends State<SubPaymentPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("支付"),
        backgroundColor: YimColor.bottomBarBackground,
        elevation: 0,
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back_ios, color: Colors.black45),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: new ListView(
        children: <Widget>[
          /// 绿色头部
          new Container(
            margin: EdgeInsets.all(5.0),
            // 圆角
            decoration: new BoxDecoration(
              // 背景色
              color: YimColor.payGreen,
              // 圆角
              borderRadius: new BorderRadius.all(new Radius.circular(12.0)),
            ),
            height: 130.0,
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                /// 收付款
                new Expanded(
                  child: TouchCallBack(
                    child: new Column(
                      children: <Widget>[
                        new Image.asset(
                          YimImg.png('wx_pay_money'),
                          width: 48,
                          height: 48,
                        ),
                        new Text(
                          "收付款",
                          style: TextStyle(
                              color: YimColor.itemsNormalBackground,
                              fontSize: 18.0),
                        ),
                        new Text(""),
                      ],
                      mainAxisAlignment: MainAxisAlignment.center,
                    ),
                    onPressed: () {},
                  ),
                ),

                /// 钱包
                new Expanded(
                  child: new TouchCallBack(
                    child: new Column(
                      children: <Widget>[
                        new Image.asset(
                          YimImg.png('wx_pay_wallet'),
                          width: 48,
                          height: 48,
                        ),
                        new Text(
                          "钱包",
                          style: TextStyle(
                              color: YimColor.itemsNormalBackground,
                              fontSize: 18.0),
                        ),
                        new Text(
                          "￥999,999,999.99",
                          style: TextStyle(
                              color: YimColor.payAmountText, fontSize: 15.0),
                        ),
                      ],
                      mainAxisAlignment: MainAxisAlignment.center,
                    ),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ),

          /// 腾讯服务
          new Container(
            margin: EdgeInsets.all(5.0),
            decoration: new BoxDecoration(
              color: YimColor.itemsNormalBackground,
              // 圆角
              borderRadius: new BorderRadius.all(new Radius.circular(12.0)),
            ),
            child: new Column(
              children: <Widget>[
                /// bar
                new Row(
                  children: <Widget>[
                    new Container(
                      margin: EdgeInsets.all(8.0),
                      child: new Text(
                        "腾讯服务",
                        style: TextStyle(
                            color: YimColor.paySubTitleText, fontSize: 16),
                      ),
                    )
                  ],
                ),

                /// row 1
                new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    YimPayItems(
                      imagePath: YimImg.png('wx_card_repay'),
                      title: "信用卡还款",
                    ),
                    YimPayItems(
                      imagePath: YimImg.png('wx_mobile_top_up'),
                      title: "手机充值",
                    ),
                    YimPayItems(
                      imagePath: YimImg.png('wx_wealth'),
                      title: "理财通",
                    ),
                  ],
                ),

                /// row 2
                new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    YimPayItems(
                      imagePath: YimImg.png('wx_utilities'),
                      title: "生活缴费",
                    ),
                    YimPayItems(
                      imagePath: YimImg.png('wx_qq_coins'),
                      title: "Q币充值",
                    ),
                    YimPayItems(
                      imagePath: YimImg.png('wx_public_services'),
                      title: "城市服务",
                    ),
                  ],
                ),

                /// row 3
                new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    YimPayItems(
                      imagePath: YimImg.png('wx_tencent_charity'),
                      title: "腾讯公益",
                    ),
                    YimPayItems(
                      imagePath: YimImg.png('wx_insurance'),
                      title: "保险服务",
                    ),
                    YimPayItems(
                      imagePath: "",
                      title: "",
                    ),
                  ],
                ),
              ],
            ),
          ),

          /// 第三方服务
          new Container(
            margin: EdgeInsets.all(5.0),
            decoration: new BoxDecoration(
              color: YimColor.itemsNormalBackground,
              // 圆角
              borderRadius: new BorderRadius.all(new Radius.circular(12.0)),
            ),
            child: new Column(
              children: <Widget>[
                /// bar
                new Row(
                  children: <Widget>[
                    new Container(
                      margin: EdgeInsets.all(8.0),
                      child: new Text(
                        "第三方服务",
                        style: TextStyle(
                            color: YimColor.paySubTitleText, fontSize: 16),
                      ),
                    )
                  ],
                ),

                /// row 1
                new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    YimPayItems(
                      imagePath: YimImg.png('wx_rail_flights'),
                      title: "火车票机票",
                    ),
                    YimPayItems(
                      imagePath: YimImg.png('wx_ride_hailing'),
                      title: "滴滴出行",
                    ),
                    YimPayItems(
                      imagePath: YimImg.png('wx_specials'),
                      title: "京东优选",
                    ),
                  ],
                ),

                /// row 2
                new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    YimPayItems(
                      imagePath: YimImg.png('wx_food_delivery'),
                      title: "美团外卖",
                    ),
                    YimPayItems(
                      imagePath: YimImg.png('wx_movie_tickets'),
                      title: "电影演出赛事",
                    ),
                    YimPayItems(
                      imagePath: YimImg.png('wx_local_business'),
                      title: "吃喝玩乐",
                    ),
                  ],
                ),

                /// row 3
                new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    YimPayItems(
                      imagePath: YimImg.png('wx_hotels'),
                      title: "酒店",
                    ),
                    YimPayItems(
                      imagePath: YimImg.png('wx_buy_together'),
                      title: "拼多多",
                    ),
                    YimPayItems(
                      imagePath: YimImg.png('wx_womens_style'),
                      title: "蘑菇街女装",
                    ),
                  ],
                ),

                /// row 4
                new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    YimPayItems(
                      imagePath: YimImg.png('wx_flash_sales'),
                      title: "唯品会特卖",
                    ),
                    YimPayItems(
                      imagePath: YimImg.png('wx_used_goods'),
                      title: "转转二手",
                    ),
                    YimPayItems(
                      imagePath: "",
                      title: "",
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// 支付页面 单个 item
class YimPayItems extends StatelessWidget {
  /// 列表名
  final String title;

  /// 图片路径
  final String imagePath;

  YimPayItems({Key key, @required this.title, this.imagePath})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Expanded(
      child: new TouchCallBack(
          child: Container(
            height: 120.0,
            decoration: new BoxDecoration(
              border: new Border.all(width: 0.5, color: Color(0xFFebebeb)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Image.asset(
                  imagePath,
                  width: 40.0,
                  height: 40.0,
                ),
                new Text(title),
              ],
            ),
          ),
          onPressed: () {
            print(title + "被点击");
          }),
    );
  }
}
