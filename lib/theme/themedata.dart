import 'package:flutter/material.dart';
import 'package:music_player/colors/colors.dart';

class CustomThemeData {
  static ThemeData themeData = ThemeData(
    sliderTheme: SliderThemeData(
      thumbColor: AppColors.barColor,
      trackHeight: 2,
      thumbShape: const RoundSliderThumbShape(
        pressedElevation: 0,
        enabledThumbRadius: 7,
      ),
      overlayColor: Colors.transparent,
      overlayShape: SliderComponentShape.noOverlay,
    ),
  );
}
