import 'package:flutter/material.dart';
import 'package:music_player/colors/colors.dart';
import 'package:music_player/constants/constants.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget title;
  final IconData icon;
  final bool showAction;
  const CustomAppBar({
    super.key,
    required this.title,
    this.icon = Icons.keyboard_arrow_down_rounded,
    this.showAction = true,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: transparent,
      elevation: 0,
      leading: GestureDetector(
        onTap: () => Navigator.of(context).pop(),
        child: Icon(
          icon,
          color: AppColors.background,
          size: 30,
        ),
      ),
      centerTitle: true,
      title: title,
      actions: [
        showAction
            ? Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Icon(
                  Icons.more_vert_rounded,
                  color: AppColors.background,
                  size: 28,
                ),
              )
            : Container()
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
