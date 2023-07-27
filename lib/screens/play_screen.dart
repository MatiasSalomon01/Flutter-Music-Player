import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:music_player/colors/colors.dart';
import 'package:music_player/models/models.dart';
import 'package:music_player/providers/providers.dart';
import 'package:music_player/services/song_service.dart';
import 'package:music_player/widgets/widgets.dart';
import 'package:provider/provider.dart';

class PlayerScreen extends StatefulWidget {
  final SongModel song;
  const PlayerScreen({super.key, required this.song});

  @override
  State<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  @override
  void initState() {
    var audioProvider = Provider.of<AudioProvider>(context, listen: false);
    audioProvider.setUrl = widget.song.url;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var songService = Provider.of<SongService>(context);
    songService.currentSong = widget.song;
    return Scaffold(
      backgroundColor: AppColors.background,
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(title: widget.song.title),
      body: Container(
        padding: const EdgeInsets.only(top: kToolbarHeight),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(widget.song.backgroundImage),
            fit: BoxFit.fill,
          ),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 25, sigmaY: 25),
          child: Column(
            children: [
              AlbumImage(image: widget.song.albumImage),
              TitleSubTitle(
                  title: widget.song.title, subtitle: widget.song.artists),
              const FuntionalityButtons(),
              const Spacer(),
              const ProgressBar(),
              const Spacer(),
              const MainButtons(),
            ],
          ),
        ),
      ),
    );
  }
}
