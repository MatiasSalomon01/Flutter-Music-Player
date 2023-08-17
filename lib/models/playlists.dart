import 'package:music_player/models/models.dart';

class Playlist {
  String title;
  int totalSongs;
  String image;
  List<SongModel> songs;

  Playlist({
    required this.title,
    required this.totalSongs,
    required this.image,
    required this.songs,
  });

  factory Playlist.fromJson(Map<String, dynamic> json) => Playlist(
        title: json["title"],
        totalSongs: json["totalSongs"],
        image: json["image"],
        songs: List<SongModel>.from(
            json["songs"].map((e) => SongModel.fromJson(e))),
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "totalSongs": totalSongs,
        "image": image,
        "songs": List<dynamic>.from(songs.map((x) => x.toJson())),
      };
}