import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:flutter_yim/module_cloud_music/values/ConstDefine.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:flutter_yim/module_cloud_music/common/redux/AppState.dart';
import 'package:flutter_yim/module_cloud_music/common/redux/PlayerState.dart';
import 'package:flutter_yim/module_cloud_music/widget/Img.dart';
import 'package:flutter_yim/module_cloud_music/models/Song.dart';
import 'dart:math';
import 'package:flutter_yim/module_cloud_music/widget/BottomSheetPlayList.dart';

class PlayDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreBuilder<AppState>(
        builder: (BuildContext context, Store<AppState> store) {
      PlayerState playerState = store.state.playerState;
      Song info = playerState.getPlayInfo();

      return BackgroundBlur(Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text(info.songName),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Flex(
          direction: Axis.vertical,
          children: <Widget>[
            Divider(
              height: 2,
            ),
            Expanded(
              child: _content(),
            ),
            _playCtrl(playerState, store, context)
          ],
        ),
      ));
    });
  }

  _content() {
    return Stack(
      children: <Widget>[
        Cd(),
        Positioned(
            height: 45,
            bottom: 0,
            left: 20,
            right: 0,
            child: Flex(
              direction: Axis.horizontal,
              children: <Widget>[
                _menuItem(ConstDefine.love),
                _menuItem(ConstDefine.download),
                _menuItem(ConstDefine.soundEffects),
                _menuItem(ConstDefine.more),
              ],
            ))
      ],
    );
  }

  _menuItem(String image) {
    return Expanded(
      child: InkWell(
        onTap: () {},
        child: Image.asset(
          image,
          fit: BoxFit.fitHeight,
        ),
      ),
    );
  }

  _playCtrl(PlayerState playerState, Store<AppState> store, context) {
    bool playState = (PlayActions.play == playerState.state);

    return Container(
      height: 107,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: Flex(
              direction: Axis.horizontal,
              children: <Widget>[
                Text(
                  playerState.playPositionText,
                  style: TextStyle(color: Colors.white),
                ),
                Expanded(
                  child: Container(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      child: Slider(
                        min: 0,
                        max: playerState.duration?.inSeconds?.roundToDouble() ??
                            0,
                        value: playerState.playPosition?.inSeconds
                                ?.roundToDouble() ??
                            0,
                        onChanged: (double val) {
                          playerState.playPosition =
                              Duration(seconds: val.toInt());
                          store.dispatch(PlayActions.seekPlay);
                        },
                      )),
                ),
                Text(
                  playerState.durationText,
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
          Flex(
            direction: Axis.horizontal,
            children: <Widget>[
              _ctrlItem(
                ConstDefine.playModeLoop,
              ),
              _ctrlItem(ConstDefine.playUp, onPressed: () {
                playerState.playLastSong();
                store.dispatch(PlayActions.play);
              }),
              _ctrlItem(
                playState ? ConstDefine.play : ConstDefine.playPause,
                onPressed: () {
                  store.dispatch(
                      playState ? PlayActions.pause : PlayActions.play);
                },
              ),
              _ctrlItem(ConstDefine.playNext, onPressed: () {
                playerState.playNextSong();
                store.dispatch(PlayActions.play);
              }),
              _ctrlItem(ConstDefine.playList, onPressed: () {
                BottomSheetPlayList.show(context);
              }),
            ],
          ),
        ],
      ),
    );
  }

  _ctrlItem(String img, {Function onPressed}) {
    return Expanded(
      child: FlatButton(
        onPressed: onPressed,
        child: Container(
          height: 60,
          width: 60,
          child: Image.asset(
            img,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}

/// 背景模糊
class BackgroundBlur extends StatelessWidget {
  final Widget child;

  BackgroundBlur(this.child);

  @override
  Widget build(BuildContext context) {
    return StoreBuilder<AppState>(
      builder: (BuildContext context, Store<AppState> store) {
        Song info = store.state.playerState.getPlayInfo();

        return Container(
          child: Stack(
            children: [
              Positioned(
                child: ConstrainedBox(
                  constraints: new BoxConstraints.expand(),
                  child: Img(
                    info.coverPic,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                child: IgnorePointer(
                  ignoring: true,
                  child: BackdropFilter(
                    filter: new ImageFilter.blur(sigmaX: 40, sigmaY: 40),
                    child: Container(
                      color: Colors.black.withOpacity(0.4),
                    ),
                  ),
                ),
              ),
              Positioned(child: child)
            ],
          ),
        );
      },
    );
  }
}

/// 歌带旋转
class Cd extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _Cd();
}

class _Cd extends State<Cd> with SingleTickerProviderStateMixin {
  AnimationController animationController;
  Animation animation;

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
        duration: Duration(milliseconds: 20000), vsync: this);
    animation = Tween(begin: 0.0, end: 360.0).animate(animationController);
    animationController.addListener(() {
      setState(() {});
    });
    animationController.addStatusListener((AnimationStatus state) {
      if (AnimationStatus.completed == state) {
        animationController.repeat();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return StoreBuilder<AppState>(
        builder: (BuildContext context, Store<AppState> store) {
      Song info = store.state.playerState.getPlayInfo();
      if (store.state.playerState.state == PlayActions.play) {
        animationController.forward();
      } else {
        animationController.stop();
      }

      return Container(
        child: Stack(
          children: <Widget>[
            Positioned(
              top: 58,
              left: 60,
              child: Transform.rotate(
                angle: animation.value * pi / 180.0,
                child: Stack(
                  children: <Widget>[
                    Container(
                      height: 283,
                      width: 283,
                      child: Image.asset(ConstDefine.cdDecorate1),
                    ),
                    Positioned(
                      child: Container(
                        margin: EdgeInsets.only(top: 4, left: 4),
                        height: 275,
                        width: 275,
                        child: Image.asset(ConstDefine.cdDecorate),
                      ),
                    ),
                    Positioned(
                      child: Container(
                        margin: EdgeInsets.only(left: 50, top: 50),
                        width: 182,
                        height: 182,
                        child: ClipOval(
                          child: Img(info.coverPic),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              left: 60,
              child: Container(
                margin: EdgeInsets.only(left: 140),
                height: 124,
                width: 90,
                child: Image.asset(ConstDefine.cdPlayCtrl),
              ),
            ),
          ],
        ),
      );
    });
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }
}
