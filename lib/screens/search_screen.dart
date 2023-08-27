import 'package:flutter/material.dart';
import 'package:music_player/widgets/widgets.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: Stack(
        children: [
          Center(
            child: Text('SearchScreen'),
          ),
          const CustomBottomNavigationbar(),
        ],
      ),
    );
  }
}
