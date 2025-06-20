import 'package:demo_byteark_player_flutter_integration/core/ui/custom_silver_app_bar.dart';
import 'package:demo_byteark_player_flutter_integration/core/ui/custom_video_item.dart';
import 'package:demo_byteark_player_flutter_integration/screens/player_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerWidget {
  HomeScreen({super.key});

  final _silverAppBarTitle = "ByteArk";
  final _silverAppBarBackground = Image.asset(
    'assets/images/bg_byteark_opacity.png',
    fit: BoxFit.scaleDown,
  );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          CustomSilverAppBar(
              title: _silverAppBarTitle, background: _silverAppBarBackground),
          SliverList(
              delegate: SliverChildListDelegate([
            CustomVideoItem(
              title: 'Sample VOD Content',
              description: 'High quality video streaming',
              color: Theme.of(context).colorScheme.primary,
              nextColor: Theme.of(context).colorScheme.secondary,
              onTap: () => _navigateToPlayer(context, isVod: true),
            ),
            CustomVideoItem(
              title: 'Ad-supported Content',
              description: 'Free content with ads',
              color: Theme.of(context).colorScheme.secondary,
              nextColor: Theme.of(context).colorScheme.tertiary,
              onTap: () =>
                  _navigateToPlayer(context, isVod: true, withAds: true),
            ),
            CustomVideoItem(
              title: 'Live Event Stream',
              description: 'Real-time streaming content',
              color: Theme.of(context).colorScheme.tertiary,
              nextColor: Theme.of(context).colorScheme.error,
              onTap: () => _navigateToPlayer(context, isLive: true),
            ),
            CustomVideoItem(
              title: 'Live Stream with Ads',
              description: 'Live content with ad breaks',
              color: Theme.of(context).colorScheme.error,
              nextColor: Theme.of(context).colorScheme.primary,
              onTap: () =>
                  _navigateToPlayer(context, isLive: true, withAds: true),
            ),
            CustomVideoItem(
              title: 'Multi-language Content',
              description: 'Content with subtitle support',
              color: Theme.of(context).colorScheme.primary,
              nextColor: Theme.of(context).colorScheme.secondary,
              onTap: () =>
                  _navigateToPlayer(context, isVod: true, withSubtitles: true),
            ),
            CustomVideoItem(
              title: 'Multi-language Audio',
              description: 'Content with multiple audio tracks',
              color: Theme.of(context).colorScheme.secondary,
              nextColor: Theme.of(context).colorScheme.surface,
              onTap: () =>
                  _navigateToPlayer(context, isVod: true, withMultiAudio: true),
            ),
          ]))
        ],
      ),
    );
  }

  void _navigateToPlayer(
    BuildContext context, {
    bool isVod = false,
    bool isLive = false,
    bool withAds = false,
    bool withSubtitles = false,
    bool withMultiAudio = false,
  }) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PlayerScreen(
              isVod = isVod,
              isLive = isLive,
              withAds = withAds,
              withSubtitles = withSubtitles,
              withMultiAudio = withMultiAudio),
        ));
  }
}
