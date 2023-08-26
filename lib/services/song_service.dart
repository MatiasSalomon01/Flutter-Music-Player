import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:just_audio/just_audio.dart';
import 'package:music_player/constants/constants.dart';
import 'package:music_player/models/models.dart';
import 'package:music_player/models/playlists.dart';
import 'dart:convert';

class SongService extends ChangeNotifier {
  List<SongModel> _songs = [];
  List<SongModel> _songsCopy = [];
  List<SongModel> _currentPlaylist = [];
  List<Playlist> _playlists = [];

  bool _isLoading = false;
  bool _isDefault = true;
  int _currentIndex = 0;
  bool _isPreviewOn = true;
  bool _isPlaylists = false;

  List<SongModel> get songsCopy => _songsCopy;
  SongModel _currentSong = SongModel.empty();
  SongModel get currentSong => _currentSong;
  List<SongModel> get songs => _songs;
  bool get isLoading => _isLoading;
  int get currentIndex => _currentIndex;
  bool get isDefault => _isDefault;
  bool get isPreviewOn => _isPreviewOn;
  List<SongModel> get currentPlaylist => _currentPlaylist;
  bool get isPlaylists => _isPlaylists;
  List<Playlist> get playlists => _playlists;

  SongService() {
    getSongs();
    getPlaylists();
  }

  set currentSong(SongModel value) {
    _currentSong = value;
  }

  set songs(List<SongModel> value) {
    _songs = value;
    notifyListeners();
  }

  set currentIndex(int value) {
    _currentIndex = value;
  }

  set isDefault(bool value) {
    _isDefault = value;
    notifyListeners();
  }

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  set isPreviewOn(bool value) {
    _isPreviewOn = value;
    notifyListeners();
  }

  void setCurrentSong() {
    _currentSong = currentSong;
    notifyListeners();
  }

  set currentPlaylist(List<SongModel> value) {
    _currentPlaylist = value;
    notifyListeners();
  }

  set isPlaylists(bool value) {
    _isPlaylists = value;
    notifyListeners();
  }

  set playlists(List<Playlist> value) {
    _playlists = value;
    notifyListeners();
  }

  void getSongs() async {
    isLoading = true;
    final url = Uri.https(baseUrl, '/songs.json');
    final response = await http.get(url);
    final Map<String, dynamic> data = json.decode(response.body);

    data.forEach((key, value) {
      final model = SongModel.fromJson(value);
      model.id = key;
      _songs.add(model);
    });
    isLoading = false;
    _songsCopy = _songs;
    currentPlaylist = _songs;
    notifyListeners();
  }

  // List<SongModel> getLikedSongs() {
  //   List<SongModel> likedSongs = [];
  //   songs.forEach((element) {
  //     if (element.isFavorite) likedSongs.add(element);
  //   });
  //   return likedSongs;
  // }

  Future getPlaylists() async {
    final url = Uri.https(baseUrl, '/playlists.json');
    final response = await http.get(url);
    final Map<String, dynamic> data = json.decode(response.body);

    data.forEach((key, value) {
      if (value["totalSongs"] == 0) {
        var playlist = Playlist(
          title: 'Tus me gustas',
          totalSongs: 0,
          image:
              'https://firebasestorage.googleapis.com/v0/b/flutter-music-player-9518c.appspot.com/o/images%2Fliked-songs-300.png?alt=media&token=b89872ec-3c82-4317-831e-651b84606206',
          songs: [],
        );
        _playlists = [playlist];
        notifyListeners();
        return;
      }
      final playlist = Playlist.fromJson(value);
      playlist.id = key;
      playlist.total =
          formatDuration(getTotalDuration(playlist.songs), withHours: true);
      _playlists.add(playlist);
    });

    notifyListeners();
  }

  void updatePlaylistsSong(Playlist playlist) async {
    playlist.totalSongs = playlist.songs.length;
    final url = Uri.https(baseUrl, '/playlists/${playlist.id}.json');
    final response = await http.put(url, body: json.encode(playlist));
  }

  Future updateLikedSong(Playlist playlist) async {
    playlist.totalSongs = playlist.songs.length;
    final url = Uri.https(baseUrl, '/playlists/likedSongs.json');
    final response = await http.put(url, body: json.encode(playlist));
    _playlists[0] = playlist;
    notifyListeners();
  }

  Future updateById(String id, bool isFavorite) async {
    final url = Uri.https(baseUrl, "/songs/$id/isFavorite.json");
    final response = await http.put(url, body: json.encode(isFavorite));
    if (response.statusCode == 200) {
      _songs = _songs.map((e) {
        if (e.id != id) return e;

        e.isFavorite = isFavorite;
        return e;
      }).toList();
    }

    _playlists = playlists.map((e) {
      e.total = formatDuration(getTotalDuration(e.songs), withHours: true);
      return e;
    }).toList();
    notifyListeners();
  }
}
