import 'package:flutter/material.dart';

/// 空视图组件
/// 2019-04-01
class EmptyComponent extends StatelessWidget {
  const EmptyComponent();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 0,
      height: 0,
    );
  }
}
