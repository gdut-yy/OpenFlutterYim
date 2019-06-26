class SearchSong {
	SearchSongResult result;
	int code;

	SearchSong({this.result, this.code});

	SearchSong.fromJson(Map<String, dynamic> json) {
		result = json['result'] != null ? new SearchSongResult.fromJson(json['result']) : null;
		code = json['code'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		if (this.result != null) {
      data['result'] = this.result.toJson();
    }
		data['code'] = this.code;
		return data;
	}
}

class SearchSongResult {
	List<SearchSongResultAlbum> albums;
	List<SearchSongResultSong> songs;
	List<SearchSongResultPlaylist> playlists;
	List<SearchSongResultMv> mvs;
	List<String> order;

	SearchSongResult({this.albums, this.songs, this.playlists, this.mvs, this.order});

	SearchSongResult.fromJson(Map<String, dynamic> json) {
		if (json['albums'] != null) {
			albums = new List<SearchSongResultAlbum>();
			(json['albums'] as List).forEach((v) { albums.add(new SearchSongResultAlbum.fromJson(v)); });
		}
		if (json['songs'] != null) {
			songs = new List<SearchSongResultSong>();
			(json['songs'] as List).forEach((v) { songs.add(new SearchSongResultSong.fromJson(v)); });
		}
		if (json['playlists'] != null) {
			playlists = new List<SearchSongResultPlaylist>();
			(json['playlists'] as List).forEach((v) { playlists.add(new SearchSongResultPlaylist.fromJson(v)); });
		}
		if (json['mvs'] != null) {
			mvs = new List<SearchSongResultMv>();
			(json['mvs'] as List).forEach((v) { mvs.add(new SearchSongResultMv.fromJson(v)); });
		}
		order = json['order'].cast<String>();
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		if (this.albums != null) {
      data['albums'] = this.albums.map((v) => v.toJson()).toList();
    }
		if (this.songs != null) {
      data['songs'] = this.songs.map((v) => v.toJson()).toList();
    }
		if (this.playlists != null) {
      data['playlists'] = this.playlists.map((v) => v.toJson()).toList();
    }
		if (this.mvs != null) {
      data['mvs'] = this.mvs.map((v) => v.toJson()).toList();
    }
		data['order'] = this.order;
		return data;
	}
}

class SearchSongResultAlbum {
	int publishTime;
	int size;
	SearchSongResultAlbumsArtist artist;
	int copyrightId;
	String name;
	int id;
	int picId;
	int status;

	SearchSongResultAlbum({this.publishTime, this.size, this.artist, this.copyrightId, this.name, this.id, this.picId, this.status});

	SearchSongResultAlbum.fromJson(Map<String, dynamic> json) {
		publishTime = json['publishTime'];
		size = json['size'];
		artist = json['artist'] != null ? new SearchSongResultAlbumsArtist.fromJson(json['artist']) : null;
		copyrightId = json['copyrightId'];
		name = json['name'];
		id = json['id'];
		picId = json['picId'];
		status = json['status'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['publishTime'] = this.publishTime;
		data['size'] = this.size;
		if (this.artist != null) {
      data['artist'] = this.artist.toJson();
    }
		data['copyrightId'] = this.copyrightId;
		data['name'] = this.name;
		data['id'] = this.id;
		data['picId'] = this.picId;
		data['status'] = this.status;
		return data;
	}
}

class SearchSongResultAlbumsArtist {
	String picUrl;
	String img1v1Url;
	int img1v1;
	String name;
	int id;
	int albumSize;
	int picId;
	dynamic trans;

	SearchSongResultAlbumsArtist({this.picUrl, this.img1v1Url, this.img1v1, this.name, this.id, this.albumSize, this.picId, this.trans});

	SearchSongResultAlbumsArtist.fromJson(Map<String, dynamic> json) {
		picUrl = json['picUrl'];
		img1v1Url = json['img1v1Url'];
		img1v1 = json['img1v1'];
		name = json['name'];
		id = json['id'];
		albumSize = json['albumSize'];
		picId = json['picId'];
		trans = json['trans'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['picUrl'] = this.picUrl;
		data['img1v1Url'] = this.img1v1Url;
		data['img1v1'] = this.img1v1;
		data['name'] = this.name;
		data['id'] = this.id;
		data['albumSize'] = this.albumSize;
		data['picId'] = this.picId;
		data['trans'] = this.trans;
		return data;
	}
}

class SearchSongResultSong {
	List<SearchSongResultSongsArtist> artists;
	String name;
	int id;

	SearchSongResultSong({this.artists, this.name, this.id});

	SearchSongResultSong.fromJson(Map<String, dynamic> json) {
		if (json['artists'] != null) {
			artists = new List<SearchSongResultSongsArtist>();
			(json['artists'] as List).forEach((v) { artists.add(new SearchSongResultSongsArtist.fromJson(v)); });
		}
		name = json['name'];
		id = json['id'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		if (this.artists != null) {
      data['artists'] = this.artists.map((v) => v.toJson()).toList();
    }
		data['name'] = this.name;
		data['id'] = this.id;
		return data;
	}
}

class SearchSongResultSongsArtist {
	dynamic picUrl;
	String img1v1Url;
	int img1v1;
	String name;
	int id;
	int albumSize;
	int picId;
	dynamic trans;

	SearchSongResultSongsArtist({this.picUrl, this.img1v1Url, this.img1v1, this.name, this.id, this.albumSize, this.picId, this.trans});

	SearchSongResultSongsArtist.fromJson(Map<String, dynamic> json) {
		picUrl = json['picUrl'];
		img1v1Url = json['img1v1Url'];
		img1v1 = json['img1v1'];
		name = json['name'];
		id = json['id'];
		albumSize = json['albumSize'];
		picId = json['picId'];
		trans = json['trans'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['picUrl'] = this.picUrl;
		data['img1v1Url'] = this.img1v1Url;
		data['img1v1'] = this.img1v1;
		data['name'] = this.name;
		data['id'] = this.id;
		data['albumSize'] = this.albumSize;
		data['picId'] = this.picId;
		data['trans'] = this.trans;
		return data;
	}
}

class SearchSongResultPlaylist {
	String coverImgUrl;
	bool subscribed;
	int playCount;
	dynamic creator;
	int trackCount;
	int bookCount;
	String name;
	String description;
	bool highQuality;
	int id;
	int userId;

	SearchSongResultPlaylist({this.coverImgUrl, this.subscribed, this.playCount, this.creator, this.trackCount, this.bookCount, this.name, this.description, this.highQuality, this.id, this.userId});

	SearchSongResultPlaylist.fromJson(Map<String, dynamic> json) {
		coverImgUrl = json['coverImgUrl'];
		subscribed = json['subscribed'];
		playCount = json['playCount'];
		creator = json['creator'];
		trackCount = json['trackCount'];
		bookCount = json['bookCount'];
		name = json['name'];
		description = json['description'];
		highQuality = json['highQuality'];
		id = json['id'];
		userId = json['userId'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['coverImgUrl'] = this.coverImgUrl;
		data['subscribed'] = this.subscribed;
		data['playCount'] = this.playCount;
		data['creator'] = this.creator;
		data['trackCount'] = this.trackCount;
		data['bookCount'] = this.bookCount;
		data['name'] = this.name;
		data['description'] = this.description;
		data['highQuality'] = this.highQuality;
		data['id'] = this.id;
		data['userId'] = this.userId;
		return data;
	}
}

class SearchSongResultMv {
	SearchSongResultMvsMv mv;
	int artistId;
	String cover;
	int duration;
	int playCount;
	bool subed;
	String briefDesc;
	List<SearchSongResultMvsArtist> artists;
	dynamic transNames;
	String name;
	String artistName;
	int id;
	int mark;
	dynamic desc;

	SearchSongResultMv({this.mv, this.artistId, this.cover, this.duration, this.playCount, this.subed, this.briefDesc, this.artists, this.transNames, this.name, this.artistName, this.id, this.mark, this.desc});

	SearchSongResultMv.fromJson(Map<String, dynamic> json) {
		mv = json['mv'] != null ? new SearchSongResultMvsMv.fromJson(json['mv']) : null;
		artistId = json['artistId'];
		cover = json['cover'];
		duration = json['duration'];
		playCount = json['playCount'];
		subed = json['subed'];
		briefDesc = json['briefDesc'];
		if (json['artists'] != null) {
			artists = new List<SearchSongResultMvsArtist>();
			(json['artists'] as List).forEach((v) { artists.add(new SearchSongResultMvsArtist.fromJson(v)); });
		}
		transNames = json['transNames'];
		name = json['name'];
		artistName = json['artistName'];
		id = json['id'];
		mark = json['mark'];
		desc = json['desc'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		if (this.mv != null) {
      data['mv'] = this.mv.toJson();
    }
		data['artistId'] = this.artistId;
		data['cover'] = this.cover;
		data['duration'] = this.duration;
		data['playCount'] = this.playCount;
		data['subed'] = this.subed;
		data['briefDesc'] = this.briefDesc;
		if (this.artists != null) {
      data['artists'] = this.artists.map((v) => v.toJson()).toList();
    }
		data['transNames'] = this.transNames;
		data['name'] = this.name;
		data['artistName'] = this.artistName;
		data['id'] = this.id;
		data['mark'] = this.mark;
		data['desc'] = this.desc;
		return data;
	}
}

class SearchSongResultMvsMv {
	int pic16v9;
	int fee;
	int caption;
	List<SearchSongResultMvsMvVideo> videos;
	String title;
	String appTitle;
	String type;
	int authId;
	int score;
	String subTitle;
	String mottos;
	List<SearchSongResultMvsMvArtist> artists;
	String appword;
	int id;
	String topWeeks;
	String transName;
	String area;
	String publishTime;
	int neteaseonly;
	int plays;
	int weekplays;
	int monthplays;
	int dayplays;
	String stars;
	String captionLanguage;
	int upban;
	int pic4v3;
	String aliaName;
	int online;
	String style;
	String subType;
	int status;
	String oneword;
	String desc;

	SearchSongResultMvsMv({this.pic16v9, this.fee, this.caption, this.videos, this.title, this.appTitle, this.type, this.authId, this.score, this.subTitle, this.mottos, this.artists, this.appword, this.id, this.topWeeks, this.transName, this.area, this.publishTime, this.neteaseonly, this.plays, this.weekplays, this.monthplays, this.dayplays, this.stars, this.captionLanguage, this.upban, this.pic4v3, this.aliaName, this.online, this.style, this.subType, this.status, this.oneword, this.desc});

	SearchSongResultMvsMv.fromJson(Map<String, dynamic> json) {
		pic16v9 = json['pic16v9'];
		fee = json['fee'];
		caption = json['caption'];
		if (json['videos'] != null) {
			videos = new List<SearchSongResultMvsMvVideo>();
			(json['videos'] as List).forEach((v) { videos.add(new SearchSongResultMvsMvVideo.fromJson(v)); });
		}
		title = json['title'];
		appTitle = json['appTitle'];
		type = json['type'];
		authId = json['authId'];
		score = json['score'];
		subTitle = json['subTitle'];
		mottos = json['mottos'];
		if (json['artists'] != null) {
			artists = new List<SearchSongResultMvsMvArtist>();
			(json['artists'] as List).forEach((v) { artists.add(new SearchSongResultMvsMvArtist.fromJson(v)); });
		}
		appword = json['appword'];
		id = json['id'];
		topWeeks = json['topWeeks'];
		transName = json['transName'];
		area = json['area'];
		publishTime = json['publishTime'];
		neteaseonly = json['neteaseonly'];
		plays = json['plays'];
		weekplays = json['weekplays'];
		monthplays = json['monthplays'];
		dayplays = json['dayplays'];
		stars = json['stars'];
		captionLanguage = json['captionLanguage'];
		upban = json['upban'];
		pic4v3 = json['pic4v3'];
		aliaName = json['aliaName'];
		online = json['online'];
		style = json['style'];
		subType = json['subType'];
		status = json['status'];
		oneword = json['oneword'];
		desc = json['desc'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['pic16v9'] = this.pic16v9;
		data['fee'] = this.fee;
		data['caption'] = this.caption;
		if (this.videos != null) {
      data['videos'] = this.videos.map((v) => v.toJson()).toList();
    }
		data['title'] = this.title;
		data['appTitle'] = this.appTitle;
		data['type'] = this.type;
		data['authId'] = this.authId;
		data['score'] = this.score;
		data['subTitle'] = this.subTitle;
		data['mottos'] = this.mottos;
		if (this.artists != null) {
      data['artists'] = this.artists.map((v) => v.toJson()).toList();
    }
		data['appword'] = this.appword;
		data['id'] = this.id;
		data['topWeeks'] = this.topWeeks;
		data['transName'] = this.transName;
		data['area'] = this.area;
		data['publishTime'] = this.publishTime;
		data['neteaseonly'] = this.neteaseonly;
		data['plays'] = this.plays;
		data['weekplays'] = this.weekplays;
		data['monthplays'] = this.monthplays;
		data['dayplays'] = this.dayplays;
		data['stars'] = this.stars;
		data['captionLanguage'] = this.captionLanguage;
		data['upban'] = this.upban;
		data['pic4v3'] = this.pic4v3;
		data['aliaName'] = this.aliaName;
		data['online'] = this.online;
		data['style'] = this.style;
		data['subType'] = this.subType;
		data['status'] = this.status;
		data['oneword'] = this.oneword;
		data['desc'] = this.desc;
		return data;
	}
}

class SearchSongResultMvsMvVideo {
	int duration;
	String container;
	int size;
	int width;
	String tag;
	bool check;
	SearchSongResultMvsMvVideosTagsign tagSign;
	String url;
	int height;
	String md5;

	SearchSongResultMvsMvVideo({this.duration, this.container, this.size, this.width, this.tag, this.check, this.tagSign, this.url, this.height, this.md5});

	SearchSongResultMvsMvVideo.fromJson(Map<String, dynamic> json) {
		duration = json['duration'];
		container = json['container'];
		size = json['size'];
		width = json['width'];
		tag = json['tag'];
		check = json['check'];
		tagSign = json['tagSign'] != null ? new SearchSongResultMvsMvVideosTagsign.fromJson(json['tagSign']) : null;
		url = json['url'];
		height = json['height'];
		md5 = json['md5'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['duration'] = this.duration;
		data['container'] = this.container;
		data['size'] = this.size;
		data['width'] = this.width;
		data['tag'] = this.tag;
		data['check'] = this.check;
		if (this.tagSign != null) {
      data['tagSign'] = this.tagSign.toJson();
    }
		data['url'] = this.url;
		data['height'] = this.height;
		data['md5'] = this.md5;
		return data;
	}
}

class SearchSongResultMvsMvVideosTagsign {
	int br;
	String mvtype;
	String type;
	String tagSign;
	int resolution;

	SearchSongResultMvsMvVideosTagsign({this.br, this.mvtype, this.type, this.tagSign, this.resolution});

	SearchSongResultMvsMvVideosTagsign.fromJson(Map<String, dynamic> json) {
		br = json['br'];
		mvtype = json['mvtype'];
		type = json['type'];
		tagSign = json['tagSign'];
		resolution = json['resolution'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['br'] = this.br;
		data['mvtype'] = this.mvtype;
		data['type'] = this.type;
		data['tagSign'] = this.tagSign;
		data['resolution'] = this.resolution;
		return data;
	}
}

class SearchSongResultMvsMvArtist {
	String name;
	int id;

	SearchSongResultMvsMvArtist({this.name, this.id});

	SearchSongResultMvsMvArtist.fromJson(Map<String, dynamic> json) {
		name = json['name'];
		id = json['id'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['name'] = this.name;
		data['id'] = this.id;
		return data;
	}
}

class SearchSongResultMvsArtist {
	dynamic transNames;
	String name;
	List<String> alias;
	int id;

	SearchSongResultMvsArtist({this.transNames, this.name, this.alias, this.id});

	SearchSongResultMvsArtist.fromJson(Map<String, dynamic> json) {
		transNames = json['transNames'];
		name = json['name'];
		alias = json['alias'].cast<String>();
		id = json['id'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['transNames'] = this.transNames;
		data['name'] = this.name;
		data['alias'] = this.alias;
		data['id'] = this.id;
		return data;
	}
}
