import 'dart:math';

import 'package:animate_do/animate_do.dart';
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
    final likedSongs = songService.getLikedSongs();
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
            splashColor: Colors.transparent,
          ),
          IconButton(
            padding: EdgeInsets.zero,
            onPressed: () {
              songService.getPlaylists();
            },
            icon: const Icon(Icons.add, size: 30),
            splashRadius: 20,
            splashColor: Colors.transparent,
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.only(top: 15),
        color: black,
        child: Stack(
          children: [
            SizedBox(
              width: size.width,
              height: size.height,
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      songService.currentPlaylist = likedSongs;
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const PlaylistScreen(),
                        ),
                      );
                    },
                    child: Container(
                      color: Colors.transparent,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 70,
                            height: 70,
                            margin: const EdgeInsets.symmetric(horizontal: 15),
                            child: Image.network(
                              "https://firebasestorage.googleapis.com/v0/b/flutter-music-player-9518c.appspot.com/o/images%2Fliked-songs-300.png?alt=media&token=b89872ec-3c82-4317-831e-651b84606206",
                              fit: BoxFit.cover,
                              loadingBuilder:
                                  (context, child, loadingProgress) =>
                                      Container(
                                color: darkGrey,
                                width: 60,
                                height: 60,
                                child: child,
                              ),
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Tus me gusta',
                                style: TextStyle(color: white, fontSize: 18),
                              ),
                              const SizedBox(height: 5),
                              Row(
                                children: [
                                  Transform.rotate(
                                    angle: .7,
                                    child: const Icon(
                                      Icons.push_pin_rounded,
                                      size: 18,
                                      color: Color(0xff1ed760),
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  Text(
                                    'Playlist • ${likedSongs.length} canciones',
                                    style: const TextStyle(
                                        color: Colors.grey, fontSize: 16),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const Spacer(),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.more_vert,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
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
