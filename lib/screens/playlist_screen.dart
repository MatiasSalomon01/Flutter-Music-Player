import 'package:animate_do/animate_do.dart';
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

class _PlaylistScreenState extends State<PlaylistScreen>
    with SingleTickerProviderStateMixin {
  ScrollController controller = ScrollController();
  late AnimationController _animationController;
  double opacity = 0;
  double heighttest = 0;
  double addToButton = 0;
  void lsitener() {
    print(controller.offset);

    if (controller.offset > 287) {
      opacity = 1;
    } else {
      opacity = 0;
    }
    if (controller.offset > 264) {
      _animationController.forward();
    } else {
      if (_animationController.isCompleted) {
        _animationController.reverse();
      }
    }

    if (controller.offset < 356) {
      addToButton = controller.offset;
    } else {
      addToButton = 356;
    }
    setState(() {});
  }

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
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
    heighttest = MediaQuery.of(context).size.height * .415;
    ;
    return FadeInUpBig(
      duration: const Duration(milliseconds: 300),
      from: 100,
      child: Scaffold(
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
                                    ? 1 - (controller.offset / 234).clamp(0, 1)
                                    : 1,
                            child: Container(
                              padding: const EdgeInsets.only(top: 20),
                              child: AspectRatio(
                                aspectRatio: 1.0,
                                child: Image.network(
                                  "https://firebasestorage.googleapis.com/v0/b/flutter-music-player-9518c.appspot.com/o/images%2Fliked-songs-300.png?alt=media&token=b89872ec-3c82-4317-831e-651b84606206",
                                  fit: BoxFit.cover,
                                  // height: 50,
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
                              // color: Color.fromARGB(255, 88, 85, 76),
                              color: const Color.fromARGB(255, 58, 56, 50),
                              child: const Text(
                                'Tus me gusta',
                                style: TextStyle(
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
                      const Padding(
                        padding: EdgeInsets.only(left: 15),
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
                                  fontWeight: FontWeight.w400),
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
            ],
          ),
        ),
        floatingActionButton: Padding(
          padding: EdgeInsets.only(bottom: heighttest + addToButton),
          child: FloatingActionButton(
            backgroundColor: const Color(0xff1ed760),
            onPressed: () {},
            child: Icon(
              Icons.play_arrow,
              color: black,
              size: 32,
            ),
          ),
        ),
        // floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
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
