import 'package:flutter/material.dart';
import 'package:music_player/widgets/widgets.dart';

class YourLibraryScreen extends StatelessWidget {
  const YourLibraryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Text('YourLibraryScreen'),
          ),
          const CustomBottomNavigationbar(),
        ],
      ),
    );
  }
}
