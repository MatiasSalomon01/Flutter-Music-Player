import 'package:flutter/material.dart';
import 'package:music_player/constants/constants.dart';
import 'package:music_player/models/playlists.dart';
import 'package:music_player/providers/providers.dart';
import 'package:music_player/screens/playlist_screen.dart';
import 'package:music_player/services/song_service.dart';
import 'package:music_player/utlis/utils.dart';
import 'package:provider/provider.dart';

class PlaylistListTile extends StatelessWidget {
  const PlaylistListTile(
      {super.key, required this.playlist, required this.index});
  final Playlist playlist;
  final int index;

  @override
  Widget build(BuildContext context) {
    final songService = Provider.of<SongService>(context);
    final playlistService = Provider.of<PlaylistService>(context);

    return GestureDetector(
      onTap: () {
        songService.currentPlaylist = playlist.songs;
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => PlaylistScreen(
              playlist: playlist,
              mainColor: Color(int.parse(playlist.mainColor)),
              appBarColor: Color(int.parse(playlist.mainColor) - 30),
            ),
          ),
        );
      },
      onLongPress: () => showPlaylistModal(
        context,
        height: 260,
        child: Column(
          children: [
            ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 10),
              leading: Transform.rotate(
                angle: .7,
                child: const Icon(
                  Icons.push_pin_outlined,
                  size: 30,
                  color: Colors.grey,
                ),
              ),
              title: const Text(
                'Fijar playlist',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: white,
                  fontSize: 20,
                ),
              ),
            ),
            const ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 10),
              leading: Icon(
                Icons.share_outlined,
                size: 30,
                color: Colors.grey,
              ),
              title: Text(
                'Compartir',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: white,
                  fontSize: 20,
                ),
              ),
            ),
            ListTile(
              onTap: () async {
                await playlistService.delete(playlist);
                songService.playlists
                    .removeWhere((element) => element.id == playlist.id);
                var playlists = songService.playlists;
                songService.playlists = playlists;
                Navigator.of(context).pop();
              },
              contentPadding: const EdgeInsets.symmetric(horizontal: 10),
              leading: const Icon(
                Icons.close,
                size: 32,
                color: Colors.grey,
              ),
              title: const Text(
                'Eliminar playlist',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: white,
                  fontSize: 20,
                ),
              ),
            ),
          ],
        ),
      ),
      child: Container(
        color: transparent,
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
                    if (index == 0) ...[
                      Transform.rotate(
                        angle: .7,
                        child: const Icon(
                          Icons.push_pin_rounded,
                          size: 18,
                          color: lightGreen,
                        ),
                      ),
                      const SizedBox(width: 8),
                    ],
                    Text(
                      'Playlist • ${playlist.songs.length} canciones',
                      style: const TextStyle(color: Colors.grey, fontSize: 16),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
