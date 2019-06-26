import 'package:flutter/material.dart';
import 'package:flutter_yim/module_novel/app/sq_color.dart';

import 'chapter.dart';

/// 'm_s_style' 不为 null json 解析
/// 2019-03-27
class Novel {
  /// 'bid'
  String id;

  /// 'bookname'
  String name;

  /// 'book_cover'
  String imgUrl;

  /// 'topic_first'
  String firstChapter;

  /// 'lastChapter'
  Chapter lastChapter;

  /// 'author_name'
  String author;

  /// 'price'
  double price;

  /// 'score'
  double score;

  /// 'class_name'
  String type;

  /// 'introduction'
  String introduction;

  /// 'chapterNum'
  int chapterCount;

  /// 'recommend_num'
  int recommendCount;

  /// 'comment_count'
  int commentCount;

  /// 'first_article_id'
  int firstArticleId;

  List<String> roles;

  /// 'stat_name'
  String status;

  /// 'wordCount'
  double wordCount;

  /// 'tag'
  List<String> tags;

  /// 'is_free'
  bool isLimitedFree;

  Novel.fromJson(Map data) {
    id = data['bid'];
    firstArticleId = data['first_article_id'];
    name = data['bookname'];
    imgUrl = data['book_cover'];
    firstChapter = data['topic_first'];
    if (data['lastChapter'] != null) {
      lastChapter = Chapter.fromJson(data['lastChapter']);
    }
    score = data['score'];
    author = data['author_name'];
    price = double.parse(data['price'] ?? '0');
    type = data['class_name'];
    introduction = data['introduction'];
    chapterCount = int.parse(data['chapterNum'] ?? '0');
    recommendCount = int.parse(data['recommend_num'] ?? '0');
    commentCount = int.parse(data['comment_count'] ?? '0');

    status = data['stat_name'];
    wordCount = data['wordCount'];
    tags = data['tag']?.cast<String>()?.toList();

    isLimitedFree = data['is_free'] == 1;
  }

  String recommendCountStr() {
    if (recommendCount >= 10000) {
      return (recommendCount / 10000).toStringAsFixed(1) + '万人推荐';
    } else {
      return recommendCount.toString() + '人推荐';
    }
  }

  Color statusColor() {
    return status == '连载' ? SQColor.blue : SQColor.primary;
  }
}
