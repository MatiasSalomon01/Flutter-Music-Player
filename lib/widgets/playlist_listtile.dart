import 'package:flutter/material.dart';
import 'package:music_player/constants/constants.dart';
import 'package:music_player/models/playlists.dart';
import 'package:music_player/screens/playlist_screen.dart';
import 'package:music_player/services/song_service.dart';
import 'package:provider/provider.dart';

class PlaylistListTile extends StatelessWidget {
  const PlaylistListTile(
      {super.key, required this.playlist, required this.index});
  final Playlist playlist;
  final int index;

  @override
  Widget build(BuildContext context) {
    final songService = Provider.of<SongService>(context);

    return GestureDetector(
      onTap: () {
        songService.currentPlaylist = playlist.songs;
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => PlaylistScreen(playlist: playlist),
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
                playlist.image,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) => Container(
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
                Text(
                  playlist.title,
                  style: const TextStyle(color: white, fontSize: 18),
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    if (index == 0)
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
                      'Playlist • ${playlist.songs.length} canciones',
                      style: const TextStyle(color: Colors.grey, fontSize: 16),
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
    );
  }
}
