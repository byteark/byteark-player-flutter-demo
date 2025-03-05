import 'dart:async';
import 'dart:convert';

import 'package:byteark_player_flutter/data/ads/byteark_player_ads_data.dart';
import 'package:byteark_player_flutter/data/ads/byteark_player_ads_error_data.dart';
import 'package:byteark_player_flutter/data/byteark_player_event_types.dart';
import 'package:byteark_player_flutter/data/byteark_player_license_key.dart';
import 'package:byteark_player_flutter/data/byteark_player_native_event.dart';
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
  late ByteArkPlayerController _controller;
  late StreamSubscription<dynamic>? _subscription;

  @override
  void initState() {
    super.initState();
    // Initialize the ByteArkPlayerController.
    _controller = ByteArkPlayerController();
    _subscription = ByteArkPlayerEventChannel.stream.listen((event) {
      final Map<String, dynamic> decodedData = jsonDecode(event);
      final eventObj = ByteArkPlayerNativeEvent.fromMap(decodedData);
      dynamic eventData;

      switch (eventObj.type) {
        // Player events
        case ByteArkPlayerEventTypes.playerReady:
          debugPrint('Received event: playerReady');
          break;
        case ByteArkPlayerEventTypes.playerLoadingMetadata:
          debugPrint('Received event: playerLoadingMetadata');
          break;
        case ByteArkPlayerEventTypes.playbackFirstPlay:
          debugPrint('Received event: playbackFirstPlay');
          break;
        case ByteArkPlayerEventTypes.playbackPlay:
          debugPrint('Received event: playbackPlay');
          break;
        case ByteArkPlayerEventTypes.playbackPause:
          debugPrint('Received event: playbackPause');
          break;
        case ByteArkPlayerEventTypes.playbackSeeking:
          debugPrint('Received event: playbackSeeking');
          break;
        case ByteArkPlayerEventTypes.playbackSeeked:
          debugPrint('Received event: playbackSeeked');
          break;
        case ByteArkPlayerEventTypes.playbackEnded:
          debugPrint('Received event: playbackEnded');
          break;
        case ByteArkPlayerEventTypes.playbackTimeupdate:
          debugPrint('Received event: playbackTimeupdate');
          break;
        case ByteArkPlayerEventTypes.playbackBuffering:
          debugPrint('Received event: playbackBuffering');
          break;
        case ByteArkPlayerEventTypes.playbackBuffered:
          debugPrint('Received event: playbackBuffered');
          break;
        case ByteArkPlayerEventTypes.playbackError:
          debugPrint('Received event: playbackError');
          break;
        case ByteArkPlayerEventTypes.playerEnterFullscreen:
          debugPrint('Received event: playerEnterFullscreen');
          break;
        case ByteArkPlayerEventTypes.playerExitFullscreen:
          debugPrint('Received event: playerExitFullscreen');
          break;
        case ByteArkPlayerEventTypes.playerEnterPictureInPictureMode:
          debugPrint('Received event: playerEnterPictureInPictureMode');
          break;
        case ByteArkPlayerEventTypes.playerExitPictureInPictureMode:
          debugPrint('Received event: playerExitPictureInPictureMode');
          break;
        case ByteArkPlayerEventTypes.playbackResolutionChanged:
          debugPrint('Received event: playbackResolutionChanged');
          break;
        // ADS
        case ByteArkPlayerEventTypes.adsRequest:
          debugPrint('Received event: adsRequest');
          break;
        case ByteArkPlayerEventTypes.adsBreakStart:
          debugPrint('Received event: adsBreakStart');
          break;
        case ByteArkPlayerEventTypes.adsBreakEnd:
          debugPrint('Received event: adsBreakEnd');
          break;
        case ByteArkPlayerEventTypes.adsStart:
          eventData = ByteArkPlayerAdsData.fromMap(eventObj.data);
          debugPrint('Received event: adsStart ${eventData.title}');
          break;
        case ByteArkPlayerEventTypes.adsFirstQuartile:
          eventData = ByteArkPlayerAdsData.fromMap(eventObj.data);
          debugPrint('Received event: adsFirstQuartile ${eventData.title}');
          break;
        case ByteArkPlayerEventTypes.adsMidPoint:
          eventData = ByteArkPlayerAdsData.fromMap(eventObj.data);
          debugPrint('Received event: adsMidPoint ${eventData.title}');
          break;
        case ByteArkPlayerEventTypes.adsThirdQuartile:
          eventData = ByteArkPlayerAdsData.fromMap(eventObj.data);
          debugPrint('Received event: adsThirdQuartile ${eventData.title}');
          break;
        case ByteArkPlayerEventTypes.adsCompleted:
          eventData = ByteArkPlayerAdsData.fromMap(eventObj.data);
          debugPrint('Received event: adsCompleted ${eventData.title}');
          break;
        case ByteArkPlayerEventTypes.adsImpressed:
          eventData = ByteArkPlayerAdsData.fromMap(eventObj.data);
          debugPrint('Received event: adsImpressed ${eventData.title}');
          break;
        case ByteArkPlayerEventTypes.adsClicked:
          eventData = ByteArkPlayerAdsData.fromMap(eventObj.data);
          debugPrint('Received event: adsClicked ${eventData.title}');
          break;
        case ByteArkPlayerEventTypes.adsSkipped:
          debugPrint('Received event: adsSkipped');
          break;
        case ByteArkPlayerEventTypes.allAdsCompleted:
          debugPrint('Received event: allAdsCompleted');
          break;
        case ByteArkPlayerEventTypes.adsError:
          eventData = ByteArkPlayerAdsErrorData.fromMap(eventObj.data);
          debugPrint(
              'Received event: adsError ${eventData.code} + ${eventData.msg}');
          break;
        default:
          debugPrint('Received unknown event: $event');
      }
    }, onError: (error) {
      debugPrint('Event recieving an error : $error');
    });
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
            "https://byteark-playertzxedwv.stream-playlist.byteark.com/streams/TZyZheqEJUwC/playlist.m3u8");

    // Step 2: Set ByteArkPlayerConfig.
    var playerConfig = ByteArkPlayerConfig(
        licenseKey:
            ByteArkPlayerLicenseKey(android: "ANDROID_KEY", iOS: "iOS_KEY"),
        playerItem: playerItem,
        adsSettings: ByteArkAdsSettings(
            adTagUrl:
                "https://pubads.g.doubleclick.net/gampad/ads?iu=/21775744923/external/vmap_ad_samples&sz=640x480&cust_params=sample_ar%3Dpreonly&ciu_szs=300x250%2C728x90&gdfp_req=1&ad_rule=1&output=vmap&unviewed_position_start=1&env=vp&impl=s&correlator="));

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
              child: ByteArkPlayer(
                playerConfig: playerConfig,
                height: 300,
              ),
            ),
          ],
        ));
  }
}
