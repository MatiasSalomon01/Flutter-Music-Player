import 'package:flutter/material.dart';
import 'package:music_player/constants/constants.dart';
import 'package:music_player/services/song_service.dart';
import 'package:music_player/widgets/widgets.dart';
import 'package:provider/provider.dart';

class YourLibraryScreen extends StatelessWidget {
  const YourLibraryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final songService = Provider.of<SongService>(context);
    return Scaffold(
      appBar: const CustomAppBar2(),
      body: Container(
        padding: const EdgeInsets.only(top: 15),
        color: black,
        child: Stack(
          children: [
            SizedBox(
              width: size.width,
              height: size.height,
              child: ListView.separated(
                itemCount: songService.playlists.length,
                itemBuilder: (context, index) {
                  return PlaylistListTile(
                    playlist: songService.playlists[index],
                    index: index,
                  );
                },
                separatorBuilder: (context, index) =>
                    const Divider(color: transparent),
              ),
            ),
            if (songService.currentSong.id!.isNotEmpty) const Preview(),
            const CustomBottomNavigationbar(),
          ],
        ),
      ),
    );
  }
}
