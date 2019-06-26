import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:flutter_yim/module_cloud_music/common/redux/AppState.dart';
import 'package:flutter_yim/module_cloud_music/page/common/PlayDetailPage.dart';
import 'package:flutter_yim/module_cloud_music/widget/Img.dart';
import 'package:flutter_yim/module_cloud_music/common/redux/PlayerState.dart';
import 'package:flutter_yim/module_cloud_music/widget/BottomSheetPlayList.dart';
import 'package:flutter_yim/module_cloud_music/models/Song.dart';

class PlayBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreBuilder<AppState>(
      builder: (BuildContext context, Store<AppState> store) {
        PlayerState playerState = store.state.playerState;
        Song info = playerState.getPlayInfo();
        bool playState = PlayActions.play == playerState.state;

        return Container(
          height: 46,
          padding: EdgeInsets.only(left: 6, right: 6),
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border(top: BorderSide(color: Color(0xffeeeeee)))),
          child: Material(
            child: InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => PlayDetailPage()));
              },
              child: Flex(
                direction: Axis.horizontal,
                children: <Widget>[
                  Container(
                    width: 36,
                    height: 36,
                    margin: EdgeInsets.only(right: 10),
                    child: Img(info?.coverPic),
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(bottom: 4),
                          child: Text(
                            info?.songName ?? '',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.black87,
                              decoration: TextDecoration.none,
                            ),
                          ),
                        ),
                        Text(
                          info?.singer ?? '',
                          style: TextStyle(
                              fontSize: 10,
                              color: Colors.black38,
                              decoration: TextDecoration.none,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                  Wrap(
                    children: <Widget>[
                      IconButton(
                        icon: Icon(
                          playState
                              ? Icons.pause_circle_outline
                              : Icons.play_circle_outline,
                          size: 32,
                          color: Colors.black54,
                        ),
                        onPressed: () {
                          store.dispatch(playState
                              ? PlayActions.pause
                              : PlayActions.play);
                        },
                      ),
                      Container(
                          padding: EdgeInsets.only(left: 12, right: 4),
                          child: IconButton(
                            icon: Icon(
                              Icons.list,
                              size: 32,
                              color: Colors.black54,
                            ),
                            onPressed: () {
                              BottomSheetPlayList.show(context);
                            },
                          )),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
