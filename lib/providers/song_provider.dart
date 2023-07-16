import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SongProvider extends ChangeNotifier {
  double _sliderValue = 0;

  double get sliderValue => _sliderValue;

  set sliderValue(double value) {
    _sliderValue = value;
  }
}
