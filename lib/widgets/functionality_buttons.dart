import 'package:flutter/material.dart';
import 'package:music_player/colors/colors.dart';

class FuntionalityButtons extends StatelessWidget {
  const FuntionalityButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(.2),
        borderRadius: BorderRadius.circular(50),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.shuffle_outlined,
                size: 25, color: AppColors.background),
            padding: EdgeInsets.zero,
            splashRadius: 20,
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.folder_open_outlined,
                size: 25, color: AppColors.background),
            padding: EdgeInsets.zero,
            splashRadius: 20,
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.download, size: 25, color: AppColors.background),
            padding: EdgeInsets.zero,
            splashRadius: 20,
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.repeat, size: 25, color: AppColors.background),
            padding: EdgeInsets.zero,
            splashRadius: 20,
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.favorite_outline,
                size: 25, color: AppColors.background),
            padding: EdgeInsets.zero,
            splashRadius: 20,
          ),
        ],
      ),
    );
  }
}
