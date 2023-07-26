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
}
