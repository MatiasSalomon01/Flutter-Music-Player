import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:music_player/constants/constants.dart';
import 'package:music_player/models/playlists.dart';
import 'package:music_player/providers/providers.dart';
import 'package:music_player/services/song_service.dart';
import 'package:music_player/widgets/widgets.dart';
import 'package:provider/provider.dart';

//TODO: corregir las posiciones de los widgets con MediaQuery para que sea responseive

class PlaylistScreen extends StatefulWidget {
  const PlaylistScreen({super.key, required this.playlist});
  final Playlist playlist;

  @override
  State<PlaylistScreen> createState() => _PlaylistScreenState();
}

class _PlaylistScreenState extends State<PlaylistScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  ScrollController controller = ScrollController();
  double opacity = 0;
  double addToButton = 0;
  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    controller.addListener(scrollDependantAnimations);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final audioProvider = Provider.of<AudioProvider>(context);
    final songService = Provider.of<SongService>(context);
    final heighttest = MediaQuery.of(context).size.height * .415;

    return FadeInUpBig(
      duration: const Duration(milliseconds: 300),
      from: 100,
      child: Scaffold(
        extendBody: true,
        body: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xff6a6a6a),
                    Color(0xff121212),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.center,
                ),
              ),
              child: CustomScrollView(
                controller: controller,
                slivers: [
                  SliverAppBar(
                    pinned: true,
                    expandedHeight: 280,
                    elevation: 0,
                    backgroundColor: Colors.transparent,
                    flexibleSpace: LayoutBuilder(
                      builder: (context, constraints) {
                        return Stack(
                          alignment: Alignment.center,
                          children: [
                            SafeArea(
                              child: AnimatedOpacity(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.linear,
                                opacity: controller.offset > 160
                                    ? 0
                                    : controller.offset > 144 &&
                                            controller.offset < 160
                                        ? 1 -
                                            (controller.offset / 234)
                                                .clamp(0, 1)
                                        : 1,
                                child: Container(
                                  padding: const EdgeInsets.only(top: 20),
                                  child: AspectRatio(
                                    aspectRatio: 1.0,
                                    child: Image.network(
                                      widget.playlist.image,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 0,
                              child: AnimatedOpacity(
                                duration: const Duration(milliseconds: 400),
                                opacity: opacity,
                                child: Container(
                                  height: kToolbarHeight * 1.7,
                                  padding: const EdgeInsets.only(
                                      left: 50, top: kToolbarHeight),
                                  width: size.width,
                                  color: const Color.fromARGB(255, 59, 59, 59),
                                  child: Text(
                                    widget.playlist.title,
                                    style: const TextStyle(
                                      color: white,
                                      fontSize: 22,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        );
                      },
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: SafeArea(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                widget.playlist.title,
                                style: const TextStyle(
                                    color: white,
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          const SizedBox(height: 15),
                          Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: Row(
                              children: const [
                                Icon(
                                  Icons.timer_sharp,
                                  color: Colors.grey,
                                  size: 20,
                                ),
                                SizedBox(width: 4),
                                Text(
                                  '2 h 30 min',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              const SizedBox(width: 5),
                              IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.sort,
                                  color: Colors.grey,
                                  size: 30,
                                ),
                              ),

                              IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.shuffle_rounded,
                                  color: Colors.grey,
                                  size: 25,
                                ),
                              ),
                              IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.more_vert,
                                  color: Colors.grey,
                                  size: 30,
                                ),
                              ),
                              const Spacer(),
                              // const SizedBox(width: 80),
                            ],
                          ),
                          const SizedBox(height: 20),
                          ListTile(
                            contentPadding:
                                const EdgeInsets.only(left: 15, right: 0),
                            onTap: () {},
                            leading: Container(
                              color: const Color(0xff242424),
                              width: 60,
                              height: 60,
                              child: const Icon(
                                Icons.add,
                                color: Colors.grey,
                                size: 35,
                              ),
                            ),
                            title: const Text(
                              'Agregar a esta playlist',
                              style: TextStyle(color: white),
                            ),
                          ),
                          const Divider(color: Colors.transparent),
                          ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: widget.playlist.songs.length,
                            itemBuilder: (context, index) => CustomListTile(
                              data: widget.playlist.songs[index],
                              index: index,
                              length: widget.playlist.songs.length,
                            ),
                            separatorBuilder: (context, index) =>
                                const Divider(color: Colors.transparent),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (songService.currentSong.id!.isNotEmpty) const Preview(),
            const CustomBottomNavigationbar(),
          ],
        ),
        floatingActionButton: Padding(
          padding: EdgeInsets.only(bottom: heighttest + addToButton),
          child: FloatingActionButton(
            backgroundColor: const Color(0xff1ed760),
            onPressed: audioProvider.songState == SongState.isLoading
                ? null
                : () {
                    if (audioProvider.songState == SongState.isPlaying) {
                      audioProvider.pause();
                    } else {
                      if (!songService.isPlaylists) {
                        songService.isPlaylists = true;
                        songService.currentIndex = 0;
                        songService.currentSong =
                            songService.currentPlaylist[0];
                        audioProvider.setUrl = songService.currentSong.url;
                        audioProvider.play();
                        songService.setCurrentSong();
                      } else {
                        audioProvider.play();
                      }
                    }
                  },
            child: audioProvider.songState == SongState.isLoading
                ? const Padding(
                    padding: EdgeInsets.all(12),
                    child: CircularProgressIndicator(
                      color: black,
                      strokeWidth: 4,
                    ),
                  )
                : Icon(
                    audioProvider.songState == SongState.isPlaying
                        ? Icons.pause
                        : Icons.play_arrow,
                    color: black,
                    size: 32,
                  ),
          ),
        ),
      ),
    );
  }

  void scrollDependantAnimations() {
    //Para el appbar
    if (controller.offset > 287) {
      opacity = 1;
    } else {
      opacity = 0;
    }

    //Para la foto
    if (controller.offset > 264) {
      _animationController.forward();
    } else {
      if (_animationController.isCompleted) {
        _animationController.reverse();
      }
    }

    //Para de play/pause
    if (controller.offset < 356) {
      addToButton = controller.offset;
    } else {
      addToButton = 356;
    }

    setState(() {});
  }
}
