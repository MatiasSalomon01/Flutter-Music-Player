import 'package:flutter/material.dart';
import 'package:music_player/colors/colors.dart';
import 'package:music_player/widgets/widgets.dart';

class PlayScreen extends StatelessWidget {
  const PlayScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const CustomAppBar(),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: const [
            AlbumImage(),
            TitleSubTitle(),
            FuntionalityButtons(),
            ProgressBar(),
            MainButtons()
          ],
        ),
      ),
    );
  }
}
