import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_yim/module_wx/common/data_model.dart';
import 'package:flutter_yim/module_wx/common/az_common.dart';
import 'package:flutter_yim/module_wx/common/index_bar.dart';
import 'package:flutter_yim/module_wx/common/suspension_view.dart';
import 'package:flutter_yim/module_wx/pages/sub_contacts_detail_page.dart';
import 'package:flutter_yim/module_wx/values/colors.dart';
import 'package:flutter_yim/module_wx/values/styles.dart';
import 'package:lpinyin/lpinyin.dart';

/// 联系人页面
/// 2019-03-17
class ContactPage extends StatefulWidget {
  @override
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  List<DataModel> _cityList = List();
  List<String> _indexTagList = List();
  Map<String, int> _suspensionSectionMap = Map();
  ScrollController _scrollController;
  int _suspensionHeight = 40;
  int _itemHeight = 56;
  String _suspensionTag = "";

  bool _isShowIndexBarHint = false;
  String _indexBarHint = "";

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    loadData();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _handleList(List<DataModel> list) {
    if (list == null || list.isEmpty) return;
    for (int i = 0, length = list.length; i < length; i++) {
      String pinyin = PinyinHelper.getPinyinE(list[i].name);
      String tag = pinyin.substring(0, 1).toUpperCase();
      list[i].namePinyin = pinyin;
      if (RegExp("[A-Z]").hasMatch(tag)) {
        list[i].tagIndex = tag;
      } else {
        list[i].tagIndex = "#";
      }
    }
    // 根据 A-Z 排序
    SuspensionUtil.sortListBySuspensionTag(list);
  }

  void _addHotCityList() {
    List<DataModel> hotCityList = List();
    hotCityList.add(DataModel(
        avatarUrl: YimImg.png('ic_xindepengyou'), name: "新的朋友", tagIndex: "★"));
    hotCityList.add(DataModel(
        avatarUrl: YimImg.png('ic_qunliao'), name: "群聊", tagIndex: "★"));
    hotCityList.add(DataModel(
        avatarUrl: YimImg.png('ic_biaoqian'), name: "标签", tagIndex: "★"));
    hotCityList.add(DataModel(
        avatarUrl: YimImg.png('ic_gongzhonghao'), name: "公众号", tagIndex: "★"));
    _cityList.insertAll(0, hotCityList);
  }

  void loadData() async {
    // 加载城市列表
    rootBundle.loadString('assets/mod_wx/wx_mock.json').then((value) {
      Map countyMap = json.decode(value);
      List list = countyMap['data'];
      list.forEach((value) {
        _cityList.add(DataModel(
            avatarUrl: value['avatarUrl'],
            name: value['name'],
            sex: value['sex']));
      });
      _handleList(_cityList);

      // 将热门城市置顶
      _addHotCityList();
      _indexTagList.addAll(SuspensionUtil.getTagIndexList(_cityList));

      SuspensionUtil.setShowSuspensionStatus(_cityList);

      if(mounted){
        setState(() {
          _suspensionTag = _cityList.isEmpty ? "" : _cityList[0].tagIndex;
        });
      }
    });
  }

  void _onIndexBarTouch(IndexBarDetails model) {
    setState(() {
      _indexBarHint = model.tag;
      _isShowIndexBarHint = model.isTouchDown;
      int offset = _suspensionSectionMap[model.tag] - _suspensionHeight;
      if (offset != null) {
        _scrollController.jumpTo(offset.toDouble());
      }
    });
  }

  void _onSusTagChanged(String tag) {
    setState(() {
      _suspensionTag = tag;
    });
  }

  void _onSusSectionInited(Map<String, int> map) => _suspensionSectionMap = map;

  /// 单个列表项
  Widget _buildListItem(int index) {
    DataModel model = _cityList[index];
    return Column(
      children: <Widget>[
        /// Suspension 栏
        Offstage(
          offstage: !(model.isShowSuspension == true),
          child: Container(
            alignment: Alignment.centerLeft,
            height: _suspensionHeight.toDouble(),
            color: YimColor.suspensionBackground,
            padding: const EdgeInsets.only(left: 15.0),
            child: Text(
              model.tagIndex,
              style: TextStyle(
                fontSize: 14.0,
                color: YimColor.suspensionText,
              ),
            ),
          ),
        ),

        /// 头像 备注名
        Container(
          color: YimColor.itemsNormalBackground,
          height: _itemHeight.toDouble(),

          /// 响应点击事件
          child: TouchCallBack(
            onPressed: () {
              print(model.name + "被点击");
              if (model.getSuspensionTag() != '★') {
                Navigator.push(
                  context,
                  new MaterialPageRoute(
                    builder: (context) => new SubDetailPage(dataModel: model),
                  ),
                );
              }
            },
            // 整体水平方向布局
            child: Column(
              children: <Widget>[
                Row(
                  // 垂直方向居中显示
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    /// 头像
                    Container(
                      // 减去线高 1.0
                      height: _itemHeight.toDouble() - 1,
                      margin: const EdgeInsets.only(left: 12.0, right: 12.0),
                      child: Image.asset(
                        model.avatarUrl,
                        width: 40.0,
                        height: 40.0,
                      ),
                    ),

                    /// 昵称
                    Expanded(
                      // 垂直布局
                      child: Column(
                        // 垂直方向居中对齐
                        mainAxisAlignment: MainAxisAlignment.center,
                        // 水平方向靠左对齐
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            model.name,
                            style: TextStyle(
                                fontSize: 16.0, color: YimColor.itemsTitle),
                            maxLines: 1,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                /// 分割线
                YimLines(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: Stack(
            children: <Widget>[
              /// Suspension 栏
              SuspensionView(
                data: _cityList,
                contentWidget: ListView.builder(
                  controller: _scrollController,
                  shrinkWrap: true,
                  itemCount: _cityList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return _buildListItem(index);
                  },
                ),
                suspensionWidget: Container(),
                controller: _scrollController,
                suspensionHeight: _suspensionHeight,
                itemHeight: _itemHeight,
                onSusTagChanged: _onSusTagChanged,
                onSusSectionInited: _onSusSectionInited,
              ),

              /// 侧边导航栏
              Align(
                alignment: Alignment.centerRight,
                child: IndexBar(
                  data: _indexTagList,
                  onTouch: _onIndexBarTouch,
                ),
              ),

              /// 选中字符提示
              Offstage(
                offstage: !_isShowIndexBarHint,
                child: Center(
                  child: Card(
                    // 字符背景颜色
                    color: YimColor.slideBarHintsBackground,
                    child: Container(
                      alignment: Alignment.center,
                      width: 96.0,
                      height: 96.0,
                      child: Text(
                        '$_indexBarHint',
                        style: TextStyle(
                          fontSize: 48.0,
                          // 字符颜色
                          color: YimColor.slideBarHintsText,
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
