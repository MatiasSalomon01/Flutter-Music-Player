import 'package:flutter/material.dart';
import 'package:music_player/constants/constants.dart';
import 'package:music_player/services/song_service.dart';
import 'package:music_player/widgets/custom_listtile.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isDefault = false;
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
      ),
      body: Container(
        width: size.width,
        height: size.height,
        color: black,
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () => setState(() => isDefault = true),
                    child: Text('Canciones Sin Copyright'),
                  ),
                  ElevatedButton(
                    onPressed: () => setState(() => isDefault = false),
                    child: Text('Canciones de Prueba'),
                  )
                ],
              ),
            ),
            if (!isDefault) ...[
              Expanded(
                child: ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  itemCount: defaultSongs.length,
                  itemBuilder: (context, index) =>
                      CustomListTile(data: defaultSongs[index]),
                  separatorBuilder: (context, index) =>
                      const Divider(color: Colors.grey),
                ),
              )
            ] else ...[
              Expanded(
                child: ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  itemCount: songService.songs.length,
                  itemBuilder: (context, index) =>
                      CustomListTile(data: songService.songs[index]),
                  separatorBuilder: (context, index) =>
                      const Divider(color: Colors.grey),
                ),
              )
            ],
          ],
        ),
      ),
    );
  }
}
