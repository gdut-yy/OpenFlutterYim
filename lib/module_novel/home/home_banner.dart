import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_yim/module_novel/home/home_model.dart';
import 'package:flutter_yim/module_novel/utility/screen.dart';

/// Banner 轮播图
/// 2019-03-27
class HomeBanner extends StatelessWidget {
  final List<CarouselInfo> carouselInfos;

  HomeBanner(this.carouselInfos);

  @override
  Widget build(BuildContext context) {
    if (carouselInfos.length == 0) {
      return SizedBox();
    }

    return Container(
      color: Colors.white,
      child: CarouselSlider(
        items: carouselInfos.map((info) {
          return Builder(
            builder: (BuildContext context) {
              return Container(
                width: Screen.width,
                margin: EdgeInsets.symmetric(horizontal: 5.0),
                child: Image.network(
                  info.imageUrl ?? '',
                  fit: BoxFit.cover,
                ),
              );
            },
          );
        }).toList(),
        aspectRatio: 2,
//        interval: const Duration(seconds: 5),
        autoPlay: true,
      ),
    );
  }
}
