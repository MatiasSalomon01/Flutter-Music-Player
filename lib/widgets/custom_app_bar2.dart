import 'package:flutter/material.dart';
import 'package:music_player/constants/constants.dart';
import 'package:music_player/screens/screens.dart';
import 'package:music_player/utlis/utils.dart';

class CustomAppBar2 extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar2({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: darkGrey,
      title: Row(
        children: const [
          CircleAvatar(
            backgroundColor: Colors.grey,
            radius: 18,
            child: Text(
              'M',
              style: TextStyle(color: black, fontSize: 20),
            ),
          ),
          SizedBox(width: 10),
          Text('Tu biblioteca'),
        ],
      ),
      actions: [
        IconButton(
          padding: EdgeInsets.zero,
          onPressed: () {},
          icon: const Icon(Icons.search_outlined),
          splashRadius: 20,
          splashColor: transparent,
        ),
        IconButton(
          padding: EdgeInsets.zero,
          onPressed: () => showPlaylistModal(
            height: 180,
            context,
            header: Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: const Text(
                'Crear',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: white,
                  fontSize: 18,
                ),
              ),
            ),
            child: InkWell(
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const CreatePlaylist(),
                  ),
                );
              },
              child: Row(
                children: [
                  const Icon(
                    Icons.music_note_outlined,
                    color: Colors.grey,
                    size: 35,
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Playlist',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: white,
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        'Crea una playlist con canciones',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          icon: const Icon(Icons.add, size: 30),
          splashRadius: 20,
          splashColor: transparent,
        ),
      ],
      automaticallyImplyLeading: false,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
