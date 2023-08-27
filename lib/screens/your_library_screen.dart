import 'dart:math';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:music_player/constants/constants.dart';
import 'package:music_player/screens/screens.dart';
import 'package:music_player/services/song_service.dart';
import 'package:music_player/widgets/widgets.dart';
import 'package:provider/provider.dart';

class YourLibraryScreen extends StatelessWidget {
  const YourLibraryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final songService = Provider.of<SongService>(context);
    // final likedSongs = songService.getLikedSongs();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: darkGrey,
        title: Row(
          children: const [
            CircleAvatar(
              backgroundColor: Colors.grey,
              radius: 18,
              child: Text(
                'M',
                style: TextStyle(color: black, fontSize: 20),
              ),
            ),
            SizedBox(width: 10),
            Text('Tu biblioteca'),
          ],
        ),
        actions: [
          IconButton(
            padding: EdgeInsets.zero,
            onPressed: () {},
            icon: const Icon(Icons.search_outlined),
            splashRadius: 20,
            splashColor: transparent,
          ),
          IconButton(
            padding: EdgeInsets.zero,
            onPressed: () => showCreatePlaylistModal(context),
            icon: const Icon(Icons.add, size: 30),
            splashRadius: 20,
            splashColor: transparent,
          ),
        ],
        automaticallyImplyLeading: false,
      ),
      body: Container(
        padding: const EdgeInsets.only(top: 15),
        color: black,
        child: Stack(
          children: [
            SizedBox(
              width: size.width,
              height: size.height,
              child: ListView.builder(
                itemCount: songService.playlists.length,
                itemBuilder: (context, index) {
                  return PlaylistListTile(
                    playlist: songService.playlists[index],
                    index: index,
                  );
                },
              ),
            ),
            if (songService.currentSong.id!.isNotEmpty) const Preview(),
            const CustomBottomNavigationbar(),
          ],
        ),
      ),
    );
  }

  Future showCreatePlaylistModal(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      // isScrollControlled: true,
      backgroundColor: transparent,
      builder: (context) => Container(
        height: 180,
        decoration: const BoxDecoration(
          color: gray,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(15),
          ),
        ),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              width: 40,
              height: 5,
              decoration: const BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.horizontal(
                  left: Radius.circular(25),
                  right: Radius.circular(25),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: const Text(
                'Crear',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: white,
                  fontSize: 18,
                ),
              ),
            ),
            const Divider(color: white, thickness: .1),
            GestureDetector(
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const CreatePlaylist(),
                ),
              ),
              child: Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Row(
                  children: [
                    const Icon(
                      Icons.music_note_outlined,
                      color: Colors.grey,
                      size: 35,
                    ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Playlist',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: white,
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          'Crea una playlist con canciones',
                          style: TextStyle(
                            // fontWeight: FontWeight.w500,
                            color: Colors.grey,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
