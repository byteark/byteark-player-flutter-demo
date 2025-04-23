import 'dart:async';
import 'dart:convert';

import 'package:byteark_player_flutter/data/byteark_player_event_types.dart';
import 'package:byteark_player_flutter/data/byteark_player_license_key.dart';
import 'package:byteark_player_flutter/data/byteark_player_media_track.dart';
import 'package:byteark_player_flutter/data/byteark_player_native_event.dart';
import 'package:byteark_player_flutter/data/byteark_player_subtitle_size.dart';
import 'package:byteark_player_flutter/domain/event_channel/byteark_player_event_channel.dart';
import 'package:byteark_player_flutter/domain/method_channel/byteark_player_controller.dart';
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
  late ByteArkPlayerController _controller;
  late StreamSubscription<dynamic>? _subscription;
  ByteArkPlayerMediaTrack? _currentSubtitle;
  ByteArkPlayerMediaTrack? _currentAudio;
  final String _androidKey = "";
  final String _iosKey = "";

  @override
  void initState() {
    // Initialize the ByteArkPlayerController.
    _controller = ByteArkPlayerController();
    _subscription = ByteArkPlayerEventChannel.stream.listen((event) async {
      final Map<String, dynamic> decodedData = jsonDecode(event);
      final eventObj = ByteArkPlayerNativeEvent.fromMap(decodedData);

      // Player events
      switch (eventObj.type) {
        case ByteArkPlayerEventTypes.playerReady:
          debugPrint('Received event: playerReady');
          if (_currentSubtitle != null) {
            _controller.setSubtitle(_currentSubtitle!);
          }
          if (_currentAudio != null) {
            _controller.setAudio(_currentAudio!);
          }
          break;
        case ByteArkPlayerEventTypes.playbackTimeupdate:
          debugPrint('Received event: playbackTimeupdate');
          _currentSubtitle = await _controller.getCurrentSubtitle();
          _currentAudio = await _controller.getCurrentAudio();
          debugPrint('Current subtitle ${_currentSubtitle?.toMap()}');
          debugPrint('Current audio: ${_currentAudio?.toMap()}');
          break;
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    // Dispose of the ByteArkPlayerController to free resources.
    _controller.dispose();
    // Dispose of the _subscription to free resources.
    _subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Step 1: Set ByteArkPlayerItem.
    var playerItem = ByteArkPlayerItem(
        url:
            "https://byteark-slehxnn9ug5e.stream-playlist.byteark.com/streams/UcPGuuSYjy27/playlist.m3u8");

    // Step 2: Set ByteArkPlayerConfig.
    var playerConfig = ByteArkPlayerConfig(
      licenseKey: ByteArkPlayerLicenseKey(android: _androidKey, iOS: _iosKey),
      playerItem: playerItem,
      subtitleSize:
          ByteArkPlayerSubtitleSize.tiny, // Use medium size instead of tiny
      subtitleBackgroundEnabled: true, // Keep subtitle background enabled
    );
    var playerConfig2 = ByteArkPlayerConfig(
      licenseKey: ByteArkPlayerLicenseKey(android: _androidKey, iOS: _iosKey),
      playerItem: playerItem,
      subtitleSize:
          ByteArkPlayerSubtitleSize.tiny, // Use medium size instead of tiny
      subtitleBackgroundEnabled: true, // Keep subtitle background enabled
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
        body: SingleChildScrollView(
          child: Column(
            children: [
              // Step 3: Embed ByteArk Player widget.
              AspectRatio(
                aspectRatio: 9 / 16,
                child: ByteArkPlayer(
                  playerConfig: playerConfig,
                ),
              ),
              ElevatedButton(
                onPressed: () => _controller.switchMediaSource(playerConfig2),
                child: const Text("Switch Media"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
