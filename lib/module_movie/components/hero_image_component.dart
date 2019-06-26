import 'package:flutter/material.dart';
import 'package:flutter_yim/module_movie/components/cached_image_component.dart';
import 'package:flutter_yim/module_movie/models/pood/video_model.dart';

/// 转场动画Image组件
/// 2019-04-01
class HeroImageComponent extends StatelessWidget {
  final VideoModel imageItem;
  final double imageWidth, imageHeight;

  const HeroImageComponent({
    @required this.imageItem,
    this.imageWidth = 200.0,
    this.imageHeight = 400.0,
  });

  @override
  Widget build(BuildContext context) {
    String thumbnail = imageItem.thumbnail;
    if (thumbnail.startsWith("http://")) {
      thumbnail = thumbnail.replaceFirst("http://", "https://");
    }
    if (imageItem.timestamp == null) {
      imageItem.timestamp = "-default";
    }
    return SizedBox(
      width: imageWidth,
      height: imageHeight,
      child: Hero(
        key: Key(imageItem.id),
        tag: "${imageItem.id}${imageItem.timestamp}",
        child: CachedImageComponent(imageUrl: thumbnail),
      ),
    );
  }
}
