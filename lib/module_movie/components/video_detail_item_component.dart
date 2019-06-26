import 'package:flutter/material.dart';
import 'package:flutter_yim/module_movie/components/empty_component.dart';

/// 视频详情描述 Item
/// 2019-04-01
class VideoDetailItemComponent extends StatelessWidget {
  final String icon;
  final String content;
  final Widget child;

  const VideoDetailItemComponent(
      {this.icon, this.content, this.child = const EmptyComponent()});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              icon,
              width: 20.0,
              height: 20.0,
              fit: BoxFit.cover,
            ),
            SizedBox(width: 6.0),
            Text(content),
            child
          ],
        ));
  }
}
