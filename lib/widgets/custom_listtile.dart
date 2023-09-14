import 'package:flutter/material.dart';
import 'package:music_player/constants/constants.dart';
import 'package:music_player/models/models.dart';
import 'package:music_player/providers/providers.dart';
import 'package:music_player/screens/screens.dart';
import 'package:music_player/services/song_service.dart';
import 'package:music_player/utlis/utils.dart';
import 'package:music_player/widgets/widgets.dart';
import 'package:provider/provider.dart';
import '../models/playlists.dart';

class CustomListTile extends StatefulWidget {
  final SongModel data;
  final int index;
  final int length;
  final bool isInPlaylist;
  final int? playlistIndex;
  const CustomListTile(
      {super.key,
      required this.data,
      required this.index,
      required this.length,
      this.isInPlaylist = false,
      this.playlistIndex});

  @override
  State<CustomListTile> createState() => _CustomListTileState();
}

class _CustomListTileState extends State<CustomListTile> {
  bool isActive = false;

  @override
  Widget build(BuildContext context) {
    final songService = Provider.of<SongService>(context);
    return Padding(
      padding: EdgeInsets.only(
          bottom: widget.index == (widget.length - 1)
              ? songService.currentSong.id!.isNotEmpty
                  ? 140
                  : 80
              : 0),
      child: ListTile(
        contentPadding: const EdgeInsets.only(left: 15, right: 0),
        onTap: () {
          var audioProvider =
              Provider.of<AudioProvider>(context, listen: false);

          songService.currentIndex = widget.index;
          if (widget.data.id == songService.currentSong.id) return;

          songService.currentSong = widget.data;
          audioProvider.setUrl = songService.currentSong.url;
          audioProvider.play();
          songService.setCurrentSong();
          setState(() => isActive = !isActive);
        },
        onLongPress: () => showModal(context, widget.data),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: Image.network(
            widget.data.albumImage,
            fit: BoxFit.cover,
            loadingBuilder: (context, child, loadingProgress) =>
                Container(color: darkGrey, width: 60, height: 60, child: child),
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              widget.data.title,
              style: TextStyle(
                  color: widget.data.id == songService.currentSong.id
                      ? lightGreen
                      : white),
            ),
            Text(
              widget.data.artists,
              style: TextStyle(color: Colors.grey.shade600),
            ),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomAnimatedIcon(
                isFavorite: widget.data.isFavorite, id: widget.data.id!),
            IconButton(
              onPressed: () => showModal(context, widget.data),
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

  void showModal(BuildContext context, SongModel song) => showPlaylistModal(
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
                  song.albumImage,
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
                  song.title,
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
              leading: Icon(
                song.isFavorite ? Icons.favorite : Icons.favorite_border,
                size: 30,
                color: song.isFavorite ? Colors.red : Colors.grey,
              ),
              title: Text(
                song.isFavorite ? 'Diste me gusta' : 'Me gusta',
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  color: white,
                  fontSize: 20,
                ),
              ),
              onTap: () async {
                //TODO: refactorizar este metodo
                final songService =
                    Provider.of<SongService>(context, listen: false);

                await songService.updateById(song.id!, !song.isFavorite);
                Navigator.pop(context);
                var x = songService.songs
                    .firstWhere((element) => element.id == song.id);

                if (songService.playlists.isNotEmpty) {
                  var likedSongs = songService.playlists.first;
                  var exists =
                      likedSongs.songs.any((element) => element.id == song.id);
                  if (exists == false && song.isFavorite == true) {
                    likedSongs.songs.add(x);
                    await songService.updateLikedSong(likedSongs);
                  }
                  if (exists == true && song.isFavorite == false) {
                    likedSongs.songs
                        .removeWhere((element) => element.id == song.id);
                    await songService.updateLikedSong(likedSongs);
                  }
                } else {
                  var playlist = Playlist(
                    title: 'Tus me gusta',
                    totalSongs: 1,
                    image:
                        'https://firebasestorage.googleapis.com/v0/b/flutter-music-player-9518c.appspot.com/o/images%2Fliked-songs-300.png?alt=media&token=b89872ec-3c82-4317-831e-651b84606206',
                    albumCover:
                        'https://firebasestorage.googleapis.com/v0/b/flutter-music-player-9518c.appspot.com/o/images%2Falbum-default.png?alt=media&token=e6c6d08e-68dc-4fd4-bcf0-d153f2f1ad25',
                    songs: [x],
                    isPinned: false,
                  );
                  songService.playlists = [playlist];
                  await songService.updateLikedSong(playlist);
                }
              },
            ),
            ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 10),
              leading: !widget.isInPlaylist
                  ? SizedBox(
                      width: 40,
                      child: Stack(
                        children: const [
                          Padding(
                            padding: EdgeInsets.only(left: 6),
                            child: Icon(
                              Icons.music_note_outlined,
                              size: 30,
                              color: Colors.grey,
                            ),
                          ),
                          Positioned(
                            top: -3,
                            left: -4,
                            child: Padding(
                              padding: EdgeInsets.only(left: 3),
                              child: Icon(
                                Icons.add,
                                size: 18,
                                color: Colors.grey,
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  : const Icon(
                      Icons.remove_circle_outline_outlined,
                      size: 30,
                      color: Colors.grey,
                    ),
              title: Text(
                !widget.isInPlaylist
                    ? 'Agregar a playlist'
                    : 'Eliminar de esta playlist',
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  color: white,
                  fontSize: 20,
                ),
              ),
              onTap: () async {
                if (!widget.isInPlaylist) {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          AddToPlaylistScreen(song: widget.data),
                    ),
                  );
                } else {
                  final songService =
                      Provider.of<SongService>(context, listen: false);

                  var playlist = songService.playlists[widget.playlistIndex!];

                  List<SongModel> newSongs = [];
                  bool founded = false;
                  for (var i = 0; i < playlist.songs.length; i++) {
                    if (!founded) {
                      if (playlist.songs[i].id == widget.data.id) {
                        founded = true;
                        continue;
                      } else {
                        newSongs.add(playlist.songs[i]);
                        continue;
                      }
                    } else {
                      newSongs.add(playlist.songs[i]);
                    }
                  }

                  playlist.songs = newSongs;
                  await songService.updatePlaylistsSong(
                      widget.playlistIndex!, playlist);
                  // ignore: use_build_context_synchronously
                  Navigator.pop(context);
                }
              },
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
          ],
        ),
      );
}
