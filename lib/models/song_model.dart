class SongModel {
  String? id;
  String title;
  String artists;
  String url;
  String albumImage;
  String backgroundImage;
  bool isFavorite;
  bool isLightColor;

  SongModel({
    this.id,
    required this.title,
    required this.artists,
    required this.url,
    this.albumImage =
        "https://firebasestorage.googleapis.com/v0/b/flutter-music-player-9518c.appspot.com/o/images%2Fdefault.jpg?alt=media&token=94822719-eec5-4b55-8d37-0632e9f742a6",
    this.backgroundImage =
        "https://firebasestorage.googleapis.com/v0/b/flutter-music-player-9518c.appspot.com/o/images%2Fdefault.jpg?alt=media&token=94822719-eec5-4b55-8d37-0632e9f742a6",
    this.isFavorite = false,
    this.isLightColor = false,
  });

  factory SongModel.fromJson(Map<String, dynamic> json) => SongModel(
      title: json["title"],
      artists: json["artists"],
      url: json["url"],
      albumImage: json["image"],
      backgroundImage: json["backgroundImage"],
      isFavorite: json["isFavorite"],
      isLightColor: json["isLightColor"]);

  factory SongModel.empty() =>
      SongModel(id: "", title: "", artists: "", url: "");
}
