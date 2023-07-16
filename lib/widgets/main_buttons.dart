import 'package:flutter/material.dart';
import 'package:music_player/colors/colors.dart';
import 'package:music_player/providers/song_provider.dart';
import 'package:provider/provider.dart';

class MainButtons extends StatelessWidget {
  const MainButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final songProvider = Provider.of<SongProvider>(context);
    return Container(
      margin: const EdgeInsets.only(top: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            padding: EdgeInsets.zero,
            onPressed: () {},
            icon: const Icon(Icons.skip_previous, size: 35),
            splashRadius: 24,
          ),
          Container(
            height: 50,
            margin: const EdgeInsets.symmetric(horizontal: 60),
            decoration: BoxDecoration(
              color: AppColors.black,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              padding: EdgeInsets.zero,
              onPressed: () => songProvider.start(),
              icon: Icon(
                songProvider.isPlaying == true ? Icons.pause : Icons.play_arrow,
                color: Colors.white,
                size: 35,
              ),
              splashRadius: .1,
            ),
          ),
          IconButton(
            padding: EdgeInsets.zero,
            onPressed: () {},
            icon: const Icon(Icons.skip_next, size: 35),
            splashRadius: 24,
          ),
        ],
      ),
    );
  }
}
