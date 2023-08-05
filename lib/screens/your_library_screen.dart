import 'package:animate_do/animate_do.dart';
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
    final likedSongs = songService.getLikedSongs();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: darkGrey,
        title: Row(
          children: const [
            CircleAvatar(
              backgroundColor: Colors.grey,
              radius: 20,
              child: Text(
                'M',
                style: TextStyle(color: black, fontSize: 20),
              ),
            ),
            SizedBox(width: 10),
            Text('Tu biblioteca'),
          ],
        ),
      ),
      body: Container(
        padding: EdgeInsets.only(top: 15),
        color: black,
        child: Stack(
          children: [
            ListView.separated(
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
            if (songService.currentSong.id!.isNotEmpty) const Preview(),
            const CustomBottomNavigationbar(),
          ],
        ),
      ),
    );
  }
}
