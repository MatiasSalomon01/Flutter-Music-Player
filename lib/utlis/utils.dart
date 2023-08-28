import 'package:music_player/constants/constants.dart';
import 'package:music_player/models/playlists.dart';
import 'package:music_player/services/services.dart';
import 'package:music_player/widgets/widgets.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

Future showPlaylistModal(
  BuildContext context, {
  Widget header = const SizedBox(height: 10),
  double height = 500,
  Widget child = const SizedBox(),
}) {
  return showModalBottomSheet(
    context: context,
    backgroundColor: transparent,
    builder: (context) => Container(
      height: height,
      decoration: const BoxDecoration(
        color: gray,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(15),
        ),
      ),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            width: 40,
            height: 5,
            decoration: const BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.horizontal(
                left: Radius.circular(25),
                right: Radius.circular(25),
              ),
            ),
          ),
          header,
          const Divider(color: white, thickness: .1),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: child,
          ),
        ],
      ),
    ),
  );
}

Future showDeleteModal(BuildContext context, Playlist playlist) {
  Navigator.of(context).pop();
  final playlistService = Provider.of<PlaylistService>(context, listen: false);
  final songService = Provider.of<SongService>(context, listen: false);
  return showDialog(
    context: context,
    builder: (context) => Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      shadowColor: transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 50),
            const Text(
              'Eliminar playlist',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 25),
            Text(
              '¿Confirmas que quieres eliminar ${playlist.title}?',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 50),
            StadiumButton(
                text: 'Eliminar',
                textColor: black,
                onPressed: () async {
                  await playlistService.delete(playlist);
                  songService.playlists
                      .removeWhere((element) => element.id == playlist.id);
                  var playlists = songService.playlists;
                  songService.playlists = playlists;
                  Navigator.of(context).pop(); //modal
                }),
            StadiumButton(
              text: 'Cancelar',
              textColor: black,
              buttonColor: white,
              onPressed: () => Navigator.of(context).pop(),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    ),
  );
}
