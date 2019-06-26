import 'package:flutter/material.dart';
import 'package:flutter_yim/module_cloud_music/common/dao/FindDao.dart';
import 'package:flutter_yim/module_cloud_music/common/redux/PlayerState.dart';
import 'package:flutter_yim/module_cloud_music/widget/Img.dart';
import 'dart:ui';
import 'package:flutter_yim/module_cloud_music/models/SongDetail.dart';
import 'package:flutter_yim/module_cloud_music/models/Song.dart';
import 'package:flutter_yim/module_cloud_music/widget/NetworkMiddleware.dart';

/// 歌单页面
/// 2019-03-31
class SongDetailPage extends StatefulWidget {
  final String title;
  final int songSheetId;
  final String authorName;
  final String coverPic;

  SongDetailPage(
      {this.title, this.songSheetId, this.authorName, this.coverPic});

  @override
  State<StatefulWidget> createState() => _SongDetailPage();
}

class _SongDetailPage extends State<SongDetailPage> {
  List<Song> list;
  SongDetail info;
  Map describe;
  int count = 1;

  @override
  void initState() {
    super.initState();
  }

  /// 获取数据
  _getSongDetail() async {
    Map data = await FindDao.getSongDetail({"id": widget.songSheetId});
    if (data != null) {
      setState(() {
        list = data["playlist"];
        info = data["info"];
        count = list.length + 1;
      });

      return data;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundBlur(
        Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              title: Text(widget.title),
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
            body: CustomScrollView(
              slivers: _listWidget(),
            )),
        coverPic: widget.coverPic);
  }

  /// 列表
  _listWidget() {
    List<Widget> listWidget = [
      SliverList(
        delegate: SliverChildListDelegate([
          SongDescribe(
              coverPic: widget.coverPic, name: widget.authorName, data: info),
        ]),
      )
    ];

    if (list != null && list.length > 0) {
      listWidget.add(
        SliverList(
          delegate: SliverChildBuilderDelegate((BuildContext context, int idx) {
            Song item = list[idx];
            SongListItem songListItem = SongListItem(
                list: list,
                songName: item.songName,
                songId: item.songId,
                singer: item.singer,
                coverPic: item.coverPic,
                index: idx);

            return Container(
              color: Colors.white,
              child: songListItem,
            );
          }, childCount: list.length),
        ),
      );
    } else {
      listWidget.add(SliverList(
          delegate: SliverChildListDelegate(
              [NetworkMiddleware(reqfun: _getSongDetail)])));
    }

    return listWidget;
  }
}

class BackgroundBlur extends StatelessWidget {
  final Widget child;
  final String coverPic;

  BackgroundBlur(this.child, {this.coverPic});

  @override
  Widget build(BuildContext context) {
//    return StoreBuilder<AppState>(
//      builder: (BuildContext context, Store<AppState> store) {
    return Container(
      child: Stack(
        children: <Widget>[
          Positioned(
            child: ConstrainedBox(
                constraints: BoxConstraints.expand(),
                child: Img(
                  coverPic,
                  fit: BoxFit.cover,
                  noSetReqImgSize: false,
                )),
          ),
          Positioned(
            child: IgnorePointer(
              // ignoring: true,
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                child: Container(
                  color: Colors.black.withOpacity(0.2),
                ),
              ),
            ),
          ),
          child
        ],
      ),
    );
//      },
//    );
  }
}

class SongDescribe extends StatelessWidget {
  final String coverPic;
  final String name;
  final SongDetail data;

  SongDescribe({this.coverPic, this.name, this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 220,
      padding: EdgeInsets.only(left: 20, right: 20, top: 20),
      // color: Colors.grey,
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(bottom: 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  height: 120,
                  width: 120,
                  child: Img(
                    coverPic,
                    radius: 4,
                    noSetReqImgSize: false,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    padding: EdgeInsets.only(left: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          name,
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 20),
                          child: Row(
                            children: <Widget>[
                              Container(
                                width: 26,
                                height: 26,
                                margin: EdgeInsets.only(right: 5),
                                child: Img(
                                  data?.avatarUrl ?? null,
                                  radius: 13,
                                ),
                              ),
                              Text(
                                data?.nickname ?? '',
                                style: TextStyle(
                                    fontSize: 12, color: Colors.white),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          _menu(data)
        ],
      ),
    );
  }

  _menu(SongDetail data) {
    int commentCount = data?.commentCount;
    int shareCount = data?.shareCount;
    return Container(
      child: Flex(
        direction: Axis.horizontal,
        children: <Widget>[
          _menuItem("${commentCount ?? '评论'}", Icons.comment),
          _menuItem("${shareCount ?? '分享'}", Icons.share),
          _menuItem("下载", Icons.arrow_downward),
          _menuItem("多选", Icons.check_box)
        ],
      ),
    );
  }

  _menuItem(String text, IconData icon) {
    return Expanded(
      child: FlatButton(
        onPressed: () {},
        child: Column(
          children: <Widget>[
            Icon(
              icon,
              color: Colors.white,
            ),
            Text(
              text,
              style: TextStyle(color: Colors.white, fontSize: 12),
            )
          ],
        ),
      ),
    );
  }
}

/// 单个歌曲
class SongListItem extends StatefulWidget {
  final List list;
  final String songName;
  final int songId;
  final String singer;
  final int index;
  final String coverPic;

  SongListItem(
      {this.songName,
      this.songId,
      this.singer,
      this.index,
      this.coverPic,
      this.list});

  @override
  State<StatefulWidget> createState() => _SongListItem();
}

class _SongListItem extends State<SongListItem> {
  @override
  Widget build(BuildContext context) {
//    return StoreBuilder<AppState>(
//      builder: (BuildContext context, Store<AppState> store) {
    return InkWell(
      /// 点击触发
      onTap: () {
        PlayerState playerState = new PlayerState();
        playerState.playList = widget.list;
        playerState.playIdx = widget.index - 1;
        playerState.state = PlayActions.play;

//            PlayerState playerState = store.state.playerState;
//            playerState.playList = widget.list;
//            playerState.playIdx = widget.index - 1;
//
//            store.dispatch(PlayActions.play);
        print('==>_SongListItem onTap(){}');
      },
      child: Container(
        padding: EdgeInsets.only(top: 10, bottom: 10),
        decoration: BoxDecoration(
            border:
                Border(bottom: BorderSide(color: Color(0xffefefef), width: 1))),
        child: Row(
          children: <Widget>[
            Container(
              width: 50,
              alignment: Alignment.center,
              child: Text(
                "${widget.index}",
                style: TextStyle(fontSize: 12, color: Color(0xff666666)),
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    widget.songName,
                    style: TextStyle(fontSize: 14),
                  ),
                  Text(
                    widget.singer,
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  // Divider(height: 0,)
                ],
              ),
            ),
            Row(
              children: <Widget>[
                Icon(Icons.play_circle_outline),
                Icon(Icons.more_vert),
              ],
            ),
          ],
        ),
      ),
    );
//      },
//    );
  }
}
