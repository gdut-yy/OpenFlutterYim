import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

/// TabBar导航自定义指示器
/// 2019-04-01
class TabBarIndictorComponent extends Decoration {
  final BuildContext context;
  final Color bgColor;

  TabBarIndictorComponent(
      {@required this.context, this.bgColor = Colors.white});

  @override
  BoxPainter createBoxPainter([onChanged]) =>
      _TabBarIndictorBoxPainter(context, bgColor);
}

class _TabBarIndictorBoxPainter extends BoxPainter {
  BuildContext context;
  Color bgColor;

  _TabBarIndictorBoxPainter(this.context, this.bgColor);

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    final Paint paint = Paint();
    paint.color = bgColor;
    paint.style = PaintingStyle.fill;
    final width = 33.0;
    final height = 2.0;
    canvas.drawRect(
        Rect.fromLTWH(offset.dx - width / 2 + configuration.size.width / 2,
            configuration.size.height - height - 5.0, width, height),
        paint);
  }
}
