import 'package:flutter/material.dart';
import 'package:flutter_yim/module_novel/home/home_model.dart';
import 'package:flutter_yim/module_novel/home/home_section_view.dart';
import 'package:flutter_yim/module_novel/home/novel_cell.dart';
import 'package:flutter_yim/module_novel/home/novel_grid_item.dart';

/// 书籍布局样式 3
/// 1 + 2 + 2 布局
/// 2019-03-27
class NovelFirstHybirdCard extends StatelessWidget {
  final HomeModule cardInfo;

  NovelFirstHybirdCard(this.cardInfo);

  @override
  Widget build(BuildContext context) {
    var novels = cardInfo.books;
    if (novels.length < 3) {
      return Container();
    }

    List<Widget> children = [];
    var bottomNovels = novels.sublist(1);
    bottomNovels.forEach((novel) {
      children.add(NovelGridItem(novel));
    });

    return Container(
      color: Colors.white,
      child: Column(
        children: <Widget>[
          HomeSectionView(cardInfo.name),
          NovelCell(novels[0]),
          Container(
            padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
            child: Wrap(spacing: 15, runSpacing: 15, children: children),
          ),
          Container(
            height: 10,
            color: Color(0xfff5f5f5),
          )
        ],
      ),
    );
  }
}
