import 'package:music_player/constants/constants.dart';
import 'package:music_player/models/playlists.dart';
import 'package:music_player/screens/playlist_screen.dart';
import 'package:music_player/services/song_service.dart';
import 'package:music_player/utlis/utils.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class PlaylistListTile extends StatelessWidget {
  final Playlist playlist;
  final int index;

  const PlaylistListTile({
    super.key,
    required this.playlist,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final songService = Provider.of<SongService>(context);
    return GestureDetector(
      onTap: () => goToPlaylistScreen(context, songService),
      onLongPress: () => showModal(context, playlist),
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
                SizedBox(
                  width: MediaQuery.of(context).size.width * .75,
                  child: Text(
                    playlist.title,
                    style: const TextStyle(
                      color: white,
                      fontSize: 18,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
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

  void goToPlaylistScreen(BuildContext context, SongService songService) {
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
  }

  void showModal(BuildContext context, Playlist playlist) => showPlaylistModal(
        context,
        height: 310,
        header: Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            children: [
              Container(
                width: 55,
                height: 55,
                margin: const EdgeInsets.symmetric(horizontal: 15),
                child: Image.network(
                  playlist.image,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) =>
                      Container(
                    color: darkGrey,
                    width: 55,
                    height: 55,
                    child: child,
                  ),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * .75,
                child: Text(
                  playlist.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    color: white,
                    fontSize: 20,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          ),
        ),
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
              onTap: () async => await showDeleteModal(context, playlist),
            ),
          ],
        ),
      );
}
