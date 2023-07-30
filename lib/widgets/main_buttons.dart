import 'package:flutter/material.dart';
import 'package:music_player/colors/colors.dart';
import 'package:music_player/providers/audio_provider.dart';
import 'package:music_player/services/song_service.dart';
import 'package:provider/provider.dart';

class MainButtons extends StatefulWidget {
  const MainButtons({
    super.key,
  });

  @override
  State<MainButtons> createState() => _MainButtonsState();
}

class _MainButtonsState extends State<MainButtons> {
  late AudioProvider audioProvider;

  @override
  Widget build(BuildContext context) {
    audioProvider = Provider.of<AudioProvider>(context);
    final songService = Provider.of<SongService>(context);
    return Container(
      margin: const EdgeInsets.only(bottom: 35),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: songService.isDefault
            ? Colors.grey.withOpacity(.2)
            : Colors.black.withOpacity(.2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            padding: EdgeInsets.zero,
            onPressed: () => previous(songService),
            icon: const Icon(Icons.skip_previous, size: 35),
            splashRadius: 24,
            color: AppColors.background,
          ),
          Container(
            height: 50,
            margin: const EdgeInsets.symmetric(horizontal: 60),
            decoration: BoxDecoration(
              color: AppColors.background,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              padding: EdgeInsets.zero,
              onPressed: audioProvider.songState == SongState.isLoading
                  ? null
                  : () => audioProvider.songState == SongState.isPlaying
                      ? audioProvider.pause()
                      : audioProvider.play(),
              icon: audioProvider.songState == SongState.isLoading
                  ? Padding(
                      padding: const EdgeInsets.all(12),
                      child: const CircularProgressIndicator(
                        color: Colors.black,
                        strokeWidth: 4,
                      ),
                    )
                  : Icon(
                      audioProvider.songState == SongState.isPlaying
                          ? Icons.pause
                          : Icons.play_arrow,
                      size: 35,
                    ),
              splashRadius: .1,
            ),
          ),
          IconButton(
            padding: EdgeInsets.zero,
            onPressed: () => next(songService),
            icon: const Icon(Icons.skip_next, size: 35),
            splashRadius: 24,
            color: AppColors.background,
          ),
        ],
      ),
    );
  }

  void next(SongService songService) {
    int nextIndex = songService.currentIndex + 1;

    if (nextIndex == (songService.songs.length)) nextIndex = 0;

    songService.currentSong = songService.songs[nextIndex];
    audioProvider.setUrl = songService.currentSong.url;
    songService.setCurrentSong();
    songService.currentIndex = nextIndex;
    if (audioProvider.songState == SongState.isPaused) audioProvider.play();
  }

  void previous(SongService songService) {
    int nextIndex = songService.currentIndex - 1;

    if (nextIndex < 0) nextIndex = songService.songs.length - 1;

    songService.currentSong = songService.songs[nextIndex];
    audioProvider.setUrl = songService.currentSong.url;
    songService.setCurrentSong();
    songService.currentIndex = nextIndex;
    if (audioProvider.songState == SongState.isPaused) audioProvider.play();
  }
}
