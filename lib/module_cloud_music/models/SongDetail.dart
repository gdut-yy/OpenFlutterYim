import 'package:json_annotation/json_annotation.dart'; 
  
part 'SongDetail.g.dart';


@JsonSerializable()
  class SongDetail extends Object {

  @JsonKey(name: 'title')
  String title;

  @JsonKey(name: 'coverPic')
  String coverPic;

  @JsonKey(name: 'avatarUrl')
  String avatarUrl;

  @JsonKey(name: 'nickname')
  String nickname;

  @JsonKey(name: 'commentCount')
  int commentCount;

  @JsonKey(name: 'shareCount')
  int shareCount;

  SongDetail(this.title,this.coverPic,this.avatarUrl,this.nickname,this.commentCount,this.shareCount,);

  factory SongDetail.fromJson(Map<String, dynamic> srcJson) => _$SongDetailFromJson(srcJson);

  Map<String, dynamic> toJson() => _$SongDetailToJson(this);

}

  
