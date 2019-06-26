// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Recommend.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Recommend _$RecommendFromJson(Map<String, dynamic> json) {
  return Recommend(
      json['hasTaste'] as bool,
      json['code'] as int,
      json['category'] as int,
      (json['result'] as List)
          ?.map((e) =>
              e == null ? null : Result.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$RecommendToJson(Recommend instance) => <String, dynamic>{
      'hasTaste': instance.hasTaste,
      'code': instance.code,
      'category': instance.category,
      'result': instance.result
    };

Result _$ResultFromJson(Map<String, dynamic> json) {
  return Result(
      json['id'] as int,
      json['name'] as String,
      json['copywriter'] as String,
      json['picUrl'] as String,
      json['canDislike'] as bool,
      (json['playCount'] as num)?.toDouble(),
      json['trackCount'] as int,
      json['highQuality'] as bool,
      json['alg'] as String);
}

Map<String, dynamic> _$ResultToJson(Result instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'copywriter': instance.copywriter,
      'picUrl': instance.picUrl,
      'canDislike': instance.canDislike,
      'playCount': instance.playCount,
      'trackCount': instance.trackCount,
      'highQuality': instance.highQuality,
      'alg': instance.alg
    };
