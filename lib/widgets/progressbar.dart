import 'package:flutter/material.dart';
import 'package:music_player/colors/colors.dart';
import 'package:music_player/providers/providers.dart';
import 'package:provider/provider.dart';

class ProgressBar extends StatefulWidget {
  const ProgressBar({super.key});

  @override
  State<ProgressBar> createState() => _ProgressBarState();
}

class _ProgressBarState extends State<ProgressBar> {
  late AudioProvider audioProvider;

  @override
  void dispose() {
    audioProvider.disposes();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    audioProvider = Provider.of<AudioProvider>(context);
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 25),
      child: Row(
        children: [
          Text(formatDuration(audioProvider.current),
              style: TextStyle(color: AppColors.background)),
          Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              child: Slider(
                activeColor: AppColors.barColor,
                inactiveColor: Colors.black26,
                value:
                    double.parse(audioProvider.sliderValue.toStringAsFixed(4)),
                onChanged: (value) =>
                    audioProvider.seek(audioProvider.total * value),
              ),
            ),
          ),
          Text(formatDuration(audioProvider.total),
              style: TextStyle(color: AppColors.background)),
        ],
      ),
    );
  }

  String formatDuration(Duration duration) {
    String twoDigits(int n) {
      if (n >= 10) return "$n";
      return "0$n";
    }

    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));

    return "$twoDigitMinutes:$twoDigitSeconds";
  }
}
