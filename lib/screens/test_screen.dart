import 'package:byteark_player_flutter/data/byteark_player_license_key.dart';
import 'package:byteark_player_flutter/data/byteark_player_media_track.dart';
import 'package:byteark_player_flutter/data/byteark_player_subtitle_size.dart';
import 'package:byteark_player_flutter/domain/byteark_player_listener.dart';
import 'package:flutter/material.dart';
import 'package:byteark_player_flutter/data/byteark_player_config.dart';
import 'package:byteark_player_flutter/data/byteark_player_item.dart';
import 'package:byteark_player_flutter/presentation/byteark_player.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({super.key});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  // Declare required variables
  late ByteArkPlayerItem _item;
  late ByteArkPlayerConfig _config;
  late ByteArkPlayer _player;

  @override
  void initState() {
    super.initState();

    _item = ByteArkPlayerItem(
        url:
            "https://love-drama-company-limiteduawrrqs.stream-playlist.byteark.com/streams/UnHFGj1qc6Pk/playlist.m3u8");

    _config = ByteArkPlayerConfig(
        licenseKey: ByteArkPlayerLicenseKey(
            android: "CB4E8F-56012D-E75703-16EB94-EA6483-V3",
            iOS: "86EC30-D3FE67-0E254F-18EC9C-EEEF5E-V3"),
        playerItem: _item,
        control: false,
        autoPlay: true,
        subtitleSize: ByteArkPlayerSubtitleSize.tiny,
        subtitlePaddingBottomPercentage: 27,
        subtitleBackgroundEnabled: false);

    _player = ByteArkPlayer(
      playerConfig: _config,
      listener: ByteArkPlayerListener(onPlayerReady: () {
        _player.setSubtitle(ByteArkPlayerMediaTrack(language: "tha"));
      }),
    );
  }

  @override
  void dispose() {
    // Clean up player instance.
    _player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ByteArk Player Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Scaffold(
          appBar: AppBar(
            title: const Text('ByteArk Player'),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                /// Use `Expanded` to let `_player` fill available space
                AspectRatio(
                  aspectRatio: 9 / 16,
                  child: _player,
                ),
                ElevatedButton(
                    onPressed: () {
                      _player.switchMediaSource(_config);
                    },
                    child: const Text("SW"))
              ],
            ),
          )),
    );
  }
}
