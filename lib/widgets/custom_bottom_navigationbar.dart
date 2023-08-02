import 'package:flutter/material.dart';

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
        color: Colors.black.withOpacity(.9),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(
                  Icons.home_filled,
                  size: 28,
                  color: Colors.grey,
                ),
                Text(
                  'Inicio',
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ],
            ),
            // SizedBox(width: 1),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.search,
                    size: 28,
                    color: Colors.grey,
                  ),
                  Text(
                    'Buscar',
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.library_books,
                  size: 28,
                  color: Colors.grey,
                ),
                Text(
                  'Tu biblioteca',
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
