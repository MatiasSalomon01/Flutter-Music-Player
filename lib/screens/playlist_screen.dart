import 'package:flutter/material.dart';
import 'package:music_player/constants/constants.dart';
import 'package:music_player/services/song_service.dart';
import 'package:music_player/widgets/widgets.dart';
import 'package:provider/provider.dart';

class PlaylistScreen extends StatefulWidget {
  const PlaylistScreen({super.key, this.photo});
  final Widget? photo;

  @override
  State<PlaylistScreen> createState() => _PlaylistScreenState();
}

class _PlaylistScreenState extends State<PlaylistScreen> {
  ScrollController controller = ScrollController();

  void lsitener() {
    print(controller.offset);
    //160
    //260
  }

  @override
  void initState() {
    controller.addListener(lsitener);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final songService = Provider.of<SongService>(context);
    final likedSongs = songService.getLikedSongs();
    return Scaffold(
      extendBody: true,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xff716d61),
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
              backgroundColor: Colors.transparent,
              flexibleSpace: LayoutBuilder(
                builder: (context, constraints) {
                  return SafeArea(
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        // AnimatedOpacity(
                        //   duration: const Duration(milliseconds: 800),
                        //   curve: Curves.linearToEaseOut,
                        // opacity: controller.offset > 145
                        //     ? 1 - (controller.offset / 100).clamp(0, 1)
                        //     : 1,
                        AnimatedOpacity(
                          duration: const Duration(milliseconds: 200),
                          curve: Curves.linear,
                          opacity: controller.offset > 144
                              ? 1 - (controller.offset / 250).clamp(0, 1)
                              : 1,
                          child: Container(
                            padding: EdgeInsets.only(top: 20),
                            child: AspectRatio(
                              aspectRatio: 1.0,
                              child: Image.network(
                                "https://firebasestorage.googleapis.com/v0/b/flutter-music-player-9518c.appspot.com/o/images%2Fpexels-petr-ganaj-4064305.jpg?alt=media&token=58821401-057f-4bc6-938f-ff87104e3919",
                                fit: BoxFit.cover,
                                // height: 50,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                // width: size.width,
                // height: size.height,

                child: SafeArea(
                  child: Container(
                    child: Column(
                      // mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Tus me gusta',
                              style: TextStyle(
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
                            children: [
                              Icon(
                                Icons.timer_sharp,
                                color: Colors.grey,
                                size: 20,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                '2 h 30 min',
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            const SizedBox(width: 4),
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.download_for_offline_outlined,
                                color: Colors.grey,
                                size: 30,
                              ),
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.group_add_outlined,
                                color: Colors.grey,
                                size: 30,
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
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.shuffle_rounded,
                                color: Colors.grey,
                                size: 25,
                              ),
                            ),
                            const CircleAvatar(
                              backgroundColor: Color(0xff1ed760),
                              radius: 25,
                              child: Icon(
                                Icons.play_arrow,
                                color: black,
                                size: 32,
                              ),
                            ),
                            const SizedBox(width: 10),
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
                          itemCount: likedSongs.length,
                          itemBuilder: (context, index) => CustomListTile(
                            data: likedSongs[index],
                            index: index,
                            length: likedSongs.length,
                          ),
                          separatorBuilder: (context, index) =>
                              const Divider(color: Colors.transparent),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Header extends SliverPersistentHeaderDelegate {
  @override
  double get maxExtent => 290;

  @override
  double get minExtent => 100;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SafeArea(
      child: Container(
        color: Colors.transparent,
        child: AspectRatio(
          aspectRatio: 16 / 9,
          child: Image.network(
            "https://firebasestorage.googleapis.com/v0/b/flutter-music-player-9518c.appspot.com/o/images%2Fpexels-petr-ganaj-4064305.jpg?alt=media&token=58821401-057f-4bc6-938f-ff87104e3919",
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
