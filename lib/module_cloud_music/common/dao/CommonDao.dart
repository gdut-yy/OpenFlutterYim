import 'package:flutter_yim/module_cloud_music/common/Http.dart';
import 'package:flutter_yim/module_cloud_music/models/HotSearch.dart';
import 'package:flutter_yim/module_cloud_music/models/SearchSong.dart';

class CommonDao{
  static hotSearch() async {
    var result = await Http(loading: false).get('/search/hot');
    
    if(result != null) {
      return HotSearch.fromJson(result.data).result;
    }
  }
  static searchSong(Map params) async {
    var result = await Http(loading: false).get('/search/suggest', data: params);
    
    if(result != null) {
      return SearchSong.fromJson(result.data).result;
    }
  }
}
