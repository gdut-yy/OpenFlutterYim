import 'package:flutter/material.dart';
import 'package:flutter_yim/module_novel/app/request.dart';
import 'package:flutter_yim/module_novel/home/home_banner.dart';
import 'package:flutter_yim/module_novel/home/home_menu.dart';
import 'package:flutter_yim/module_novel/home/home_model.dart';
import 'package:flutter_yim/module_novel/home/novel_first_hybird_card.dart';
import 'package:flutter_yim/module_novel/home/novel_four_grid_view.dart';
import 'package:flutter_yim/module_novel/home/novel_normal_card.dart';
import 'package:flutter_yim/module_novel/home/novel_second_hybird_card.dart';
import 'package:flutter_yim/module_novel/utility/toast.dart';

/// 'Yim读书' 单个页面
/// 2019-03-27
enum HomeListType {
  /// 精选
  excellent,

  /// 男生
  male,

  /// 女生
  female,

  /// 漫画
  cartoon,
}

class HomeListView extends StatefulWidget {
  final HomeListType type;

  HomeListView(this.type);

  @override
  State<StatefulWidget> createState() {
    return HomeListViewState();
  }
}

class HomeListViewState extends State<HomeListView>
    with AutomaticKeepAliveClientMixin {
  List<CarouselInfo> carouselInfos = [];
  int pageIndex = 1;
  List<HomeModule> modules = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  bool get wantKeepAlive => true;

  /// 根据选择加载获取相应的 json
  Future<void> fetchData() async {
    try {
      var action;
      switch (this.widget.type) {
        case HomeListType.excellent:
          action = 'home_excellent';
          break;
        case HomeListType.female:
          action = 'home_female';
          break;
        case HomeListType.male:
          action = 'home_male';
          break;
        case HomeListType.cartoon:
          action = 'home_cartoon';
          break;
        default:
          break;
      }
      var responseJson = await Request.get(action: action);
      List moduleData = responseJson['module'];
      List<HomeModule> modules = [];
      moduleData.forEach((data) {
        modules.add(HomeModule.fromJson(data));
      });

      setState(() {
        this.modules = modules;
        this.carouselInfos = carouselInfos;
      });
    } catch (e) {
      Toast.show(e.toString());
    }
  }

  /// 书籍布局样式
  Widget bookCardWithInfo(HomeModule module) {
    Widget card;
    switch (module.style) {
      case 1:
        card = NovelFourGridView(module);
        break;
      case 2:
        card = NovelSecondHybirdCard(module);
        break;
      case 3:
        card = NovelFirstHybirdCard(module);
        break;
      case 4:
        card = NovelNormalCard(module);
        break;
    }
    return card;
  }

  /// 页面 itemBuilder
  Widget buildModule(BuildContext context, HomeModule module) {
    if (module.carousels != null) {
      return HomeBanner(module.carousels);
    } else if (module.menus != null) {
      return HomeMenu(module.menus);
    } else if (module.books != null) {
      return bookCardWithInfo(module);
    }

    return Container();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: RefreshIndicator(
        onRefresh: fetchData,
        child: ListView.builder(
          itemCount: modules.length,
          itemBuilder: (BuildContext context, int index) {
            return buildModule(context, modules[index]);
          },
        ),
      ),
    );
  }
}
