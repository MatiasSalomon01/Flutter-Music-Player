import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class AudioProvider extends ChangeNotifier {
  AudioProvider() {
    _init();

    //Listener para el estado de la cancion
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

    //Listener para la posicion, buffer y total duracion de la cancion
    _audioPlayer.positionStream.listen((position) {
      final oldbuffered = buffered;
      final oldtotal = total;
      current = position;
      buffered = oldbuffered;
      total = oldtotal;
    });

    //Listener para el buffer de la cancion
    _audioPlayer.bufferedPositionStream.listen((bufferedPosition) {
      final oldcurrent = current;
      final oldtotal = total;
      current = oldcurrent;
      buffered = bufferedPosition;
      total = oldtotal;
    });

    _audioPlayer.durationStream.listen((totalDuration) {
      final oldcurrent = current;
      final oldbuffered = buffered;
      current = oldcurrent;
      buffered = oldbuffered;
      total = totalDuration ?? Duration.zero;
    });
  }

  static const url =
      'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-2.mp3';

  late AudioPlayer _audioPlayer;

  SongState _songState = SongState.isPaused;

  SongState get songState => _songState;

  set songState(SongState value) {
    _songState = value;
    notifyListeners();
  }

  Duration _current = Duration.zero;

  Duration get current => _current;

  set current(Duration value) {
    notifyListeners();
    _current = value;
  }

  Duration _buffered = Duration.zero;

  Duration get buffered => _buffered;

  set buffered(Duration value) {
    _buffered = value;
    notifyListeners();
  }

  Duration _total = Duration.zero;

  Duration get total => _total;

  set total(Duration value) {
    _total = value;
    notifyListeners();
  }

  void _init() async {
    _audioPlayer = AudioPlayer();
    await _audioPlayer.setUrl(url);
  }

  void play() => _audioPlayer.play();
  void pause() => _audioPlayer.pause();
  void dispose() => _audioPlayer.dispose();
}

enum SongState { isPlaying, isPaused, isLoading }
