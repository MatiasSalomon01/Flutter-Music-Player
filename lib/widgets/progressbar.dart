import 'package:flutter/material.dart';
import 'package:music_player/colors/colors.dart';

class ProgressBar extends StatelessWidget {
  const ProgressBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 25),
      child: Row(
        children: [
          const Text('01:30', style: TextStyle(color: Colors.grey)),
          Expanded(
            child: Slider(
              activeColor: AppColors.barColor,
              inactiveColor: Colors.black26,
              value: 0.3,
              onChanged: (value) {
                print(value);
              },
            ),
          ),
          const Text('04:05', style: TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }
}
