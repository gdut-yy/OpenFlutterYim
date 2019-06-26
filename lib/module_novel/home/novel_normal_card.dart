import 'package:flutter/material.dart';
import 'package:flutter_yim/module_novel/home/home_model.dart';
import 'package:flutter_yim/module_novel/home/home_section_view.dart';
import 'package:flutter_yim/module_novel/home/novel_cell.dart';

/// 书籍布局样式 4
/// 1 + 1 + 1 + 1 布局
/// 2019-03-27
class NovelNormalCard extends StatelessWidget {
  final HomeModule cardInfo;

  NovelNormalCard(this.cardInfo);

  @override
  Widget build(BuildContext context) {
    var novels = cardInfo.books;
    if (novels.length < 3) {
      return null;
    }

    List<Widget> children = [
      HomeSectionView(cardInfo.name),
    ];
    for (var i = 0; i < novels.length; i++) {
      var novel = novels[i];
      children.add(NovelCell(novel));
      children.add(Divider(height: 1));
    }
    children.add(Container(height: 10, color: Color(0xfff5f5f5)));

    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    );
  }
}
