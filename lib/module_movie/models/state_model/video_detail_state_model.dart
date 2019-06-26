import 'package:flutter_yim/module_movie/common/api.dart';
import 'package:flutter_yim/module_movie/common/status.dart';
import 'package:flutter_yim/module_movie/models/pood/video_detail_model.dart';
import 'package:flutter_yim/module_movie/models/state_model/base_state_model.dart';
import 'package:flutter_yim/module_movie/utils/http_util.dart';

/// 视频详情Model
/// 2019-04-01
class VideoDetailStateModel extends BaseStateModel {
  Status _status = Status.READY;
  VideoDetailModel _videoDetailModel;

  Status get status => _status;

  VideoDetailModel get videoDetailModel => _videoDetailModel;

  fetchVideoDetail(String videoId) {
    _status = Status.LOADING;
    HttpUtil.get(VIDEO_URL + videoId, null).then((res) {
      if (res.statusCode == Response.OK) {
        _status = Status.SUCCESS;
        _videoDetailModel = VideoDetailModel.fromJson(res.data["payload"]);
      } else {
        _status = Status.NO_RESULT;
      }
    }).catchError((onError) {
      _status = Status.ERROR;
      print(onError.toString());
    }).whenComplete(this.notifyListeners);
  }
}
