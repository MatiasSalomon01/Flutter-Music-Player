import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:music_player/constants/constants.dart';
import 'package:music_player/models/models.dart';

class SongService extends ChangeNotifier {
  List<SongModel> _songs = [];

  List<SongModel> get songs => _songs;

  SongService() {
    getSongs();
  }

  void getSongs() async {
    final url = Uri.https(baseUrl, '/songs.json');
    final response = await http.get(url);
    final Map<String, dynamic> data = json.decode(response.body);

    data.forEach((key, value) {
      final model = SongModel.fromJson(value);
      _songs.add(model);
    });
    notifyListeners();
  }
}
