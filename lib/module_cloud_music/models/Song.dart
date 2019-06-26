import 'package:json_annotation/json_annotation.dart';

part 'Song.g.dart';


List<Song> getSongList(List<dynamic> list){
  List<Song> result = [];
  list.forEach((item){
    result.add(Song.fromJson(item));
  });
  return result;
}

List<Map> songListToJson(List<Song> list){
  List<Map> result = [];
  list.forEach((Song item){
    result.add(item.toJson());
  });
  return result;
}
@JsonSerializable()
class Song extends Object {

  @JsonKey(name: 'songId')
  int songId;

  @JsonKey(name: 'singer')
  String singer;

  @JsonKey(name: 'coverPic')
  String coverPic;

  @JsonKey(name: 'url')
  String url;

  @JsonKey(name: 'songName')
  String songName;

  Song(this.songId,this.singer,this.coverPic,this.url,this.songName,);

  factory Song.fromJson(Map<String, dynamic> srcJson) => _$SongFromJson(srcJson);

  Map<String, dynamic> toJson() => _$SongToJson(this);

}

  
