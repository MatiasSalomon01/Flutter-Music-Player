import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:music_player/constants/constants.dart';
import 'package:music_player/models/models.dart';
import 'package:music_player/providers/audio_provider.dart';
import 'package:music_player/screens/screens.dart';
import 'package:music_player/services/song_service.dart';
import 'package:music_player/widgets/custom_listtile.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isDefault = true;
  late List<SongModel> list;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final songService = Provider.of<SongService>(context);
    final audioProvider = Provider.of<AudioProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: darkGrey,
        centerTitle: true,
        title: const Text('Music Player'),
        actions: [
          IconButton(
            padding: EdgeInsets.zero,
            onPressed: () {},
            icon: const Icon(Icons.history),
            splashRadius: 20,
          ),
        ],
      ),
      body: Container(
        width: size.width,
        height: size.height,
        color: black,
        child: Stack(
          children: [
            Column(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 20),
                  height: 60,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: darkGrey,
                      borderRadius: BorderRadius.circular(100)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ElevatedButton(
                        style: ButtonStyle(
                          splashFactory: NoSplash.splashFactory,
                          backgroundColor: MaterialStateProperty.all(
                              const Color.fromARGB(255, 56, 56, 56)),
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50))),
                        ),
                        onPressed: () => setState(
                            () => songService.songs = songService.songsCopy),
                        child: const Text('Sin Copyright'),
                      ),
                      const SizedBox(width: 20),
                      ElevatedButton(
                        style: ButtonStyle(
                          splashFactory: NoSplash.splashFactory,
                          padding: MaterialStateProperty.all(
                              const EdgeInsets.symmetric(horizontal: 20)),
                          backgroundColor: MaterialStateProperty.all(
                              const Color.fromARGB(255, 56, 56, 56)),
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50))),
                        ),
                        onPressed: () =>
                            setState(() => songService.songs = defaultSongs),
                        child: const Text('De Prueba'),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    itemCount: songService.songs.length,
                    itemBuilder: (context, index) =>
                        CustomListTile(data: songService.songs[index]),
                    separatorBuilder: (context, index) =>
                        const Divider(color: Colors.grey),
                  ),
                ),
                if (songService.currentSong.id.isNotEmpty)
                  const SizedBox(height: 80)
              ],
            ),
            if (songService.currentSong.id.isNotEmpty) ...[
              Positioned(
                bottom: 0,
                child: GestureDetector(
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) =>
                          PlayerScreen(song: songService.currentSong),
                    ),
                  ),
                  child: Container(
                    width: size.width - 20,
                    margin:
                        const EdgeInsets.only(left: 10, right: 10, bottom: 5),
                    padding: const EdgeInsets.only(right: 10, left: 20),
                    height: 70,
                    decoration: BoxDecoration(
                      border: Border.all(color: white, width: .2),
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        image: NetworkImage(
                            songService.currentSong.backgroundImage),
                        fit: BoxFit.cover,
                        // opacity: .5,
                      ),
                    ),
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(songService.currentSong.title,
                                style: const TextStyle(
                                    color: white, fontSize: 18)),
                            Text(songService.currentSong.artists,
                                style: const TextStyle(
                                    color: Color.fromARGB(255, 119, 119, 119),
                                    fontSize: 16)),
                          ],
                        ),
                        const Spacer(),
                        Material(
                          color: Colors.transparent,
                          child: IconButton(
                            splashRadius: 20,
                            highlightColor: darkGrey,
                            onPressed:
                                audioProvider.songState == SongState.isLoading
                                    ? null
                                    : () => audioProvider.songState ==
                                            SongState.isPlaying
                                        ? audioProvider.pause()
                                        : audioProvider.play(),
                            icon: Icon(
                              audioProvider.songState == SongState.isPlaying
                                  ? Icons.pause
                                  : Icons.play_arrow,
                              color: white,
                            ),
                          ),
                        ),
                        Material(
                          color: Colors.transparent,
                          child: IconButton(
                            splashRadius: 20,
                            highlightColor: darkGrey,
                            onPressed: () {
                              songService.currentSong = SongModel.empty();
                              audioProvider.stop();
                            },
                            icon: const Icon(
                              Icons.stop,
                              color: white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ]
          ],
        ),
      ),
    );
  }
}
