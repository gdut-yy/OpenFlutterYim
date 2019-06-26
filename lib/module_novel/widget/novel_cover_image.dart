import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_yim/module_novel/app/sq_color.dart';

/// 书籍封面图
/// 2019-03-27
class NovelCoverImage extends StatelessWidget {
  final String imgUrl;
  final double width;
  final double height;

  NovelCoverImage(this.imgUrl, {this.width, this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image(
        image: CachedNetworkImageProvider(imgUrl),
        fit: BoxFit.cover,
        width: width,
        height: height,
      ),
      decoration: BoxDecoration(border: Border.all(color: SQColor.paper)),
    );
  }
}
