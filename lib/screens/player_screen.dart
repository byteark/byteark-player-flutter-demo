import 'package:byteark_player_flutter/data/byteark_player_config.dart';
import 'package:byteark_player_flutter/data/byteark_player_item.dart';
import 'package:byteark_player_flutter/data/byteark_player_license_key.dart';
import 'package:byteark_player_flutter/data/byteark_player_subtitle_size.dart';
import 'package:byteark_player_flutter/data/byteark_player_media_track.dart';
import 'package:byteark_player_flutter/domain/byteark_player_listener.dart';
import 'package:byteark_player_flutter/domain/method_channel/byteark_player_controller.dart';
import 'package:byteark_player_flutter/presentation/byteark_player.dart';
import 'package:demo_byteark_player_flutter_integration/core/theme/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:io' show Platform;

/// A screen that displays a ByteArk video player with configurable options.
///
/// The player supports various features like VOD/Live streaming, ads, subtitles,
/// and multiple audio tracks.
class PlayerScreen extends ConsumerStatefulWidget {
  final bool isVod;
  final bool isLive;
  final bool withAds;
  final bool withSubtitles;
  final bool withMultiAudio;

  const PlayerScreen(
    this.isVod,
    this.isLive,
    this.withAds,
    this.withSubtitles,
    this.withMultiAudio, {
    super.key,
  });

  @override
  ConsumerState<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends ConsumerState<PlayerScreen> {
  late ByteArkPlayerItem _item;
  late ByteArkPlayerLicenseKey _licenseKey;
  late ByteArkPlayerConfig _config;
  late ByteArkPlayer _player;

  // Providers
  final _isShowControlProvider = StateProvider<bool>((ref) => true);
  final _isFullscreenProvider = StateProvider<bool>((ref) => false);
  final _isAutoPlayProvider = StateProvider<bool>((ref) => false);
  final _isSeekButtonProvider = StateProvider<bool>((ref) => true);
  final _isFullScreenButtonProvider = StateProvider<bool>((ref) => true);
  final _isSettingButtonProvider = StateProvider<bool>((ref) => true);
  final _isSubtitleBackgroundProvider = StateProvider<bool>((ref) => true);
  final _subtitleSizeProvider = StateProvider<ByteArkPlayerSubtitleSize>(
      (ref) => ByteArkPlayerSubtitleSize.medium);

  final _playbackSpeedProvider = StateProvider((ref) => 1.0);
  final _resolutionProvider = StateProvider<String>((ref) => 'Auto');

  final TextEditingController _subtitlePaddingController =
      TextEditingController(text: '5');

  final ByteArkPlayerSubtitleSize _subtitleSize =
      ByteArkPlayerSubtitleSize.medium;

  final _adTagUrl =
      "https://pubads.g.doubleclick.net/gampad/ads?iu=/40391221/byteark_promo_ad_units_1&description_url=[placeholder]&tfcd=0&npa=0&sz=640x480&gdfp_req=1&unviewed_position_start=1&output=vast&env=vp&impl=s&correlator=&vad_type=linear";

  final _playbackSpeedsProvider = StateProvider<List<double>>((ref) => []);
  final _resolutionsProvider =
      StateProvider<List<ByteArkPlayerMediaTrack>>((ref) => []);
  final _audiosProvider =
      StateProvider<List<ByteArkPlayerMediaTrack>>((ref) => []);
  final _audioProvider = StateProvider<ByteArkPlayerMediaTrack>(
      (ref) => ByteArkPlayerMediaTrack(language: "tha"));

  @override
  void initState() {
    super.initState();
    _initializePlayer();
  }

  @override
  Widget build(BuildContext context) {
    final isShowControl = ref.watch(_isShowControlProvider);
    final isAutoPlay = ref.watch(_isAutoPlayProvider);
    final isFullscreen = ref.watch(_isFullScreenButtonProvider);
    final playbackSpeed = ref.watch(_playbackSpeedProvider);
    final playbackSpeeds = ref.watch(_playbackSpeedsProvider)..sort();
    final resolution = ref.watch(_resolutionProvider);
    final resolutions = ref.watch(_resolutionsProvider);
    final audio = ref.watch(_audioProvider);
    final audios = ref.watch(_audiosProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text("ByteArk Player"),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 16 / 9,
              child: _player,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _getMediaTitle(),
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      SizedBox(height: 8),
                      Text(
                        _getMediaSubtitle(),
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      SizedBox(height: 16),
                      // Player API
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Player Controllers',
                              style: Styles.topic,
                            ),
                            // Action Icons
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
                                  icon: Icon(isFullscreen
                                      ? Icons.fullscreen_exit
                                      : Icons.fullscreen),
                                  onPressed: () {
                                    setState(() {
                                      ref
                                          .read(_isFullScreenButtonProvider
                                              .notifier)
                                          .state = !isFullscreen;
                                      _player.toggleFullScreen();
                                    });
                                  },
                                ),
                              ],
                            ),
                            SizedBox(height: 16),
                            Text("Playback Speed"),
                            Wrap(
                              spacing: 8,
                              children: playbackSpeeds.map((speed) {
                                return ChoiceChip(
                                  label: Text("${speed}x"),
                                  selected: playbackSpeed == speed,
                                  onSelected: (_) {
                                    ref
                                        .read(_playbackSpeedProvider.notifier)
                                        .state = speed;
                                    _player.setPlaybackSpeed(2.0);
                                  },
                                );
                              }).toList(),
                            ),
                            SizedBox(height: 16),
                            Text("Resolutions"),
                            Wrap(
                              spacing: 8,
                              children: resolutions.map((reso) {
                                return Expanded(
                                  child: ChoiceChip(
                                    label: Text("${reso.name}"),
                                    selected: resolution == reso.name,
                                    onSelected: (_) {
                                      debugPrint(
                                          "Resolution selected = ${ref.read(_resolutionProvider.notifier).state}");
                                      debugPrint(
                                          "Resolution name = ${reso.name}");
                                      ref
                                          .read(_resolutionProvider.notifier)
                                          .state = reso.name.toString();
                                      _player.setResolution(reso);
                                    },
                                  ),
                                );
                              }).toList(),
                            ),
                            SizedBox(height: 16),
                            Text("Audios"),
                            Wrap(
                              spacing: 8,
                              children: audios.map((aud) {
                                return Expanded(
                                  child: ChoiceChip(
                                    label: Text("${aud.language}"),
                                    selected: audio.language == aud.language,
                                    onSelected: (_) {
                                      debugPrint(
                                          "Audio selected = ${ref.read(_audioProvider.notifier).state}");
                                      debugPrint(
                                          "Audio name = ${aud.language}");
                                      ref.read(_audioProvider.notifier).state =
                                          aud;
                                      print("set audio : ${aud.toMap()}");
                                      _player.setAudio(aud);
                                    },
                                  ),
                                );
                              }).toList(),
                            ),
                            SizedBox(height: 16),
                            //Player Config
                            Text(
                              "Player Configs",
                              style: Styles.topic,
                            ),
                            SwitchListTile(
                                title: Text("Show Controls"),
                                subtitle: Text(
                                    "Toggle visibility of player controls"),
                                value: isShowControl,
                                onChanged: (value) {
                                  ref
                                      .read(_isShowControlProvider.notifier)
                                      .state = value;
                                }),
                            SwitchListTile(
                                title: Text("Autoplay"),
                                subtitle: Text(
                                    "Automatically start playback when loaded"),
                                value: isAutoPlay,
                                onChanged: (value) {
                                  ref.read(_isAutoPlayProvider.notifier).state =
                                      value;
                                }),
                            FilledButton(
                                onPressed: () {
                                  _player.setSubtitle(null);
                                },
                                child: Text("Test disable subtitle")),
                            if (Platform.isAndroid)
                              Column(
                                children: [
                                  SwitchListTile(
                                      title: Text("Seek Buttons"),
                                      subtitle: Text(
                                          "Show forward/backward seek buttons"),
                                      value: ref.watch(_isSeekButtonProvider),
                                      onChanged: (value) {
                                        ref
                                            .read(
                                                _isSeekButtonProvider.notifier)
                                            .state = value;
                                      }),
                                  SwitchListTile(
                                      title: Text("Fullscreen Button"),
                                      subtitle:
                                          Text("Show fullscreen toggle button"),
                                      value: ref
                                          .watch(_isFullScreenButtonProvider),
                                      onChanged: (value) {
                                        ref
                                            .read(_isFullScreenButtonProvider
                                                .notifier)
                                            .state = value;
                                      }),
                                  SwitchListTile(
                                      title: Text("Settings Button"),
                                      subtitle:
                                          Text("Show player settings button"),
                                      value:
                                          ref.watch(_isSettingButtonProvider),
                                      onChanged: (value) {
                                        ref
                                            .read(_isSettingButtonProvider
                                                .notifier)
                                            .state = value;
                                      }),
                                ],
                              ),
                          ]),
                      const SizedBox(height: 16),
                      SizedBox(height: 16),

                      // Subtitle Settings Section
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Subtitle Settings",
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          SizedBox(height: 8),
                          if (Platform.isAndroid)
                            SwitchListTile(
                              title: Text("Enable subtitle background"),
                              subtitle: Text(
                                  "to show subtitle background (Android only)"),
                              value: ref.watch(_isSubtitleBackgroundProvider),
                              onChanged: (value) {
                                ref
                                    .read(
                                        _isSubtitleBackgroundProvider.notifier)
                                    .state = value;
                              },
                            ),
                          ListTile(
                            title: Text("Subtitle size"),
                            trailing: DropdownButton<ByteArkPlayerSubtitleSize>(
                              value: ref.watch(_subtitleSizeProvider),
                              items:
                                  ByteArkPlayerSubtitleSize.values.map((size) {
                                return DropdownMenuItem(
                                  value: size,
                                  child: Text(size.toString().split('.').last),
                                );
                              }).toList(),
                              onChanged: (value) {
                                if (value != null) {
                                  ref
                                      .read(_subtitleSizeProvider.notifier)
                                      .state = value;
                                }
                              },
                            ),
                          ),
                          ListTile(
                            title: Text("Subtitle padding (%)"),
                            subtitle: Text("Set subtitle padding percentage"),
                            trailing: SizedBox(
                              width: 100,
                              child: TextField(
                                keyboardType: TextInputType.number,
                                controller: _subtitlePaddingController,
                                decoration: InputDecoration(
                                  hintText: "5",
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16),

                      // Submit Button
                      SizedBox(
                        width: double.infinity,
                        child: FilledButton(
                          onPressed: () async {
                            debugPrint("Pressed");
                            var resolutions = await _player.getResolutions();
                            var currentTime = await _player.getCurrentTime();
                            var currentPos = await _player.currentPosition();
                            debugPrint("getCurrentTime() = $currentTime");
                            debugPrint("getCurrentPosition() = $currentPos");
                            for (var reso in resolutions) {
                              debugPrint("resolution = ${reso.name}");
                            }

                            _config = ByteArkPlayerConfig(
                              licenseKey: _licenseKey,
                              playerItem: ByteArkPlayerItem(
                                  url:
                                      "https://byteark-slehxnn9ug5e.stream-playlist.byteark.com/streams/UcPGuuSYjy27/playlist.m3u8"),
                              autoPlay: true,
                              control: ref.read(_isShowControlProvider),
                              seekButtons: true,
                              fullScreenButton: true,
                              settingButton: true,
                              subtitleBackgroundEnabled: true,
                              subtitleSize: ByteArkPlayerSubtitleSize.small,
                              subtitlePaddingBottomPercentage: 10,
                              adsSettings: widget.withAds
                                  ? ByteArkAdsSettings(adTagUrl: _adTagUrl)
                                  : null,
                            );
                            _player.switchMediaSource(_config);
                          },
                          child: Text("Apply Settings"),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _initializePlayer() async {
    _item = ByteArkPlayerItem(
      url: _getMediaUrl(),
      title: _getMediaTitle(),
      subtitle: _getMediaSubtitle(),
    );

    _licenseKey = ByteArkPlayerLicenseKey(
      android: "CB4E8F-56012D-E75703-16EB94-EA6483-V3",
      iOS: "86EC30-D3FE67-0E254F-18EC9C-EEEF5E-V3",
    );

    _config = ByteArkPlayerConfig(
      licenseKey: _licenseKey,
      playerItem: _item,
      autoPlay: true,
      // control: ref.read(_isShowControlProvider),
      control: true,
      seekButtons: true,
      fullScreenButton: true,
      settingButton: true,
      subtitleBackgroundEnabled: true,
      subtitleSize: ByteArkPlayerSubtitleSize.medium,
      subtitlePaddingBottomPercentage: 5,
      adsSettings:
          widget.withAds ? ByteArkAdsSettings(adTagUrl: _adTagUrl) : null,
    );
    final defaultPlayerConfig = ByteArkPlayerConfig(
      licenseKey: _licenseKey,
      playerItem: _item,
      autoPlay: true,
      control: true,
      fullScreenButton: true,
      settingButton: true,
      subtitleSize: ByteArkPlayerSubtitleSize.tiny,
      subtitleBackgroundEnabled: false,
      subtitlePaddingBottomPercentage: 27,
      secureSurface: true,
    );
    // _player = ByteArkPlayer(playerConfig: defaultPlayerConfig);

    _player = ByteArkPlayer(
      playerConfig: _config,
      listener: ByteArkPlayerListener(
        onPlayerReady: () async {
          final audios = await _player.getAudios();
          ref.read(_audiosProvider.notifier).state = audios;
          if (audios.isNotEmpty) {
            ref.read(_audioProvider.notifier).state = audios[0];
          }
          for (var audio in audios) {
            print("Audio = ${audio.toMap()}");
          }
          final resolutions = await _player.getResolutions();
          final playbackSpeeds = await _player.getAvailablePlaybackSpeeds();

          // Sort resolutions with Auto first, then by resolution number
          resolutions.sort((a, b) {
            if (a.name == 'Auto') return -1;
            if (b.name == 'Auto') return 1;

            final aRes = int.tryParse(
                    RegExp(r'\d+').firstMatch(a.name ?? '')?.group(0) ?? '') ??
                -1;
            final bRes = int.tryParse(
                    RegExp(r'\d+').firstMatch(b.name ?? '')?.group(0) ?? '') ??
                -1;
            return bRes.compareTo(aRes);
          });

          ref.read(_resolutionsProvider.notifier).state = resolutions;
          ref.read(_playbackSpeedsProvider.notifier).state = playbackSpeeds;

          // Log available options
          for (var r in resolutions) {
            debugPrint('Resolution: ${r.name}');
          }
          for (var s in playbackSpeeds) {
            debugPrint('Playback speed: $s');
          }
        },
        onPlaybackEnded: () {
          _player.switchMediaSource(_config);
        },
      ),
    );
  }

  String _getMediaUrl() {
    if (widget.withSubtitles) {
      return "https://byteark-slehxnn9ug5e.stream-playlist.byteark.com/streams/UcPGuuSYjy27/playlist.m3u8";
      // return "https://byteark-playertzxedwv.stream-playlist.byteark.com/streams/TZyZhhLbiVxG/playlist.m3u8";
    } else if (widget.withMultiAudio) {
      return "https://love-drama-company-limiteduawrrqs.stream-playlist.byteark.com/streams/UlZUbwBy3lcv/playlist.m3u8";
      // return "https://love-drama-company-limiteduawrrqs.stream-playlist.byteark.com/streams/UlZUbxJAdJZ1/playlist.m3u8";
      // return "https://byteark-playertzxedwv.stream-playlist.byteark.com/streams/UQbEQX4yUCnG/playlist.m3u8";
    } else if (widget.isVod) {
      return "https://byteark-playertzxedwv.stream-playlist.byteark.com/streams/TZyZheqEJUwC/playlist.m3u8";
    } else if (widget.isLive) {
      return "https://thaipbs-live.cdn.byteark.com/live/playlist.m3u8";
    } else {
      return "https://byteark-playertzxedwv.stream-playlist.byteark.com/streams/TZyZheqEJUwC/playlist.m3u8";
    }
  }

  String _getMediaTitle() {
    if (widget.withSubtitles) return "Multi-language Video Experience";
    if (widget.withMultiAudio) return "Multi-audio Track Video";
    if (widget.isVod) {
      return widget.withAds ? "Ad-supported VOD Content" : "VOD Content";
    }
    if (widget.isLive) {
      return widget.withAds ? "Ad-supported Live Stream" : "Live Stream";
    }
    return "Standard Video Player";
  }

  String _getMediaSubtitle() {
    if (widget.withSubtitles) {
      return "Enhanced viewing experience with multiple subtitle options";
    }
    if (widget.withMultiAudio) {
      return "Choose from various audio language tracks for your preferred listening experience";
    }
    if (widget.isVod) {
      if (widget.withAds) {
        return "Enjoy premium content with strategic ad breaks for a balanced viewing experience";
      } else {
        return "High-quality on-demand video content available anytime";
      }
    }
    if (widget.isLive) {
      if (widget.withAds) {
        return "Watch live events with minimal ad interruptions, keeping you connected to the action";
      } else {
        return "Real-time streaming broadcast with instant updates and zero interruptions";
      }
    }
    return "Standard video playback experience";
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }
}
