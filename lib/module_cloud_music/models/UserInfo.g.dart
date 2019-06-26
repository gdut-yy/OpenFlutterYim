// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'UserInfo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserInfo _$UserInfoFromJson(Map<String, dynamic> json) {
  return UserInfo(json['nickname'] as String, json['backgroundUrl'] as String,
      json['avatarUrl'] as String, json['uid'] as int);
}

Map<String, dynamic> _$UserInfoToJson(UserInfo instance) => <String, dynamic>{
      'nickname': instance.nickname,
      'backgroundUrl': instance.backgroundUrl,
      'avatarUrl': instance.avatarUrl,
      'uid': instance.uid
    };
