import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

/// 自定义图片缓存组件
/// 2019-04-01
class CachedImageComponent extends StatelessWidget {
  final String imageUrl;
  final BoxFit boxFit;

  const CachedImageComponent(
      {@required this.imageUrl, this.boxFit = BoxFit.cover});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      key: Key(imageUrl),
      fit: boxFit,
      imageUrl: imageUrl.startsWith("http://")
          ? imageUrl.replaceFirst("http://", "https://")
          : imageUrl,
    );
  }
}
