import 'package:flutter/material.dart';
import 'package:flutter_yim/module_movie/common/status.dart';
import 'package:flutter_yim/module_movie/components/data_empty_component.dart';
import 'package:flutter_yim/module_movie/components/loading_component.dart';
import 'package:flutter_yim/module_movie/components/tag_component.dart';
import 'package:flutter_yim/module_movie/components/video_detail_item_component.dart';
import 'package:flutter_yim/module_movie/models/pood/video_detail_model.dart';
import 'package:flutter_yim/module_movie/models/pood/video_model.dart';
import 'package:flutter_yim/module_movie/models/state_model/video_detail_state_model.dart';
import 'package:scoped_model/scoped_model.dart';

/// 视频详情 Tab 页面
/// 2019-04-01
class VideoDescTabPage extends StatelessWidget {
  final VideoModel videoModel;

  const VideoDescTabPage(this.videoModel);

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<VideoDetailStateModel>(
      builder: (context, child, model) {
        VideoDetailModel videoDetailModel = model.videoDetailModel;
        return model.status == Status.LOADING
            ? LoadingComponent()
            : model.status == Status.SUCCESS
                ? ListView(
                    children: <Widget>[
                      VideoDetailItemComponent(
                        icon: "assets/mod_movie/img/icon_videodetail_name.png",
                        content: "${videoModel.name}",
                        child: TagComponent(
                            title: model.videoDetailModel != null
                                ? model.videoDetailModel.classify.name
                                : ""),
                      ),
                      Container(
                          margin: EdgeInsets.symmetric(vertical: 13.0),
                          child: VideoDetailItemComponent(
                              icon:
                                  "assets/mod_movie/img/icon_videodetail_director.png",
                              content:
                                  "导演: ${model.videoDetailModel.director[0]}")),
                      VideoDetailItemComponent(
                          icon:
                              "assets/mod_movie/img/icon_videodetail_starring.png",
                          content: "明星主演"),
                      Container(
                        margin: EdgeInsets.fromLTRB(33.3, 8.0, 16.0, 0.0),
                        child: Text(
                            "${videoDetailModel.starring.getRange(0, videoDetailModel.starring.length)}"),
                      ),
                      Container(
                          margin: EdgeInsets.symmetric(vertical: 13.0),
                          child: VideoDetailItemComponent(
                              icon:
                                  "assets/mod_movie/img/icon_videodetail_num.png",
                              content: "${videoModel.latest}")),
                      VideoDetailItemComponent(
                          icon:
                              "assets/mod_movie/img/icon_videodetail_jishu.png",
                          content:
                              "[ 更新时间 ] ${videoModel.generatedAt.substring(0, 9)}"),
                    ],
                  )
                : DataEmptyComponent(status: model.status);
      },
    );
  }
}
