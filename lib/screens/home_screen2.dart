import 'dart:io';

import 'package:byteark_player_flutter/data/byteark_player_config.dart';
import 'package:byteark_player_flutter/data/byteark_player_item.dart';
import 'package:byteark_player_flutter/data/byteark_player_license_key.dart';
import 'package:byteark_player_flutter/data/byteark_player_subtitle_size.dart';
import 'package:byteark_player_flutter/presentation/byteark_player.dart';
import 'package:flutter/material.dart';

class HomeScreen2 extends StatefulWidget {
  const HomeScreen2({super.key});

  @override
  State<HomeScreen2> createState() => _HomeScreen2State();
}

class _HomeScreen2State extends State<HomeScreen2> {
  // Declare required variables
  late ByteArkPlayerItem _item;
  late ByteArkPlayerConfig _config;
  late ByteArkPlayer _player;

  bool _isFullscreen = false;
  bool _autoplay = false;
  bool _control = true;
  bool _seekButtons = true;
  bool _fullScreenButton = true;
  bool _settingButton = true;
  bool _subtitleBg = true;
  int _subtitlePadding = 5;

  String _selectedQuality = 'Auto';
  List<String> _qualities = ['Auto'];

  ByteArkPlayerSubtitleSize _subtitleSize = ByteArkPlayerSubtitleSize.medium;
  double _playbackSpeed = 1.0;

  @override
  void initState() {
    super.initState();
    _initializePlayer();
  }

  Future<void> _initializePlayer() async {
    // Step 2: Define the video source using ByteArkPlayerItem
    _item = ByteArkPlayerItem(
      url:
          "https://byteark-playertzxedwv.stream-playlist.byteark.com/streams/TZyZheqEJUwC/playlist.m3u8",
    );

    // Step 3: Configure the player using ByteArkPlayerConfig
    // _config = ByteArkPlayerConfig(
    //   // Optional : Set up ads if needed.
    //   // adsSettings: ByteArkAdsSettings(
    //   //   adTagUrl:
    //   //       "https://pubads.g.doubleclick.net/gampad/ads?iu=/21775744923/external/single_ad_samples&sz=640x480&cust_params=sample_ct%3Dlinear&ciu_szs=300x250%2C728x90&gdfp_req=1&output=vast&unviewed_position_start=1&env=vp&impl=s&correlator=",
    //   // ),
    //   licenseKey: ByteArkPlayerLicenseKey(
    //       android: "CB4E8F-56012D-E75703-16EB94-EA6483-V3",
    //       iOS: "86EC30-D3FE67-0E254F-18EC9C-EEEF5E-V3"),
    //   playerItem: _item,
    //   seekButtons: _seekButtons,
    //   settingButton: _settingButton,
    //   fullScreenButton: _fullScreenButton,
    //   subtitleBackgroundEnabled: _subtitleBg,
    //   subtitleSize: _subtitleSize,
    //   subtitlePaddingBottomPercentage: _subtitlePadding,
    //   autoPlay: _autoplay,
    // );

    // Step 4: Initialize the ByteArkPlayer with the config and listener
    // _player = ByteArkPlayer(
    //   playerConfig: _config,
    //   height: 300,
    // );

    getResolutions;
  }

  getResolutions() {
    debugPrint("test_log: getResolutions()");
    final resolutions = _player.getResolutions();
    resolutions.then((resolutions) {
      _qualities = ['Auto'];
      for (var resolution in resolutions) {
        debugPrint("test_log: Name = ${resolution.name!}");
        _qualities.add(resolution.name!);
      }
    });
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("Building Player");
    _config = ByteArkPlayerConfig(
      // Optional : Set up ads if needed.
      // adsSettings: ByteArkAdsSettings(
      //   adTagUrl:
      //       "https://pubads.g.doubleclick.net/gampad/ads?iu=/21775744923/external/single_ad_samples&sz=640x480&cust_params=sample_ct%3Dlinear&ciu_szs=300x250%2C728x90&gdfp_req=1&output=vast&unviewed_position_start=1&env=vp&impl=s&correlator=",
      // ),
      licenseKey: ByteArkPlayerLicenseKey(
          android: "CB4E8F-56012D-E75703-16EB94-EA6483-V3",
          iOS: "86EC30-D3FE67-0E254F-18EC9C-EEEF5E-V3"),
      playerItem: _item,
      seekButtons: _seekButtons,
      settingButton: _settingButton,
      fullScreenButton: _fullScreenButton,
      subtitleBackgroundEnabled: _subtitleBg,
      subtitleSize: _subtitleSize,
      subtitlePaddingBottomPercentage: _subtitlePadding,
      autoPlay: _autoplay,
    );
    _player = ByteArkPlayer(
      playerConfig: _config,
      height: 300,
    );
    return Scaffold(
      appBar: AppBar(title: const Text('Byteark Player')),
      body: Column(
        children: [
          AspectRatio(
            aspectRatio: 16 / 9,
            child: _player,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Basic Controls
                    const Text(
                      'Basic Controls',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                            icon: const Icon(Icons.replay_10),
                            onPressed: () => _player.seekBackward()),
                        IconButton(
                          icon: const Icon(Icons.play_arrow),
                          onPressed: () => _player.play(),
                        ),
                        IconButton(
                          icon: const Icon(Icons.pause),
                          onPressed: () => _player.pause(),
                        ),
                        IconButton(
                            icon: const Icon(Icons.forward_10),
                            onPressed: () => _player.seekForward()),
                        IconButton(
                          icon: Icon(_isFullscreen
                              ? Icons.fullscreen_exit
                              : Icons.fullscreen),
                          onPressed: () {
                            setState(() {
                              _isFullscreen = !_isFullscreen;
                              _player.toggleFullScreen();
                            });
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Playback Settings',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    SwitchListTile(
                      title: const Text('Autoplay'),
                      subtitle: const Text('Start playing video automatically'),
                      value: _autoplay,
                      onChanged: (value) {
                        setState(() {
                          _autoplay = value;
                        });
                      },
                    ),
                    ListTile(
                      title: const Text('Playback Speed'),
                      subtitle: Text('${_playbackSpeed}x'),
                      trailing: SizedBox(
                        width: 200,
                        child: Slider(
                          value: _playbackSpeed,
                          min: 0.5,
                          max: 2.0,
                          divisions: 3,
                          label: '${_playbackSpeed}x',
                          onChanged: (v) => setState(() => _playbackSpeed = v),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Video Quality',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    DropdownButtonFormField<String>(
                      value: _selectedQuality,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      ),
                      items: _qualities.map((String quality) {
                        return DropdownMenuItem<String>(
                          value: quality,
                          child: Text(quality),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        if (newValue != null) {
                          setState(() {
                            _selectedQuality = newValue;
                          });
                        }
                      },
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      'Player Controls',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    SwitchListTile(
                      title: const Text('Show Controls'),
                      subtitle: const Text('Display player controls'),
                      value: _control,
                      onChanged: (value) {
                        setState(() {
                          _control = value;
                        });
                      },
                    ),
                    if (Platform.isAndroid)
                      Column(
                        children: [
                          SwitchListTile(
                            title: const Text('Seek Buttons'),
                            subtitle:
                                const Text('Show forward/backward buttons'),
                            value: _seekButtons,
                            onChanged: (value) {
                              setState(() {
                                _seekButtons = value;
                              });
                            },
                          ),
                          SwitchListTile(
                            title: const Text('Fullscreen Button'),
                            subtitle:
                                const Text('Show fullscreen toggle button'),
                            value: _fullScreenButton,
                            onChanged: (value) {
                              setState(() {
                                _fullScreenButton = value;
                              });
                            },
                          ),
                          SwitchListTile(
                            title: const Text('Settings Button'),
                            subtitle: const Text('Show settings button'),
                            value: _settingButton,
                            onChanged: (value) {
                              setState(() {
                                _settingButton = value;
                              });
                            },
                          ),
                        ],
                      ),
                    const SizedBox(height: 24),
                    const Text(
                      'Subtitle Settings',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    if (Platform.isAndroid)
                      Column(
                        children: [
                          SwitchListTile(
                            title: const Text('Subtitle Background'),
                            subtitle:
                                const Text('Show background behind subtitles'),
                            value: _subtitleBg,
                            onChanged: (value) {
                              setState(() {
                                _subtitleBg = value;
                              });
                            },
                          ),
                        ],
                      ),
                    ListTile(
                      title: const Text('Subtitle Size'),
                      subtitle: Text(_subtitleSize.toString().split('.').last),
                      trailing: DropdownButton<ByteArkPlayerSubtitleSize>(
                        value: _subtitleSize,
                        items: ByteArkPlayerSubtitleSize.values.map((size) {
                          return DropdownMenuItem<ByteArkPlayerSubtitleSize>(
                            value: size,
                            child: Text(size.toString().split('.').last),
                          );
                        }).toList(),
                        onChanged: (ByteArkPlayerSubtitleSize? size) {
                          if (size != null) {
                            setState(() => _subtitleSize = size);
                          }
                        },
                      ),
                    ),
                    ListTile(
                      title: const Text('Subtitle Padding'),
                      subtitle: Text('$_subtitlePadding%'),
                      trailing: SizedBox(
                        width: 200,
                        child: Slider(
                          value: _subtitlePadding.toDouble(),
                          min: 0,
                          max: 20,
                          divisions: 20,
                          label: '$_subtitlePadding%',
                          onChanged: (v) =>
                              setState(() => _subtitlePadding = v.toInt()),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(16),
                        child: FilledButton(
                          onPressed: () {
                            print("Apply Button Pressed");
                            setState(() {
                              print("Disposing player...");
                              // _player.dispose();
                              _player = ByteArkPlayer(
                                playerConfig: _config,
                                height: 500,
                              );
                            });
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Settings applied successfully'),
                                duration: Duration(seconds: 2),
                              ),
                            );
                          },
                          child: const Text("Apply Settings"),
                        ))
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
