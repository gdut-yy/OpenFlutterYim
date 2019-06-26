import 'package:json_annotation/json_annotation.dart'; 
  
part 'Recommend.g.dart';


@JsonSerializable()
  class Recommend extends Object {

  @JsonKey(name: 'hasTaste')
  bool hasTaste;

  @JsonKey(name: 'code')
  int code;

  @JsonKey(name: 'category')
  int category;

  @JsonKey(name: 'result')
  List<Result> result;

  Recommend(this.hasTaste,this.code,this.category,this.result,);

  factory Recommend.fromJson(Map<String, dynamic> srcJson) => _$RecommendFromJson(srcJson);

  Map<String, dynamic> toJson() => _$RecommendToJson(this);

}

  
@JsonSerializable()
  class Result extends Object {

  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'name')
  String name;

  @JsonKey(name: 'copywriter')
  String copywriter;

  @JsonKey(name: 'picUrl')
  String picUrl;

  @JsonKey(name: 'canDislike')
  bool canDislike;

  @JsonKey(name: 'playCount')
  double playCount;

  @JsonKey(name: 'trackCount')
  int trackCount;

  @JsonKey(name: 'highQuality')
  bool highQuality;

  @JsonKey(name: 'alg')
  String alg;

  Result(this.id,this.name,this.copywriter,this.picUrl,this.canDislike,this.playCount,this.trackCount,this.highQuality,this.alg,);

  factory Result.fromJson(Map<String, dynamic> srcJson) => _$ResultFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ResultToJson(this);

}

  
