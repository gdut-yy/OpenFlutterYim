import 'package:flutter/material.dart';
import 'package:flutter_yim/module_novel/home/home_model.dart';
import 'package:flutter_yim/module_novel/home/home_novel_cover_view.dart';
import 'package:flutter_yim/module_novel/home/home_section_view.dart';

/// 书籍布局样式 1
/// 4 + 4 布局
/// 2019-03-27
class NovelFourGridView extends StatelessWidget {
  final HomeModule cardInfo;

  NovelFourGridView(this.cardInfo);

  @override
  Widget build(BuildContext context) {
    var novels = cardInfo.books;
    if (novels.length < 8) {
      return Container();
    }
    var children = novels.map((novel) => HomeNovelCoverView(novel)).toList();
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          HomeSectionView(cardInfo.name),
          Container(
            padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
            child: Wrap(spacing: 15, runSpacing: 20, children: children),
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
