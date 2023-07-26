import 'package:flutter/material.dart';
import 'package:music_player/colors/colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  const CustomAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: GestureDetector(
        onTap: () => Navigator.of(context).pop(),
        child: Icon(
          Icons.keyboard_arrow_down_rounded,
          color: AppColors.background,
          size: 30,
        ),
      ),
      centerTitle: true,
      title: Text(
        title,
        style: TextStyle(color: AppColors.background),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 8),
          child: Icon(
            Icons.more_vert_rounded,
            color: AppColors.background,
            size: 28,
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
