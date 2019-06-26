// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'SongDetail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SongDetail _$SongDetailFromJson(Map<String, dynamic> json) {
  return SongDetail(
      json['title'] as String,
      json['coverPic'] as String,
      json['avatarUrl'] as String,
      json['nickname'] as String,
      json['commentCount'] as int,
      json['shareCount'] as int);
}

Map<String, dynamic> _$SongDetailToJson(SongDetail instance) =>
    <String, dynamic>{
      'title': instance.title,
      'coverPic': instance.coverPic,
      'avatarUrl': instance.avatarUrl,
      'nickname': instance.nickname,
      'commentCount': instance.commentCount,
      'shareCount': instance.shareCount
    };
