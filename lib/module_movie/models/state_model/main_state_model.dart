import 'package:flutter_yim/module_movie/models/state_model/theme_state_model.dart';
import 'package:scoped_model/scoped_model.dart';

/// 主数据模型，需要全局使用的数据在这里添加模型
/// 2019-04-01
class MainStateModel extends Model with ThemeStateModel {
  static MainStateModel of(context) =>
      ScopedModel.of<MainStateModel>(context, rebuildOnChange: true);
}
