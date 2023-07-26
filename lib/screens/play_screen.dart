import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:music_player/colors/colors.dart';
import 'package:music_player/models/models.dart';
import 'package:music_player/providers/providers.dart';
import 'package:music_player/widgets/widgets.dart';
import 'package:provider/provider.dart';

class PlayerScreen extends StatelessWidget {
  final SongModel song;
  const PlayerScreen({super.key, required this.song});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AudioProvider(song.url),
      child: Scaffold(
        backgroundColor: AppColors.background,
        extendBodyBehindAppBar: true,
        appBar: CustomAppBar(title: song.title),
        body: Container(
          padding: const EdgeInsets.only(top: kToolbarHeight),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(song.backgroundImage),
              fit: BoxFit.fill,
            ),
          ),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 25, sigmaY: 25),
            child: Column(
              children: [
                AlbumImage(image: song.albumImage),
                TitleSubTitle(title: song.title, subtitle: song.artists),
                const FuntionalityButtons(),
                const Spacer(),
                const ProgressBar(),
                const Spacer(),
                const MainButtons(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
