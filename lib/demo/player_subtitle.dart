import 'package:byteark_player_flutter/data/byteark_player_license_key.dart';
import 'package:byteark_player_flutter/data/byteark_player_subtitle_size.dart';
import 'package:flutter/material.dart';
import 'package:byteark_player_flutter/data/byteark_player_config.dart';
import 'package:byteark_player_flutter/data/byteark_player_item.dart';
import 'package:byteark_player_flutter/presentation/byteark_player.dart';

class PlayerSubtitle extends StatefulWidget {
  const PlayerSubtitle({super.key});

  @override
  State<PlayerSubtitle> createState() => _PlayerSubtitle();
}

class _PlayerSubtitle extends State<PlayerSubtitle> {
  late ByteArkPlayerItem _item;
  late ByteArkPlayerConfig _config;
  late ByteArkPlayer _player;

  @override
  void initState() {
    // Step 1: Set ByteArkPlayerItem.
    _item = ByteArkPlayerItem(
        url:
            "https://byteark-playertzxedwv.stream-playlist.byteark.com/streams/TZyZhhLbiVxG/playlist.m3u8");

    // Step 2: Set ByteArkPlayerConfig.
    _config = ByteArkPlayerConfig(
      licenseKey:
          ByteArkPlayerLicenseKey(android: "ANDROID_KEY", iOS: "iOS_KEY"),
      playerItem: _item,
      subtitleSize: ByteArkPlayerSubtitleSize.medium, // Set subtitle size
      subtitleBackgroundEnabled: true, // Set subtitle background enable/disable
    );

    // Step 3: Set ByteArkPlayer.
    _player = ByteArkPlayer(playerConfig: _config, height: 300);
    super.initState();
  }

  @override
  void dispose() {
    // Dispose to free resources.
    _player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
              child: _player,
            ),
          ],
        ),
      ),
    );
  }
}
