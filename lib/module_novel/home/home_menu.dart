import 'package:flutter/material.dart';
import 'package:flutter_yim/module_novel/app/sq_color.dart';
import 'package:flutter_yim/module_novel/home/home_model.dart';

/// 5 个。分类-榜单-会员-完结-出版
/// 2019-03-23
class HomeMenu extends StatelessWidget {
  final List<MenuInfo> infos;

  HomeMenu(this.infos);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: infos.map((info) => menuItem(info)).toList(),
      ),
    );
  }

  Widget menuItem(MenuInfo info) {
    return Column(
      children: <Widget>[
        Image.asset(info.icon),
        SizedBox(height: 5),
        Text(info.title, style: TextStyle(fontSize: 12, color: SQColor.gray)),
      ],
    );
  }
}
