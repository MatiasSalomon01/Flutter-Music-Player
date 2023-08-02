import 'package:flutter/material.dart';
import 'package:music_player/widgets/widgets.dart';

class CustomBottomNavigationbar extends StatelessWidget {
  const CustomBottomNavigationbar({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Positioned(
      bottom: 0,
      child: Container(
        height: 65,
        width: size.width,
        padding: const EdgeInsets.only(right: 50, left: 70),
        color: Colors.black.withOpacity(.85),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            BottomItem(
              index: 0,
              icon: Icons.home_filled,
              title: 'Inicio',
            ),
            BottomItem(
              index: 1,
              icon: Icons.search,
              title: 'Buscar',
              padding: const EdgeInsets.only(left: 20),
            ),
            BottomItem(
              index: 2,
              icon: Icons.library_books,
              title: 'Tu biblioteca',
            ),
          ],
        ),
      ),
    );
  }
}
