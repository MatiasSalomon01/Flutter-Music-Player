import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';
import 'package:music_player/constants/constants.dart';
import 'package:music_player/models/models.dart';
import 'package:music_player/providers/providers.dart';
import 'package:music_player/screens/screens.dart';
import 'package:provider/provider.dart';

import '../services/song_service.dart';

class Preview extends StatelessWidget {
  const Preview({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final songService = Provider.of<SongService>(context);
    final audioProvider = Provider.of<AudioProvider>(context);
    return Positioned(
      bottom: 0,
      child: GestureDetector(
        onTap: () => toPlayerScreen(context, songService),
        child: SlideInUp(
          from: 40,
          duration: const Duration(milliseconds: 200),
          child: Container(
            width: size.width - 20,
            margin: const EdgeInsets.only(left: 10, right: 10, bottom: 65),
            padding: const EdgeInsets.only(right: 10, left: 20),
            height: 65,
            decoration: BoxDecoration(
              border: Border.all(color: white, width: .2),
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image: NetworkImage(songService.currentSong.backgroundImage),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(.6), BlendMode.darken),
              ),
            ),
            child: Row(
              children: [
                const _TitleSubtitlePreview(),
                const Spacer(),
                Material(
                  color: Colors.transparent,
                  child: IconButton(
                    splashRadius: 20,
                    highlightColor: darkGrey,
                    onPressed: audioProvider.songState == SongState.isLoading
                        ? null
                        : () => audioProvider.songState == SongState.isPlaying
                            ? audioProvider.pause()
                            : audioProvider.play(),
                    icon: audioProvider.songState == SongState.isLoading
                        ? const Padding(
                            padding: EdgeInsets.all(8),
                            child: CircularProgressIndicator(
                              color: white,
                              strokeWidth: 3,
                            ),
                          )
                        : Icon(
                            audioProvider.songState == SongState.isPlaying
                                ? Icons.pause
                                : Icons.play_arrow,
                            color: white,
                          ),
                  ),
                ),
                Material(
                  color: Colors.transparent,
                  child: IconButton(
                    splashRadius: 20,
                    highlightColor: darkGrey,
                    onPressed: () {
                      songService.currentSong = SongModel.empty();
                      songService.setCurrentSong();
                      audioProvider.stop();
                    },
                    icon: const Icon(
                      Icons.stop,
                      color: white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  toPlayerScreen(BuildContext context, SongService songService) =>
      Navigator.of(context).push(
        PageRouteBuilder(
          pageBuilder: (_, __, ___) =>
              PlayerScreen(song: songService.currentSong),
          transitionDuration: const Duration(milliseconds: 300),
          reverseTransitionDuration: const Duration(milliseconds: 150),
          transitionsBuilder: (_, animation, __, child) {
            return FadeTransition(
              opacity: Tween<double>(begin: 0.5, end: 1).animate(
                CurvedAnimation(parent: animation, curve: Curves.linear),
              ),
              child: child,
            );
          },
        ),
      );
}

class _TitleSubtitlePreview extends StatelessWidget {
  const _TitleSubtitlePreview({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final songService = Provider.of<SongService>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: size.width * .6,
          height: 22,
          child: _buildTitle(
              songService.currentSong.title.length < 30, songService),
        ),
        Text(
          songService.currentSong.artists,
          style: const TextStyle(
            color: Color.fromARGB(255, 119, 119, 119),
            fontSize: 16,
          ),
        ),
      ],
    );
  }

  Widget _buildTitle(bool isShortText, SongService songService) {
    return isShortText
        ? Text(
            songService.currentSong.title,
            style: const TextStyle(
              color: white,
              fontSize: 18,
            ),
          )
        : Marquee(
            text: songService.currentSong.title,
            style: const TextStyle(color: white, fontSize: 18),
            scrollAxis: Axis.horizontal,
            blankSpace: 50.0,
            velocity: 50.0,
            startAfter: const Duration(milliseconds: 2000),
            pauseAfterRound: const Duration(milliseconds: 1500),
            accelerationDuration: const Duration(milliseconds: 500),
            decelerationDuration: const Duration(milliseconds: 500),
          );
  }
}
