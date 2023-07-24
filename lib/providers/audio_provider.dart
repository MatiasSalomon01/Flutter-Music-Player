import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class AudioProvider extends ChangeNotifier {
  AudioProvider() {
    _init();
    _audioPlayer.playerStateStream.listen((playerState) {
      final isPlaying = playerState.playing;
      final processingState = playerState.processingState;
      if (processingState == ProcessingState.loading ||
          processingState == ProcessingState.buffering) {
        songState = SongState.isLoading;
      } else if (!isPlaying) {
        songState = SongState.isPaused;
      } else {
        songState = SongState.isPlaying;
      }
    });
  }

  static const url =
      'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-2.mp3';

  SongState _songState = SongState.isPaused;

  SongState get songState => _songState;

  set songState(SongState value) {
    _songState = value;
    notifyListeners();
  }

  late AudioPlayer _audioPlayer;

  void _init() async {
    _audioPlayer = AudioPlayer();
    await _audioPlayer.setUrl(url);
  }

  void play() => _audioPlayer.play();
  void pause() => _audioPlayer.pause();
  void dispose() => _audioPlayer.dispose();
}

enum SongState { isPlaying, isPaused, isLoading }
