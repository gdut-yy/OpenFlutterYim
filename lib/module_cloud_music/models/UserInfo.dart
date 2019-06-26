import 'package:json_annotation/json_annotation.dart'; 
  
part 'UserInfo.g.dart';


@JsonSerializable()
  class UserInfo extends Object {

  @JsonKey(name: 'nickname')
  String nickname;

  @JsonKey(name: 'backgroundUrl')
  String backgroundUrl;

  @JsonKey(name: 'avatarUrl')
  String avatarUrl;

  @JsonKey(name: 'uid')
  int uid;

  UserInfo(this.nickname,this.backgroundUrl,this.avatarUrl,this.uid,);

  factory UserInfo.fromJson(Map<String, dynamic> srcJson) => _$UserInfoFromJson(srcJson);

  Map<String, dynamic> toJson() => _$UserInfoToJson(this);

}

  
