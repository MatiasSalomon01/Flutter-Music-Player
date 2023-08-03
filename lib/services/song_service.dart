import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:music_player/constants/constants.dart';
import 'package:music_player/models/models.dart';

class SongService extends ChangeNotifier {
  List<SongModel> _songs = [];
  List<SongModel> _songsCopy = [];
  bool _isLoading = false;
  bool _isDefault = true;
  int _currentIndex = 0;

  List<SongModel> get songsCopy => _songsCopy;
  SongModel _currentSong = SongModel.empty();
  SongModel get currentSong => _currentSong;
  List<SongModel> get songs => _songs;
  bool get isLoading => _isLoading;
  int get currentIndex => _currentIndex;
  bool get isDefault => _isDefault;

  SongService() {
    getSongs();
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
  }

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void setCurrentSong() {
    _currentSong = currentSong;
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
    notifyListeners();
  }

  void updateById(String id, bool isFavorite) async {
    final url = Uri.https(baseUrl, "/songs/$id/isFavorite.json");
    final response = await http.put(url, body: json.encode(isFavorite));
    if (response.statusCode == 200) {
      _songs = _songs.map((e) {
        if (e.id != id) return e;

        e.isFavorite = isFavorite;
        return e;
      }).toList();
    }
    notifyListeners();
  }
}
