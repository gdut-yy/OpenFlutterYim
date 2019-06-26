import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

import 'package:flutter_yim/module_cloud_music/widget/Img.dart';
import 'package:flutter_yim/module_cloud_music/models/FindBanner.dart';
import 'package:flutter_yim/module_cloud_music/page/common/WebViewPage.dart';

/// 轮播图 + 四个圈
/// 2019-05-17
class SwiperAndMenu extends StatelessWidget {
  final List<Banners> bannerData;
  final List menus;

  SwiperAndMenu({this.bannerData, this.menus});

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildListDelegate([
        Banner(bannerData),
        Menu(menus),
        Divider(height: 1),
      ]),
    );
  }
}

/// 轮播图
class Banner extends StatelessWidget {
  final List<Banners> data;

  Banner(this.data);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      child: Stack(
        children: <Widget>[_background(), _swiper()],
      ),
    );
  }

  _background() {
    return Positioned(
      // 使用row把背景宽度撑开
      child: Container(
        height: 110,
        child: Row(
          children: <Widget>[
            Expanded(
              child: Container(
                color: Color(0xffdd4137),
              ),
            )
          ],
        ),
      ),
    );
  }

  _swiper() {
    Widget widget;
    if (data != null && data.length > 0) {
      widget = Swiper(
        itemBuilder: (BuildContext context, int index) {
          Banners banner = data[index];
          return InkWell(
            child: Container(
                margin: EdgeInsets.only(left: 8, right: 8),
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      left: 0,
                      top: 0,
                      bottom: 0,
                      right: 0,
                      child: Img(
                        banner.imageUrl,
                        height: 120,
                        radius: 6,
                        fit: BoxFit.fitHeight,
                        color: Color(0xffd6d8da),
                      ),
                    ),
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: Container(
                        padding: EdgeInsets.only(
                            left: 8, right: 8, top: 4, bottom: 4),
                        decoration: BoxDecoration(
                            color: Colors.red.withOpacity(0.8),
                            borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(4),
                              topLeft: Radius.circular(4),
                            )),
                        child: Text(
                          banner.typeTitle,
                          style: TextStyle(color: Colors.white, fontSize: 10),
                        ),
                      ),
                    )
                  ],
                )),
            onTap: () {
              if (banner.url != null) {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (BuildContext context) {
                  return WebViewPage(banner.url);
                }));
              }
            },
          );
        },
        itemCount: data.length,
        pagination: SwiperPagination(),
        scale: 0.99,
        autoplay: true,
      );
    } else {
      widget = Container(
        margin: EdgeInsets.only(left: 8, right: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          color: Color(0xffd6d8da),
        ),
        child: Center(
          child: Img(
            null,
            fit: BoxFit.fitHeight,
          ),
        ),
      );
    }

    return widget;
  }
}

/// 私人FM、每日推荐、歌单、排行榜
class Menu extends StatelessWidget {
  final List<MenuItem> menus;

  Menu(this.menus);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 20, bottom: 12),
      child: Flex(
        direction: Axis.horizontal,
        children: menus.map((item) {
          return Expanded(
            child: Column(
              children: <Widget>[
                InkWell(
                  onTap: () {},
                  child: Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xffdd4137),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 4.0,
                            spreadRadius: 1.0,
                            offset: Offset(1.0, 2.0),
                          ),
                        ]),
                    width: 50,
                    height: 50,
                    child: Icon(
                      item.icon,
                      color: Colors.white,
                    ),
                  ),
                ),
                InkWell(
                  child: Container(
                    padding: EdgeInsets.only(top: 6),
                    child: Text(
                      item.text,
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                  onTap: () {},
                )
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}

/// 单个菜单项
class MenuItem {
  /// 图
  IconData icon;

  /// 文字
  String text;

  MenuItem({this.icon, this.text});
}
