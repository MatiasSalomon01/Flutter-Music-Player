import 'package:flutter/material.dart';
import 'package:music_player/colors/colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.appBarBackground,
      elevation: 0,
      leading: Icon(
        Icons.keyboard_arrow_down_rounded,
        color: AppColors.black,
        size: 30,
      ),
      centerTitle: true,
      title: Text(
        'Let There Be Rock',
        style: TextStyle(color: AppColors.black),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 8),
          child: Icon(
            Icons.more_vert_rounded,
            color: AppColors.black,
            size: 28,
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
