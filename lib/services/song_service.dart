import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:music_player/constants/constants.dart';
import 'package:music_player/models/models.dart';

class SongService extends ChangeNotifier {
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  List<SongModel> _songs = [];
  List<SongModel> _songsCopy = [];

  List<SongModel> get songsCopy => _songsCopy;

  List<SongModel> get songs => _songs;

  set songs(List<SongModel> value) {
    _songs = value;
    notifyListeners();
  }

  SongService() {
    getSongs();
  }

  void getSongs() async {
    _isLoading = true;
    final url = Uri.https(baseUrl, '/songs.json');
    final response = await http.get(url);
    final Map<String, dynamic> data = json.decode(response.body);

    data.forEach((key, value) {
      final model = SongModel.fromJson(value);
      _songs.add(model);
    });
    _isLoading = false;
    _songsCopy = _songs;
    notifyListeners();
  }

  SongModel _currentSong = SongModel.empty();

  SongModel get currentSong => _currentSong;

  set currentSong(SongModel value) {
    _currentSong = value;
  }

  void setCurrentSong() {
    _currentSong = currentSong;
    notifyListeners();
  }

  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  set currentIndex(int value) {
    _currentIndex = value;
  }

  bool _isDefault = true;

  bool get isDefault => _isDefault;

  set isDefault(bool value) {
    _isDefault = value;
  }

  void updateById(String id, bool isFavorite) {
    _songs = _songs.map((e) {
      if (e.id != id) return e;

      e.isFavorite = isFavorite;
      return e;
    }).toList();
    notifyListeners();
  }
}
