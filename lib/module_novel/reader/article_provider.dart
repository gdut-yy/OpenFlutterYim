import 'package:flutter_yim/module_novel/app/request.dart';
import 'package:flutter_yim/module_novel/model/article.dart';

class ArticleProvider {
  static Future<Article> fetchArticle(int articleId) async {
    var response = await Request.get(action: 'article_$articleId');
    var article = Article.fromJson(response);

    return article;
  }
}
