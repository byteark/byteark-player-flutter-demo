import 'package:byteark_player_flutter/data/byteark_player_license_key.dart';
import 'package:byteark_player_flutter/data/byteark_player_media_track.dart';
import 'package:byteark_player_flutter/data/byteark_player_subtitle_size.dart';
import 'package:byteark_player_flutter/domain/byteark_player_listener.dart';
import 'package:flutter/material.dart';
import 'package:byteark_player_flutter/data/byteark_player_config.dart';
import 'package:byteark_player_flutter/data/byteark_player_item.dart';
import 'package:byteark_player_flutter/presentation/byteark_player.dart';

class PlayerSwitchMedia extends StatefulWidget {
  const PlayerSwitchMedia({super.key});

  @override
  State<PlayerSwitchMedia> createState() => _PlayerSwitchMedia();
}

class _PlayerSwitchMedia extends State<PlayerSwitchMedia> {
  late ByteArkPlayerItem _item1;
  late ByteArkPlayerItem _item2;
  late ByteArkPlayerConfig _config1;
  late ByteArkPlayerConfig _config2;
  late ByteArkPlayer _player;

  ByteArkPlayerMediaTrack? _currentSubtitle;
  ByteArkPlayerMediaTrack? _currentAudio;
  final String _androidKey = "ANDROID_KEY";
  final String _iosKey = "iOS_KEY";

  @override
  void initState() {
    // Step 1: Set ByteArkPlayerItem.
    _item1 = ByteArkPlayerItem(
        url:
            "https://byteark-slehxnn9ug5e.stream-playlist.byteark.com/streams/UcPGuuSYjy27/playlist.m3u8");
    _item2 = ByteArkPlayerItem(
        url:
            "https://byteark-slehxnn9ug5e.stream-playlist.byteark.com/streams/UcPGuuSYjy27/playlist.m3u8");

    // Step 2: Set ByteArkPlayerConfig.
    _config1 = ByteArkPlayerConfig(
      licenseKey: ByteArkPlayerLicenseKey(android: _androidKey, iOS: _iosKey),
      playerItem: _item1,
      subtitleSize:
          ByteArkPlayerSubtitleSize.tiny, // Use medium size instead of tiny
      subtitleBackgroundEnabled: true, // Keep subtitle background enabled
    );
    _config2 = ByteArkPlayerConfig(
      licenseKey: ByteArkPlayerLicenseKey(android: _androidKey, iOS: _iosKey),
      playerItem: _item2,
      subtitleSize:
          ByteArkPlayerSubtitleSize.tiny, // Use medium size instead of tiny
      subtitleBackgroundEnabled: true, // Keep subtitle background enabled
    );

    _player = ByteArkPlayer(
      playerConfig: _config1,
      listener: ByteArkPlayerListener(
        onPlayerReady: () {
          if (_currentSubtitle != null) {
            _player.setSubtitle(_currentSubtitle!);
          }
          if (_currentAudio != null) {
            _player.setAudio(_currentAudio!);
          }
        },
        onPlaybackTimeupdate: () async {
          _currentSubtitle = await _player.getCurrentSubtitle();
          _currentAudio = await _player.getCurrentAudio();
        },
      ),
    );
    super.initState();
  }

  @override
  void dispose() {
    // _player.dispose();
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
        body: SingleChildScrollView(
          child: Column(
            children: [
              // Step 3: Embed ByteArk Player widget.
              AspectRatio(
                aspectRatio: 9 / 16,
                child: _player,
              ),
              ElevatedButton(
                onPressed: () => _player.switchMediaSource(_config2),
                child: const Text("Switch Media"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
