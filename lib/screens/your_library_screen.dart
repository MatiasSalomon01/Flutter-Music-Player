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
            splashColor: Colors.transparent,
          ),
          IconButton(
            padding: EdgeInsets.zero,
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  backgroundColor: Colors.transparent,
                  content: Stack(
                    children: [
                      Positioned(
                        bottom: 0,
                        child: SlideInUp(
                          duration: const Duration(milliseconds: 200),
                          child: Container(
                            height: 200,
                            width: size.width,
                            decoration: const BoxDecoration(
                              color: Color(0xff242424),
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(15),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
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
}
