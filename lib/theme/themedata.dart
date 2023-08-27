import 'package:flutter/material.dart';
import 'package:music_player/colors/colors.dart';
import 'package:music_player/constants/constants.dart';

class CustomThemeData {
  static ThemeData themeData = ThemeData(
      sliderTheme: SliderThemeData(
        thumbColor: AppColors.barColor,
        trackHeight: 2,
        thumbShape: const RoundSliderThumbShape(
          pressedElevation: 0,
          enabledThumbRadius: 7,
        ),
        overlayColor: transparent,
        overlayShape: SliderComponentShape.noOverlay,
      ),
      fontFamily: 'OpenSans');
}
