import 'package:byteark_player_flutter/data/byteark_player_license_key.dart';
import 'package:byteark_player_flutter/domain/method_channel/byteark_player_controller.dart';
import 'package:flutter/material.dart';
import 'package:byteark_player_flutter/data/byteark_player_config.dart';
import 'package:byteark_player_flutter/data/byteark_player_item.dart';
import 'package:byteark_player_flutter/presentation/byteark_player.dart';

class PlayerSecureSurface extends StatefulWidget {
  const PlayerSecureSurface({super.key});

  @override
  State<PlayerSecureSurface> createState() => _PlayerSecureSurface();
}

class _PlayerSecureSurface extends State<PlayerSecureSurface> {
  late ByteArkPlayerController _controller;

  @override
  void initState() {
    // Initialize the ByteArkPlayerController.
    _controller = ByteArkPlayerController();
    super.initState();
  }

  @override
  void dispose() {
    // Dispose of the ByteArkPlayerController to free resources.
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Step 1: Set ByteArkPlayerItem.
    var playerItem = ByteArkPlayerItem(
        url:
            "https://byteark-playertzxedwv.stream-playlist.byteark.com/streams/TZyZheqEJUwC/playlist.m3u8");

    // Step 2: Set ByteArkPlayerConfig.
    var playerConfig = ByteArkPlayerConfig(
      licenseKey: ByteArkPlayerLicenseKey(
          android: "CB4E8F-56012D-E75703-16EB94-EA6483-V3",
          iOS: "86EC30-D3FE67-0E254F-18EC9C-EEEF5E-V3"),
      playerItem: playerItem,
      secureSurface:
          true, // Set secure surface to true to prevent screen capture or video recording.
    );

    return MaterialApp(
      title: 'ByteArk Player Subtitle Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('ByteArk Player Demo'),
          centerTitle: true,
        ),
        body: Column(
          children: [
            // Step 3: Embed ByteArk Player widget.
            AspectRatio(
              aspectRatio: 16 / 9,
              child: ByteArkPlayer(
                playerConfig: playerConfig,
                height: 300,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
