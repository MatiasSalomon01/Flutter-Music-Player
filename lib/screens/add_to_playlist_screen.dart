import 'package:flutter/material.dart';
import 'package:music_player/constants/constants.dart';
import 'package:music_player/widgets/widgets.dart';

import '../colors/colors.dart';

class AddToPlaylistScreen extends StatelessWidget {
  const AddToPlaylistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: Text(
          'Agregar a playlist',
          style: TextStyle(
            color: AppColors.background,
            fontWeight: FontWeight.w700,
          ),
        ),
        icon: Icons.arrow_back_outlined,
        showAction: false,
      ),
      backgroundColor: const Color(0xff121212),
    );
  }
}
