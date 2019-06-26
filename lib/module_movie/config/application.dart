import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:event_bus/event_bus.dart';

/// 全局应用
/// 2019-04-01
class Application {
  static Router router;
  static EventBus eventBus;

  static navigateTo(
      {@required BuildContext context,
      @required String route,
      transition = TransitionType.inFromRight}) {
    router.navigateTo(context, route, transition: transition);
  }
}
