import 'package:flutter/material.dart';
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
              size: 28,
              color: Colors.grey,
            ),
            Text(
              title,
              style: TextStyle(color: Colors.grey, fontSize: 12),
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
          MaterialPageRoute(builder: (context) => const HomeScreen()));
    }
    if (index == 1) {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const SearchScreen()));
    }
    if (index == 2) {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const YourLibraryScreen()));
    }
  }
}
