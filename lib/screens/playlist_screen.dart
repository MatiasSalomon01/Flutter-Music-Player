import 'package:flutter/material.dart';
import 'package:music_player/constants/constants.dart';
import 'package:music_player/services/song_service.dart';
import 'package:music_player/widgets/widgets.dart';
import 'package:provider/provider.dart';

class PlaylistScreen extends StatelessWidget {
  const PlaylistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final songService = Provider.of<SongService>(context);
    final likedSongs = songService.getLikedSongs();
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        width: size.width,
        height: size.height,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xff716d61),
              Color(0xff121212),
            ],
            begin: Alignment.topCenter,
            end: Alignment.center,
          ),
        ),
        child: ListView.separated(
          physics: const BouncingScrollPhysics(),
          itemCount: likedSongs.length,
          itemBuilder: (context, index) => CustomListTile(
            data: likedSongs[index],
            index: index,
            length: likedSongs.length,
          ),
          separatorBuilder: (context, index) =>
              const Divider(color: Colors.transparent),
        ),
      ),
    );
  }
}
