import 'package:flutter/material.dart';
import 'package:flutter_yim/module_novel/app/app_navigator.dart';
import 'package:flutter_yim/module_novel/app/sq_color.dart';
import 'package:flutter_yim/module_novel/model/novel.dart';
import 'package:flutter_yim/module_novel/utility/screen.dart';
import 'package:flutter_yim/module_novel/widget/novel_cover_image.dart';

/// 书籍 item 样式
/// 图片-书名-作者名
/// 2019-03-27
class HomeNovelCoverView extends StatelessWidget {
  final Novel novel;

  HomeNovelCoverView(this.novel);

  @override
  Widget build(BuildContext context) {
    var width = (Screen.width - 15 * 2 - 15 * 3) / 4;
    return GestureDetector(
      onTap: () {
        AppNavigator.pushNovelDetail(context, novel);
      },
      child: Container(
        width: width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            NovelCoverImage(novel.imgUrl, width: width, height: width / 0.75),
            SizedBox(height: 5),
            Text(
              novel.name,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              maxLines: 1,
            ),
            SizedBox(height: 3),
            Text(
              novel.author,
              style: TextStyle(fontSize: 12, color: SQColor.gray),
              maxLines: 1,
            ),
          ],
        ),
      ),
    );
  }
}
