import 'package:flutter_yim/module_novel/model/novel.dart';

/// 'module' json 解析
/// 2019-03-27
class HomeModule {
  /// 'id'
  String id;

  /// 'm_s_name'
  String name;

  /// 'm_s_style'
  int style;

  /// 'content'
  List content;

  List<CarouselInfo> carousels;
  List<MenuInfo> menus;
  List<Novel> books;

  HomeModule.fromJson(Map data) {
    id = data['id'];
    name = data['m_s_name'];
    content = data['content'];

    if (name == '顶部banner') {
      carousels = [];
      content.forEach((data) {
        carousels.add(CarouselInfo.fromJson(data));
      });
    }

    if (name == '顶部导航') {
      menus = [];
      content.forEach((data) {
        menus.add(MenuInfo.fromJson(data));
      });
    }

    if (data['m_s_style'] != null) {
      style = data['m_s_style'];
      books = [];
      content.forEach((data) {
        books.add(Novel.fromJson(data));
      });
    }
  }
}

/// '顶部导航' json 解析
class MenuInfo {
  String title;
  String icon;

  MenuInfo.fromJson(Map data) {
    title = data['toTitle'];
    icon = data['icon'];
  }
}

/// '顶部banner' json 解析
class CarouselInfo {
  /// 'image_url'
  String imageUrl;

  /// 'link_url'
  String link;

  CarouselInfo.fromJson(Map data) {
    imageUrl = data['image_url'];
    link = data['link_url'];
  }
}
