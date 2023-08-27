import 'package:auto_size_text_field/auto_size_text_field.dart';
import 'package:flutter/material.dart';
import 'package:music_player/constants/constants.dart';

class CreatePlaylist extends StatefulWidget {
  const CreatePlaylist({super.key});

  @override
  State<CreatePlaylist> createState() => _CreatePlaylistState();
}

class _CreatePlaylistState extends State<CreatePlaylist> {
  late final TextEditingController controller;

  @override
  void initState() {
    controller = TextEditingController(text: 'Mi Playlist #1');
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                  MaterialButton(
                    onPressed: () {},
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 15,
                    ),
                    splashColor: transparent,
                    highlightColor: transparent,
                    elevation: 0,
                    shape: const StadiumBorder(
                      side: BorderSide(color: white, width: .3),
                    ),
                    child: const Text(
                      'Cancelar',
                      style: TextStyle(
                        color: white,
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const SizedBox(width: 25),
                  MaterialButton(
                    onPressed: () {},
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 15,
                    ),
                    splashColor: transparent,
                    highlightColor: transparent,
                    color: lightGreen,
                    elevation: 0,
                    shape: const StadiumBorder(
                      side: BorderSide(color: black, width: .3),
                    ),
                    child: const Text(
                      'Crear',
                      style: TextStyle(
                        color: black,
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
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
