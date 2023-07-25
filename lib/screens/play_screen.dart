import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:music_player/colors/colors.dart';
import 'package:music_player/widgets/widgets.dart';

class PlayerScreen extends StatelessWidget {
  const PlayerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      extendBodyBehindAppBar: true,
      appBar: const CustomAppBar(),
      body: Container(
        padding: const EdgeInsets.only(top: kToolbarHeight),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/acdc.jpg'),
            fit: BoxFit.fill,
          ),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 25, sigmaY: 25),
          child: Column(
            children: const [
              AlbumImage(),
              Spacer(),
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
