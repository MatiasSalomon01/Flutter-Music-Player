import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:music_player/colors/colors.dart';
import 'package:music_player/widgets/widgets.dart';

class PlayScreen extends StatelessWidget {
  const PlayScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      extendBodyBehindAppBar: true,
      appBar: const CustomAppBar(),
      body: Container(
        padding: EdgeInsets.only(top: kToolbarHeight),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/acdc.jpg'),
            fit: BoxFit.fill,
          ),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: Column(
            children: [
              AlbumImage(),
              TitleSubTitle(),
              FuntionalityButtons(),
              ProgressBar(),
              MainButtons(),
            ],
          ),
        ),
      ),
    );
  }
}
