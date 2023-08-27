import 'package:flutter/material.dart';
import 'package:music_player/screens/screens.dart';
import 'package:music_player/theme/themedata.dart';
import 'package:provider/provider.dart';
import 'services/services.dart';

void main() {
  runApp(const AppState());
}

class AppState extends StatelessWidget {
  const AppState({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => SongProvider()),
        ChangeNotifierProvider(create: (context) => SongService()),
        ChangeNotifierProvider(create: (context) => AudioProvider()),
        ChangeNotifierProvider(create: (context) => BottomNavigationProvider()),
        ChangeNotifierProvider(create: (context) => PlaylistService()),
      ],
      child: const MainApp(),
    );
  }
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
      theme: CustomThemeData.themeData,
    );
  }
}
