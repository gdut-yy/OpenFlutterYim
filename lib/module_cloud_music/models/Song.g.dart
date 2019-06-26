// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Song.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Song _$SongFromJson(Map<String, dynamic> json) {
  return Song(
      json['songId'] as int,
      json['singer'] as String,
      json['coverPic'] as String,
      json['url'] as String,
      json['songName'] as String);
}

Map<String, dynamic> _$SongToJson(Song instance) => <String, dynamic>{
      'songId': instance.songId,
      'singer': instance.singer,
      'coverPic': instance.coverPic,
      'url': instance.url,
      'songName': instance.songName
    };
