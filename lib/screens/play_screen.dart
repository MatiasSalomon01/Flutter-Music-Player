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
      body: Container(),
    );
  }
}
