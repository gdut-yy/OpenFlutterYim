import 'package:flutter_yim/module_wx/common/az_common.dart';

/// 2019-03-17
/// json 数据类型

/// 消息类型
enum MessageType { SYSTEM, PUBLIC, CHAT, GROUP }

/// Model 对应 contacts.json
class DataModel extends ISuspensionBean {
  /// 头像
  String avatarUrl;

  /// 昵称
  String name;

  /// 消息
  String msg;

  /// 索引
  String tagIndex;

  /// 首字拼音
  String namePinyin;

  /// 消息时间
  DateTime time = new DateTime.now();

  /// 消息类型
  MessageType type = MessageType.CHAT;

  String sex;

  DataModel({
    this.avatarUrl,
    this.name,
    this.tagIndex,
    this.namePinyin,
    this.sex,
    this.msg,
  });

  DataModel.fromJson(Map<String, dynamic> json)
      : name = json['name'] == null ? "" : json['name'];

  Map<String, dynamic> toJson() => {
        'name': name,
        'tagIndex': tagIndex,
        'namePinyin': namePinyin,
        'avatarUrl': avatarUrl,
        'isShowSuspension': isShowSuspension,
        'msg': msg,
        'time': time,
        'type': type
      };

  @override
  String getSuspensionTag() => tagIndex;

  @override
  String toString() => "CityBean {" + " \"name\":\"" + name + "\"" + '}';
}
