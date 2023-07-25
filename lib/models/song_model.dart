class SongModel {
  int id;
  String title;
  String artists;
  String url;
  String albumImage;
  String backgroundImage;

  SongModel({
    required this.id,
    required this.title,
    required this.artists,
    required this.url,
    this.albumImage = "assets/default.jpg",
    this.backgroundImage = "assets/default.jpg",
  });
}
