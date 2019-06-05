import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_yim/module_wx/values/colors.dart';
import 'package:flutter_yim/module_wx/values/styles.dart';
import 'package:image_picker/image_picker.dart';

/// 发现 => 朋友圈
/// 2019-03-23
class SubMomentsPage extends StatefulWidget {
  @override
  _SubMomentsPageState createState() => new _SubMomentsPageState();
}

class _SubMomentsPageState extends State<SubMomentsPage> {
  var textController = new TextEditingController();
  var fsNode = new FocusNode();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back_ios, color: Colors.black45),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          elevation: 0.0,
          backgroundColor: Colors.white,
          actions: <Widget>[
            FlatButton(
              child: new Text('发表',
                  style: new TextStyle(
                      color: new Color(0xFF64c223),
                      fontWeight: FontWeight.bold)),
              onPressed: () {
                print('发表文字');
              },
            )
          ],
        ),
        body: new Container(
          color: YimColor.itemsNormalBackground,
          child: ListView(
            children: <Widget>[
              new Container(
                padding: new EdgeInsets.all(10.0),
                width: MediaQuery.of(context).size.width,
                child: new TextField(
                  focusNode: fsNode,
                  controller: textController,
                  decoration: new InputDecoration(
                      hintText: '这一刻的想法...', border: InputBorder.none),
                  keyboardType: TextInputType.text,
                  maxLines: 6,
                  onSubmitted: (value) {
                    fsNode.unfocus();
                  },
                ),
              ),

              /// 选择图片控件
              new SelectPhoto(),
              new TouchCallBack(
                child: ListTile(
                  leading: Image.asset(
                    YimImg.png('wx_suozaiweizhi'),
                    width: 24.0,
                    height: 24.0,
                  ),
                  title: new Text('所在位置'),
                  trailing: Icon(
                    Icons.navigate_next,
                    color: YimColor.itemsArrow,
                  ),
                ),
                onPressed: () {},
              ),
              new Divider(height: 2.0, color: Color(0xFFededed)),
              new TouchCallBack(
                child: new ListTile(
                  leading: Image.asset(
                    YimImg.png('wx_shuikeyikan'),
                    width: 24.0,
                    height: 24.0,
                  ),
                  title: new Text('谁可以看'),
                  trailing: Icon(
                    Icons.navigate_next,
                    color: YimColor.itemsArrow,
                  ),
                ),
                onPressed: () {},
              ),
              new Divider(height: 2.0, color: Color(0xFFededed)),
              new TouchCallBack(
                child: ListTile(
                  leading: Image.asset(
                    YimImg.png('wx_tixingshuikan'),
                    width: 24.0,
                    height: 24.0,
                  ),
                  title: new Text('提醒谁看'),
                  trailing: Icon(
                    Icons.navigate_next,
                    color: YimColor.itemsArrow,
                  ),
                ),
                onPressed: () {},
              ),
              new Divider(height: 2.0, color: Color(0xFFededed)),
              new ListTile(
                leading: Image.asset(
                  YimImg.png('wx_qzone'),
                  width: 32.0,
                  height: 32.0,
                ),
                title: new Text(''),
              ),
            ],
          ),
        ));
  }
}

class SelectPhoto extends StatefulWidget {
  @override
  SelectPhotoState createState() => new SelectPhotoState();
}

class SelectPhotoState extends State<SelectPhoto> {
  List photoList = [];
  Widget selectPhotoWidget;

  getWrapList() {
    var width = (MediaQuery.of(context).size.width - 40) / 3;

    List warpList = <Widget>[];
    for (var i = 0; i < photoList.length; i++) {
      if (photoList.length <= 9) {
        warpList.add(new GestureDetector(
          child: new Container(
              width: width,
              height: width,
              decoration: new BoxDecoration(
                color: Color(0xFFededed),
              ),
              child: new Center(
                child: photoList[i],
              )),
          onTap: () {
            photoList.removeAt(i);
            getWrapList();
          },
        ));
      } else {
        return;
      }
    }
    if (photoList.length != 9 || photoList.length == 0) {
      warpList.add(new GestureDetector(
        child: new Container(
            width: width,
            height: width,
            decoration: new BoxDecoration(
              color: Color(0xFFcccccc),
            ),
            child: new Center(
              child: new Icon(Icons.add, size: 50.0),
            )),
        onTap: () {
          openImage();
        },
      ));
    }

    selectPhotoWidget = Builder(
      builder: (context) {
        return Wrap(
            alignment: WrapAlignment.start,
            spacing: 10.0,
            runSpacing: 10.0,
            children: warpList);
      },
    );

    setState(() {
      selectPhotoWidget = selectPhotoWidget;
    });
  }

  Future openImage() async {
    File image;
    image = await ImagePicker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      getWrapList();
    }
  }

  Widget build(BuildContext context) {
    getWrapList();
    return new Container(
        padding: EdgeInsets.all(10.0),
        width: MediaQuery.of(context).size.width,
        child: selectPhotoWidget);
  }
}
