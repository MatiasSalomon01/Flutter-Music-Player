import 'package:flutter/material.dart';
import 'package:music_player/constants/constants.dart';
import 'package:music_player/providers/providers.dart';
import 'package:music_player/screens/screens.dart';
import 'package:provider/provider.dart';

class BottomItem extends StatelessWidget {
  final int index;
  final String title;
  final IconData icon;
  final EdgeInsets padding;
  const BottomItem({
    super.key,
    required this.index,
    required this.title,
    required this.icon,
    this.padding = EdgeInsets.zero,
  });

  @override
  Widget build(BuildContext context) {
    final bottomProvider = Provider.of<BottomNavigationProvider>(context);
    return GestureDetector(
      onTap: () => onTap(context, bottomProvider),
      child: Padding(
        padding: padding,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: bottomProvider.currentScreenIndex != index ? 28 : 29,
              color: bottomProvider.currentScreenIndex != index
                  ? Colors.grey
                  : white,
            ),
            Text(
              title,
              style: TextStyle(
                color: bottomProvider.currentScreenIndex != index
                    ? Colors.grey
                    : white,
                fontSize:
                    bottomProvider.currentScreenIndex != index ? 12 : 12.5,
                fontWeight: FontWeight.w300,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onTap(BuildContext context, BottomNavigationProvider bottomProvider) {
    bottomProvider.currentScreenIndex = index;
    if (index == 0) {
      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          pageBuilder: (_, __, ___) => const HomeScreen(),
          transitionDuration: const Duration(milliseconds: 300),
          reverseTransitionDuration: const Duration(milliseconds: 150),
          transitionsBuilder: (_, animation, __, child) {
            return FadeTransition(
              opacity: Tween<double>(begin: 0.1, end: 1).animate(
                CurvedAnimation(parent: animation, curve: Curves.bounceInOut),
              ),
              child: child,
            );
          },
        ),
      );
    }
    if (index == 1) {
      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          pageBuilder: (_, __, ___) => const SearchScreen(),
          transitionDuration: const Duration(milliseconds: 300),
          reverseTransitionDuration: const Duration(milliseconds: 150),
          transitionsBuilder: (_, animation, __, child) {
            return FadeTransition(
              opacity: Tween<double>(begin: 0.01, end: 1).animate(
                CurvedAnimation(
                    parent: animation, curve: Curves.linearToEaseOut),
              ),
              child: child,
            );
          },
        ),
      );
    }
    if (index == 2) {
      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          pageBuilder: (_, __, ___) => const YourLibraryScreen(),
          transitionDuration: const Duration(milliseconds: 300),
          reverseTransitionDuration: const Duration(milliseconds: 150),
          transitionsBuilder: (_, animation, __, child) {
            return FadeTransition(
              opacity: Tween<double>(begin: 0.01, end: 1).animate(
                CurvedAnimation(parent: animation, curve: Curves.decelerate),
              ),
              child: child,
            );
          },
        ),
      );
    }
  }
}
