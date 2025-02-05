import 'package:demo_byteark_player_flutter_integration/player_playlist_screen.dart';
import 'package:flutter/material.dart';

void main(List<String> args) {
  runApp(DemoApp(demoScreen: PlayerPlaylistScreen()));
}

class DemoApp extends StatelessWidget {
  final Widget demoScreen;

  const DemoApp({super.key, required this.demoScreen});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ByteArk Player Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: demoScreen,
    );
  }
}