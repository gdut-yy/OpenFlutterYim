import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:flutter_yim/module_cloud_music/common/redux/AppState.dart';
import 'package:flutter_yim/module_cloud_music/models/Song.dart';
import 'package:flutter_yim/module_cloud_music/common/redux/PlayerState.dart';

class BottomSheetPlayList {
  static show(context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return StoreBuilder<AppState>(
          builder: (BuildContext context, Store<AppState> store) {
            List<Song> list = store.state.playerState.playList;

            return Container(
              height: 395,
              child: Flex(
                direction: Axis.vertical,
                children: <Widget>[
                  _title(list),
                  Divider(
                    height: 1,
                  ),
                  Expanded(
                    child: list.length > 0 ? _list(store) : _nodata(),
                  )
                ],
              ),
            );
          },
        );
      },
    );
  }

  static _nodata() {
    return Center(
      child: Text(
        '暂无歌曲',
        style: TextStyle(color: Color(0xff666666)),
      ),
    );
  }

  static _title(List<Song> list) {
    return Container(
      height: 48,
      child: Container(
        padding: EdgeInsets.only(left: 8),
        child: Flex(
          direction: Axis.horizontal,
          children: <Widget>[
            Expanded(
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.loop,
                    size: 18,
                    color: Colors.black54,
                  ),
                  Text(
                    '列表循环(${list.length})',
                    style: TextStyle(color: Color(0xff333333)),
                  ),
                ],
              ),
            ),
            Row(
              children: <Widget>[
                FlatButton(
                  padding: EdgeInsets.all(0),
                  onPressed: () {},
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.folder_open,
                        color: Colors.black54,
                        size: 18,
                      ),
                      Text(
                        '收藏全部',
                        style: TextStyle(color: Color(0xff333333)),
                      )
                    ],
                  ),
                ),
                Container(
                  height: 20,
                  margin: EdgeInsets.only(left: 8),
                  decoration: BoxDecoration(
                      border:
                          Border(left: BorderSide(color: Color(0xffe7e7e7)))),
                  child: IconButton(
                    padding: EdgeInsets.all(0),
                    icon: Icon(
                      Icons.delete_outline,
                      color: Colors.black54,
                      size: 20,
                    ),
                    onPressed: () {},
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  static _list(Store<AppState> store) {
    List<Song> list = store.state.playerState.playList;

    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (BuildContext context, int idx) {
        return InkWell(
          onTap: () {
            store.state.playerState.playIdx = idx;
            store.dispatch(PlayActions.play);
            Navigator.of(context).pop();
          },
          child: Container(
            padding: EdgeInsets.only(left: 6, right: 6),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  height: 44,
                  child: Flex(
                    direction: Axis.horizontal,
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.only(right: 10),
                          child: Text(
                            list[idx].songName,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Color(0xff333333),
                            ),
                          ),
                        ),
                      ),
                      Wrap(
                        children: <Widget>[
                          Icon(Icons.close, color: Color(0xffa7a7a7)),
                        ],
                      )
                    ],
                  ),
                ),
                Divider(height: 1)
              ],
            ),
          ),
        );
      },
    );
  }
}
