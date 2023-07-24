import 'package:flutter/material.dart';
import 'package:music_player/colors/colors.dart';
import 'package:music_player/providers/song_provider.dart';
import 'package:provider/provider.dart';

class ProgressBar extends StatelessWidget {
  const ProgressBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final songProvider = Provider.of<SongProvider>(context);
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 25),
      child: Row(
        children: [
          Text('0:00', style: TextStyle(color: AppColors.background)),
          Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              child: Slider(
                activeColor: AppColors.barColor,
                inactiveColor: Colors.black26,
                value: songProvider.sliderValue,
                onChanged: (value) {
                  songProvider.sliderValue = value;
                },
              ),
            ),
          ),
          Text('6:06', style: TextStyle(color: AppColors.background)),
        ],
      ),
    );
  }
}
