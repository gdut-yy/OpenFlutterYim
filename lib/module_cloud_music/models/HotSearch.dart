import 'package:json_annotation/json_annotation.dart'; 
  
part 'HotSearch.g.dart';


@JsonSerializable()
  class HotSearch extends Object {

  @JsonKey(name: 'code')
  int code;

  @JsonKey(name: 'result')
  Result result;

  HotSearch(this.code,this.result,);

  factory HotSearch.fromJson(Map<String, dynamic> srcJson) => _$HotSearchFromJson(srcJson);

  Map<String, dynamic> toJson() => _$HotSearchToJson(this);

}

  
@JsonSerializable()
  class Result extends Object {

  @JsonKey(name: 'hots')
  List<Hots> hots;

  Result(this.hots,);

  factory Result.fromJson(Map<String, dynamic> srcJson) => _$ResultFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ResultToJson(this);

}

  
@JsonSerializable()
  class Hots extends Object {

  @JsonKey(name: 'first')
  String first;

  @JsonKey(name: 'second')
  int second;

  @JsonKey(name: 'iconType')
  int iconType;

  Hots(this.first,this.second,this.iconType,);

  factory Hots.fromJson(Map<String, dynamic> srcJson) => _$HotsFromJson(srcJson);

  Map<String, dynamic> toJson() => _$HotsToJson(this);

}

  
