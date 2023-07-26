import 'package:flutter/material.dart';
import 'package:music_player/constants/constants.dart';
import 'package:music_player/widgets/custom_listtile.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
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
          ],
        ),
      ),
    );
  }
}
