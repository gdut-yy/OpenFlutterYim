import 'package:flutter/material.dart';
import 'package:flutter_yim/module_novel/model/novel.dart';
import 'package:flutter_yim/module_novel/novel_detail/novel_detail_scene.dart';
import 'package:flutter_yim/module_novel/reader/reader_scene.dart';

class AppNavigator {
  static push(BuildContext context, Widget scene) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => scene,
      ),
    );
  }

  static pushNovelDetail(BuildContext context, Novel novel) {
    AppNavigator.push(context, NovelDetailScene(novel.id));
  }

  static pushReader(BuildContext context, int articleId) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return ReaderScene(articleId: articleId);
    }));
  }
}
