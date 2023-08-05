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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: darkGrey,
        title: Row(
          children: [
            CircleAvatar(
              backgroundColor: white,
              radius: 20,
              child: const Text('M'),
            ),
            SizedBox(width: 10),
            const Text('Tu biblioteca'),
          ],
        ),
      ),
      body: Container(
        color: black,
        child: Stack(
          children: [
            Center(
              child: Text('YourLibraryScreen'),
            ),
            const CustomBottomNavigationbar(),
          ],
        ),
      ),
    );
  }
}
