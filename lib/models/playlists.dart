import 'package:music_player/models/models.dart';

class Playlist {
  String? id;
  String title;
  int totalSongs;
  String image;
  List<SongModel> songs;
  String total;
  String mainColor;

  Playlist(
      {required this.title,
      required this.totalSongs,
      required this.image,
      required this.songs,
      this.total = "",
      this.mainColor = "0xff6a6a6a"});

  factory Playlist.fromJson(Map<String, dynamic> json) => Playlist(
      title: json["title"],
      totalSongs: json["totalSongs"],
      image: json["image"],
      songs: json["songs"] != null
          ? List<SongModel>.from(
              json["songs"].map((e) => SongModel.fromJson(e)))
          : [],
      mainColor: json["mainColor"]);

  Map<String, dynamic> toJson() => {
        "title": title,
        "totalSongs": totalSongs,
        "image": image,
        "songs": List<dynamic>.from(songs.map((x) => x.toJson())),
        "mainColor": mainColor
      };
}
