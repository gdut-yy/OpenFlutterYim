import 'dart:convert';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_yim/module_cloud_music/models/Song.dart';
import 'package:meta/meta.dart';
import 'package:flutter_yim/module_cloud_music/common/dao/FindDao.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// 枚举：播放 暂停
enum PlayActions { play, pause, seekPlay }
/// 枚举：列表循环 随机播放 单曲循环
enum PlayModeActions { loop, random, order, singleLoop }

class PlayerState {
  AudioPlayer audioPlayer;
  PlayActions state;
  PlayModeActions mode;
  List<Song> playList;

  // 当前播放歌曲
  int playIdx;
  Duration playPosition;
  Duration duration;

  get playPositionText =>
      playPosition?.toString()?.split('.')?.first ?? '00:00';

  get durationText => duration?.toString()?.split('.')?.first ?? '00:00';

  PlayerState(
      {this.mode = PlayModeActions.loop,
      @required this.playList,
      this.playIdx,
      this.playPosition,
      this.duration}) {
    audioPlayer = AudioPlayer();
  }

  play() async {
    if (AudioPlayerState.PAUSED == audioPlayer.state) {
      resume();
    } else {
      String url = playList[playIdx].url = await _getSongUrl();
      if (url != null) {
        int result = await audioPlayer.play(url);
        if (result == 1) {
          print("开始播放");
          _savePlayerState();
        }
      }
    }
  }

  pause() async {
    int result = await audioPlayer.pause();
    if (result == 1) {
      print("暂停");
    }
  }

  resume() async {
    int result = await audioPlayer.resume();
    if (result == 1) {
      print('恢复播放');
    }
  }

  _savePlayerState() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('playerState', toJson());
  }

  // 跳转播放
  seekPlay(Duration s) {
    audioPlayer.seek(s);
  }

  // 播放上一曲
  playLastSong() {
    if (playIdx - 1 < 0) {
      playIdx = playList.length - 1;
    } else {
      playIdx--;
    }
  }

  // 播放下一曲
  playNextSong() {
    if (playIdx + 1 >= playList.length) {
      playIdx = 0;
    } else {
      playIdx++;
    }
  }

  _getSongUrl() async {
    Map result = await FindDao.getSongUrl({'id': playList[playIdx].songId});
    if (result != null) {
      return result['url'];
    }
  }

  setListen(store) {
    _onDurationChanged(store);
    _onPlayerCompletion(store);
    _onPlayerStateChanged(store);
    _onAudioPositionChanged(store);
  }

  _onDurationChanged(store) {
    audioPlayer.onDurationChanged.listen((Duration d) {
      duration = d;
    });
  }

  // 播放完成监听
  _onPlayerCompletion(store) {
    audioPlayer.onPlayerCompletion.listen((event) {
      if (mode == PlayModeActions.loop) {
        playNextSong();
      }

      if (mode == PlayModeActions.order) {
        if (playIdx + 1 >= playList.length) {
          print("歌曲列表播放完毕");
        } else {
          playIdx++;
        }
      }
      store.dispatch(PlayActions.play);
    });
  }

  // 播放状态监听
  _onPlayerStateChanged(store) {
    audioPlayer.onPlayerStateChanged.listen((AudioPlayerState s) {
      if (AudioPlayerState.PLAYING == s) {
        // store.dispatch(PlayActions.play);
      }
    });
  }

  // 播放进度监听
  _onAudioPositionChanged(store) {
    audioPlayer.onAudioPositionChanged.listen((Duration p) {
      playPosition = p;
      store.dispatch(this);
    });
  }

  toJson() {
    return jsonEncode({
      "mode": mode.index,
      "playList": songListToJson(playList),
      "playIdx": playIdx,
      "playPosition": playPosition?.inSeconds ?? 0,
      "duration": duration?.inSeconds ?? 0,
    });
  }

  PlayerState.fromJson(Map map) {
    mode = map['mode'];
    playList = map['playList'];
    // 当前播放歌曲
    playIdx = map['playIdx'];
    playPosition = map['playPosition'];
    duration = map['duration'];
  }

  getPlayInfo() => playList[playIdx];
}

playerReducer(PlayerState state, action) {
  switch (action.runtimeType) {
    // 播放状态改变
    case PlayActions:
      if (PlayActions.play == action) {
        state.state = action;
        state.play();
      } else if (PlayActions.pause == action) {
        state.state = action;
        state.pause();
      } else if (PlayActions.seekPlay == action) {
        state.seekPlay(state.playPosition);
      }
      break;
    // 播放模式
    case PlayModeActions:
      break;
    case PlayerState:
      break;
  }

  return state;
}
