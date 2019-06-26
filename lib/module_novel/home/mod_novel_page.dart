import 'package:flutter/material.dart';
import 'package:flutter_yim/module_novel/app/sq_color.dart';
import 'package:flutter_yim/module_novel/home/home_list_view.dart';

/// Yim读书模块入口
/// 2019-03-26
class ModNovelPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ModNovelPageState();
}

class ModNovelPageState extends State<ModNovelPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back_ios, color: Colors.black45),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          brightness: Brightness.light,
          title: Container(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: TabBar(
              labelColor: SQColor.darkGray,
              labelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              unselectedLabelColor: SQColor.gray,
              indicatorColor: SQColor.secondary,
              indicatorSize: TabBarIndicatorSize.label,
              indicatorWeight: 3,
              indicatorPadding: EdgeInsets.fromLTRB(8, 0, 8, 5),
              tabs: [
                Tab(text: '精选'),
                Tab(text: '女生'),
                Tab(text: '男生'),
                Tab(text: '漫画'),
              ],
            ),
          ),
          backgroundColor: SQColor.white,
          elevation: 0,
        ),
        body: TabBarView(children: [
          HomeListView(HomeListType.excellent),
          HomeListView(HomeListType.female),
          HomeListView(HomeListType.male),
          HomeListView(HomeListType.cartoon),
        ]),
      ),
    );
  }
}
