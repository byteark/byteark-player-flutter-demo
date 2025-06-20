import 'package:byteark_player_flutter/data/byteark_player_config.dart';
import 'package:byteark_player_flutter/data/byteark_player_item.dart';
import 'package:byteark_player_flutter/data/byteark_player_license_key.dart';
import 'package:byteark_player_flutter/data/byteark_player_lighthouse_meta_data.dart';
import 'package:byteark_player_flutter/presentation/byteark_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ByteArkPlayerLighthouseScreen extends ConsumerStatefulWidget {
  const ByteArkPlayerLighthouseScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ByteArkPlayerLighthouseStateScreen();
}

class _ByteArkPlayerLighthouseStateScreen
    extends ConsumerState<ByteArkPlayerLighthouseScreen> {
  late ByteArkPlayerLicenseKey playerLicenseKey;
  late ByteArkPlayerItem playerItem;
  late ByteArkPlayerConfig playerConfig;
  late ByteArkPlayer player;

  // Step 1: Declare Lighthouse metadata and settings
  late ByteArkPlayerLighthouseMetaData lighthouseMetaData;
  late ByteArkLighthouseSetting lighthouseSetting;

  @override
  void initState() {
    super.initState();

    // Step 2: Assign Lighthouse metadata (all fields are optional)
    lighthouseMetaData = const ByteArkPlayerLighthouseMetaData(
      userId: 'user_id',
      age: '28',
      country: 'Thailand',
      city: 'Bangkok',
      lat: '13.7563',
      long: '100.5018',
      gender: 'Male',
      nationality: 'Thai',
      subscriptionPlan: 'Premium',
      accountCreationDate: '2021-08-15',
      videoTitle: 'The Great Adventure',
      seriesId: 'series_001',
      seriesTitle: 'Adventure Chronicles',
      season: '2',
      episode: '5',
      subEpisode: '5.1',
      duration: '00:45:30',
      publishedDate: '2023-12-01',
      genres: 'Action, Adventure',
      rating: 'PG-13',
      d1: 'custom_value_1',
      d2: 'custom_value_2',
      d3: 'custom_value_3',
      d4: 'custom_value_4',
      d5: 'custom_value_5',
      d6: 'custom_value_6',
      d7: 'custom_value_7',
      d8: 'custom_value_8',
      d9: 'custom_value_9',
      d10: 'custom_value_10',
    );

    // Step 3: Define Lighthouse setting (replace with your actual Project ID)
    lighthouseSetting = ByteArkLighthouseSetting(
      projectId: "YOUR_PROJECT_ID",
      debug: true,
    );

    // Step 4: Configure player with license key, item, and Lighthouse integration
    playerLicenseKey = ByteArkPlayerLicenseKey(android: "", iOS: "");
    playerItem = ByteArkPlayerItem(
      url: "url", // Replace with your video URL
      lighthouseMetaData: lighthouseMetaData, // Attach Lighthouse metadata
    );
    playerConfig = ByteArkPlayerConfig(
      licenseKey: playerLicenseKey,
      playerItem: playerItem,
      lighthouseSetting: lighthouseSetting,
    );

    // Step 5: Initialize ByteArk player
    player = ByteArkPlayer(playerConfig: playerConfig);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: player,
    );
  }
}
