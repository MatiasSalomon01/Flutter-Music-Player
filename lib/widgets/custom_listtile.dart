import 'package:flutter/material.dart';
import 'package:music_player/constants/constants.dart';
import 'package:music_player/models/models.dart';
import 'package:music_player/screens/screens.dart';

class CustomListTile extends StatelessWidget {
  final SongModel data;
  const CustomListTile({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => PlayerScreen(song: data),
        ),
      ),
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.network(
          data.albumImage,
          width: 70,
          height: 70,
        ),
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(data.title, style: const TextStyle(color: white)),
          Text(data.artists, style: TextStyle(color: Colors.grey.shade600)),
        ],
      ),
      trailing: IconButton(
        onPressed: () {},
        icon: Icon(
          Icons.more_vert,
          color: Colors.grey.shade600,
        ),
      ),
    );
  }
}
