import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:music_player/constants/constants.dart';
import 'package:music_player/models/models.dart';
import 'package:music_player/providers/providers.dart';
import 'package:music_player/screens/screens.dart';
import 'package:music_player/services/song_service.dart';
import 'package:music_player/widgets/widgets.dart';
import 'package:provider/provider.dart';

class CustomListTile extends StatefulWidget {
  final SongModel data;
  final int index;
  final int length;
  const CustomListTile({
    super.key,
    required this.data,
    required this.index,
    required this.length,
  });

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
          setState(() {
            isActive = !isActive;
          });
        },
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
            Text(widget.data.title,
                style: TextStyle(
                    color: widget.data.id == songService.currentSong.id
                        ? lightGreen
                        : white)),
            Text(widget.data.artists,
                style: TextStyle(color: Colors.grey.shade600)),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomAnimatedIcon(
                isFavorite: widget.data.isFavorite, id: widget.data.id!),
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
