import 'dart:async';
import 'dart:convert';

import 'package:byteark_player_flutter/data/ads/byteark_player_ads_data.dart';
import 'package:byteark_player_flutter/data/ads/byteark_player_ads_error_data.dart';
import 'package:byteark_player_flutter/data/byteark_player_event_types.dart';
import 'package:byteark_player_flutter/data/byteark_player_license_key.dart';
import 'package:byteark_player_flutter/data/byteark_player_native_event.dart';
import 'package:byteark_player_flutter/domain/byteark_player_listener.dart';
import 'package:byteark_player_flutter/domain/event_channel/byteark_player_event_channel.dart';
import 'package:byteark_player_flutter/domain/method_channel/byteark_player_controller.dart';
import 'package:flutter/material.dart';
import 'package:byteark_player_flutter/data/byteark_player_config.dart';
import 'package:byteark_player_flutter/data/byteark_player_item.dart';
import 'package:byteark_player_flutter/presentation/byteark_player.dart';

class PlayerEventsListenerScreen extends StatefulWidget {
  const PlayerEventsListenerScreen({super.key});

  @override
  State<PlayerEventsListenerScreen> createState() =>
      _PlayerEventsListenerScreen();
}

class _PlayerEventsListenerScreen extends State<PlayerEventsListenerScreen> {
  late ByteArkPlayerItem _item;
  late ByteArkPlayerConfig _config;
  late ByteArkPlayer _player;

  @override
  void initState() {
    super.initState();
    // Step 1: Set ByteArkPlayerItem.
    _item = ByteArkPlayerItem(
        url:
            "https://byteark-playertzxedwv.stream-playlist.byteark.com/streams/TZyZheqEJUwC/playlist.m3u8");

    // Step 2: Set ByteArkPlayerConfig.
    _config = ByteArkPlayerConfig(
        licenseKey:
            ByteArkPlayerLicenseKey(android: "ANDROID_KEY", iOS: "iOS_KEY"),
        playerItem: _item,
        adsSettings: ByteArkAdsSettings(
            adTagUrl:
                "https://pubads.g.doubleclick.net/gampad/ads?iu=/21775744923/external/vmap_ad_samples&sz=640x480&cust_params=sample_ar%3Dpreonly&ciu_szs=300x250%2C728x90&gdfp_req=1&ad_rule=1&output=vmap&unviewed_position_start=1&env=vp&impl=s&correlator="));

    // Step 3: Set ByteArkPlayer.
    _player = ByteArkPlayer(
        playerConfig: _config,
        height: 300,
        listener: ByteArkPlayerListener(
          onPlayerReady: () => debugPrint("Received event: playerReady"),
          onPlayerLoadingMetadata: () =>
              debugPrint("Received event: playerLoadingMetadata"),
          onPlayerEnterFullscreen: () =>
              debugPrint("Received event: playerEnterFullscreen"),
          onPlayerExitFullscreen: () =>
              debugPrint("Received event: playerExitFullscreen"),
          onPlayerEnterPictureInPictureMode: () =>
              debugPrint("Received event: playerEnterPictureInPictureMode"),
          onPlayerExitPictureInPictureMode: () =>
              debugPrint("Received event: playerExitPictureInPictureMode"),
          onPlaybackFirstPlay: () =>
              debugPrint("Received event: playbackFirstPlay"),
          onPlaybackPlay: () => debugPrint("Received event: playbackPlay"),
          onPlaybackPause: () => debugPrint("Received event: playbackPause"),
          onPlaybackSeeking: () =>
              debugPrint("Received event: playbackSeeking"),
          onPlaybackSeeked: () => debugPrint("Received event: playbackSeeked"),
          onPlaybackEnded: () => debugPrint("Received event: playbackEnded"),
          onPlaybackTimeupdate: () =>
              debugPrint("Received event: playbackTimeupdate"),
          onPlaybackBuffering: () =>
              debugPrint("Received event: playbackBuffering"),
          onPlaybackBuffered: () =>
              debugPrint("Received event: playbackBuffered"),
          onPlaybackResolutionChanged: () =>
              debugPrint("Received event: playbackResolutionChanged"),
          onPlaybackError: (data) =>
              debugPrint("Received event: playbackError = ${data.toMap()}"),
          onAdsRequest: () => debugPrint("Received event: adsRequest"),
          onAdsBreakStart: () => debugPrint("Received event: adsBreakStart"),
          onAdsBreakEnd: () => debugPrint("Received event: adsBreakEnd"),
          onAdsStart: (data) {
            debugPrint("Received event: onAdsStart = ${data.toMap()}");
          },
          onAdsFirstQuartile: (data) {
            debugPrint("Received event: onAdsFirstQuartile = ${data.toMap()}");
          },
          onAdsMidPoint: (data) {
            debugPrint("Received event: onAdsMidPoint = ${data.toMap()}");
          },
          onAdsThirdQuartile: (data) {
            debugPrint("Received event: onAdsThirdQuartile = ${data.toMap()}");
          },
          onAdsCompleted: (data) {
            debugPrint("Received event: onAdsCompleted = ${data.toMap()}");
          },
          onAdsImpressed: (data) {
            debugPrint("Received event: onAdsImpressed = ${data.toMap()}");
          },
          onAdsClicked: (data) {
            debugPrint("Received event: onAdsClicked = ${data.toMap()}");
          },
          onAdsSkipped: (data) =>
              debugPrint("Received event: playbackError = ${data.toMap()}"),
          onAllAdsCompleted: () =>
              debugPrint("Received event: allAdsCompleted"),
          onAdsError: (data) {
            debugPrint("Received event: onAdsError = ${data.toMap()}");
          },
        ));
  }

  @override
  void dispose() {
    // Dispose to free resources.
    _player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        ));
  }
}
