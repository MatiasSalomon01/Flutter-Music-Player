import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SongProvider extends ChangeNotifier {
  double _sliderValue = 0;

  bool _isPlaying = false;

  late Timer timer;

  double get sliderValue => _sliderValue;

  set sliderValue(double value) {
    _sliderValue = value;
    notifyListeners();
  }

  bool get isPlaying => _isPlaying;

  set isPlaying(bool value) {
    _isPlaying = value;
    notifyListeners();
  }

  void start() {
    isPlaying = true;
    timer = Timer.periodic(const Duration(milliseconds: 1000), (timer) {
      sliderValue += .2;
      if (!(sliderValue <= 0.99)) {
        timer.cancel();
        sliderValue = 1;
        isPlaying = false;
      }
    });
  }

  stop() {
    timer.cancel();
  }

  previousSong() {}

  nextSong() {}
}
