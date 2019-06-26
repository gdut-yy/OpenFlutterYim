// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'HotSearch.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HotSearch _$HotSearchFromJson(Map<String, dynamic> json) {
  return HotSearch(
      json['code'] as int,
      json['result'] == null
          ? null
          : Result.fromJson(json['result'] as Map<String, dynamic>));
}

Map<String, dynamic> _$HotSearchToJson(HotSearch instance) =>
    <String, dynamic>{'code': instance.code, 'result': instance.result};

Result _$ResultFromJson(Map<String, dynamic> json) {
  return Result((json['hots'] as List)
      ?.map((e) => e == null ? null : Hots.fromJson(e as Map<String, dynamic>))
      ?.toList());
}

Map<String, dynamic> _$ResultToJson(Result instance) =>
    <String, dynamic>{'hots': instance.hots};

Hots _$HotsFromJson(Map<String, dynamic> json) {
  return Hots(
      json['first'] as String, json['second'] as int, json['iconType'] as int);
}

Map<String, dynamic> _$HotsToJson(Hots instance) => <String, dynamic>{
      'first': instance.first,
      'second': instance.second,
      'iconType': instance.iconType
    };
