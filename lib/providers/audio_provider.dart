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
      } else if (processingState != ProcessingState.completed) {
        songState = SongState.isPlaying;
      } else {
        _audioPlayer.seek(Duration.zero);
        pause();
      }
    });

    //Listener para la posicion, buffer y total duracion de la cancion
    _audioPlayer.positionStream.listen((position) {
      final oldbuffered = buffered;
      final oldtotal = total;
      current = position;
      buffered = oldbuffered;
      total = oldtotal;
      sliderValue = (position.inSeconds / total.inSeconds).isNaN
          ? sliderValue
          : (position.inSeconds / total.inSeconds);
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

  late AudioPlayer _audioPlayer;

  late String _url;

  String get url => _url;

  set setUrl(String value) {
    _audioPlayer.setUrl(value);
  }

  SongState _songState = SongState.isPaused;

  SongState get songState => _songState;

  set songState(SongState value) {
    _songState = value;
    notifyListeners();
  }

  Duration _current = Duration.zero;

  Duration get current => _current;

  set current(Duration value) {
    _current = value;
    notifyListeners();
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

  double _sliderValue = 0;

  double get sliderValue => _sliderValue;

  set sliderValue(double value) {
    _sliderValue = value;
    notifyListeners();
  }

  void _init() async {
    _audioPlayer = AudioPlayer();
    // await _audioPlayer.setUrl(url);
  }

  void play() => _audioPlayer.play();
  void pause() => _audioPlayer.pause();
  void stop() => _audioPlayer.stop();
  void seek(Duration position) => _audioPlayer.seek(position);
  // void disposes() => _audioPlayer.dispose();
}

enum SongState { isPlaying, isPaused, isLoading }
