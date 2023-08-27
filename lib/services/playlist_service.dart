import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:music_player/constants/constants.dart';
import 'package:music_player/models/playlists.dart';
import 'package:http/http.dart' as http;

class PlaylistService extends ChangeNotifier {
  Future<void> create(Playlist playlist) async {
    final url = Uri.https(baseUrl, '/playlists.json');
    final response = await http.post(url, body: json.encode(playlist.toJson()));
  }

  Future<void> update(Playlist playlist) async {}
  Future<void> delete(Playlist playlist) async {
    final url = Uri.https(baseUrl, '/playlists/${playlist.id}.json');
    final response = await http.delete(url);
  }
}
