import 'package:flutter/material.dart';
import 'package:music_player/models/models.dart';

const darkGrey = Color(0xff121212);
const black = Colors.black;
const white = Colors.white;
const transparent = Colors.transparent;
const lightGreen = Color(0xff1ed760);
const selectionColor = Color(0xff3a8453);
const gray = Color(0xff242424);

const baseUrl = 'flutter-music-player-9518c-default-rtdb.firebaseio.com';

String formatDuration(Duration duration, {bool withHours = false}) {
  String twoDigits(int n) {
    if (n >= 10) return "$n";
    return "0$n";
  }

  String hours = twoDigits(duration.inHours);
  if (hours.length > 1) {
    hours = hours[1];
  }
  String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
  String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));

  return withHours
      ? hours == "0"
          ? "$twoDigitMinutes min $twoDigitSeconds s"
          : "$hours h $twoDigitMinutes min $twoDigitSeconds s"
      : "$twoDigitMinutes:$twoDigitSeconds";
}

Duration getTotalDuration(List<SongModel> songs) {
  Duration totalDuration = Duration.zero;
  for (var song in songs) {
    var x = song.duration.split(":");
    var duration = Duration(
        hours: int.parse(x[0]),
        minutes: int.parse(x[1]),
        seconds: int.parse(x[2]));
    totalDuration += duration;
  }
  return totalDuration;
}
