import 'package:flutter/material.dart';
import 'package:music_player/constants/constants.dart';
import 'package:music_player/models/models.dart';
import 'package:music_player/services/song_service.dart';
import 'package:music_player/widgets/widgets.dart';
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
        automaticallyImplyLeading: false,
      ),
      body: Container(
        width: size.width,
        height: size.height,
        color: black,
        padding: const EdgeInsets.only(top: 15),
        child: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    itemCount: songService.songs.length,
                    itemBuilder: (context, index) => CustomListTile(
                      data: songService.songs[index],
                      index: index,
                      length: songService.songs.length,
                    ),
                    separatorBuilder: (context, index) =>
                        const Divider(color: transparent),
                  ),
                ),
              ],
            ),
            if (songService.currentSong.id!.isNotEmpty) const Preview(),
            const CustomBottomNavigationbar(),
          ],
        ),
      ),
    );
  }
}
