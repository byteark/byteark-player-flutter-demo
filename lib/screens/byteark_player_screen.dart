import 'package:byteark_player_flutter/data/byteark_player_config.dart';
import 'package:byteark_player_flutter/presentation/byteark_player.dart';
import 'package:flutter/material.dart';

class ByteArkPlayerScreen extends StatefulWidget {
  final ByteArkPlayerConfig config;

  const ByteArkPlayerScreen({super.key, required this.config});

  @override
  State<ByteArkPlayerScreen> createState() => _ByteArkPlayerScreenState();
}

class _ByteArkPlayerScreenState extends State<ByteArkPlayerScreen> {
  late ByteArkPlayer _player;
  @override
  void initState() {
    _player = ByteArkPlayer(
      playerConfig: widget.config,
    );
    super.initState();
  }

  void _toggleFullScreen() {
    _player.toggleFullScreen(); // Call when needed (e.g., on a button press)
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _player,
      floatingActionButton: FloatingActionButton(
        onPressed: _toggleFullScreen,
        child: Icon(Icons.fullscreen),
      ),
    );
  }
}
