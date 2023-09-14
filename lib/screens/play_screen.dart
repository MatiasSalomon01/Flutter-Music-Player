import 'package:flutter/material.dart';
import 'package:music_player/colors/colors.dart';
import 'package:music_player/models/models.dart';
import 'package:music_player/providers/providers.dart';
import 'package:music_player/services/song_service.dart';
import 'package:music_player/widgets/widgets.dart';
import 'package:provider/provider.dart';
import 'dart:ui';

class PlayerScreen extends StatefulWidget {
  final SongModel song;
  const PlayerScreen({super.key, required this.song});

  @override
  State<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  late final SongService songService;
  @override
  void initState() {
    super.initState();
    var audioProvider = Provider.of<AudioProvider>(context, listen: false);
    songService = Provider.of<SongService>(context, listen: false);

    if (widget.song.id == songService.currentSong.id) return;
    songService.currentSong = widget.song;

    audioProvider.setUrl = songService.currentSong.url;
    audioProvider.play();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SongService>(
      builder: (context, service, _) => Scaffold(
        backgroundColor: AppColors.background,
        extendBodyBehindAppBar: true,
        appBar: CustomAppBar(
          title: Text(
            service.currentSong.title,
            style: TextStyle(color: AppColors.background),
          ),
        ),
        body: Container(
          padding: const EdgeInsets.only(top: kToolbarHeight),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(service.currentSong.backgroundImage),
              fit: BoxFit.fill,
            ),
          ),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 25, sigmaY: 25),
            child: Column(
              children: [
                AlbumImage(image: service.currentSong.albumImage),
                TitleSubTitle(
                    title: service.currentSong.title,
                    subtitle: service.currentSong.artists),
                FuntionalityButtons(
                    isFavorite: service.currentSong.isFavorite,
                    id: service.currentSong.id!),
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
