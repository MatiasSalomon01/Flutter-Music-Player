import 'package:flutter/material.dart';
import 'package:music_player/screens/screens.dart';
import 'package:music_player/theme/themedata.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const PlayScreen(),
      theme: CustomThemeData.themeData,
    );
  }
}
