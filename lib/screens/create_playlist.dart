import 'package:auto_size_text_field/auto_size_text_field.dart';
import 'package:flutter/material.dart';
import 'package:music_player/constants/constants.dart';
import 'package:music_player/models/playlists.dart';
import 'package:music_player/services/services.dart';
import 'package:music_player/widgets/stadium_button.dart';
import 'package:provider/provider.dart';

class CreatePlaylist extends StatefulWidget {
  const CreatePlaylist({super.key});

  @override
  State<CreatePlaylist> createState() => _CreatePlaylistState();
}

class _CreatePlaylistState extends State<CreatePlaylist> {
  late final TextEditingController controller;
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    final songService = Provider.of<SongService>(context, listen: false);
    controller = TextEditingController(
        text: 'Mi Playlist #${songService.playlists.length}');

    Future.delayed(Duration.zero, () => _focusNode.requestFocus());

    controller.selection = TextSelection(
      baseOffset: 0,
      extentOffset: controller.text.length,
    );
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final songService = Provider.of<SongService>(context);
    final playlistService = Provider.of<PlaylistService>(context);
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xff7a7a7a), Color(0xff131313)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Ponle nombre a tu playlist',
                style: TextStyle(
                  color: white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 60),
                constraints: const BoxConstraints(maxWidth: 360),
                child: AutoSizeTextField(
                  focusNode: _focusNode,
                  controller: controller,
                  cursorColor: white,
                  minFontSize: 14,
                  maxLines: 1,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.zero,
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: white, width: .3),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: white, width: .3),
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  StadiumButton(
                    text: 'Cancelar',
                    buttonColor: transparent,
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  const SizedBox(width: 25),
                  StadiumButton(
                    text: 'Crear',
                    textColor: black,
                    borderColor: black,
                    onPressed: () async {
                      var playlist = Playlist(
                        title: controller.text,
                        totalSongs: 0,
                        image:
                            'https://firebasestorage.googleapis.com/v0/b/flutter-music-player-9518c.appspot.com/o/images%2FCaptura%20de%20pantalla%202023-08-14%20203624%20(1).png?alt=media&token=49a4d518-aa5e-49ed-ae47-4cd365da11a3',
                        albumCover:
                            'https://firebasestorage.googleapis.com/v0/b/flutter-music-player-9518c.appspot.com/o/images%2Falbum-default.png?alt=media&token=e6c6d08e-68dc-4fd4-bcf0-d153f2f1ad25',
                        songs: [],
                        isPinned: false,
                      );
                      var id = await playlistService.create(playlist);
                      playlist.id = id;
                      songService.addPlaylist(playlist);
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
