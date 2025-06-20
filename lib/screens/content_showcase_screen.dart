import 'package:demo_byteark_player_flutter_integration/core/theme/styles.dart';
import 'package:flutter/material.dart';
import 'home_screen2.dart';

class ContentShowcaseScreen extends StatefulWidget {
  const ContentShowcaseScreen({super.key});

  @override
  State<ContentShowcaseScreen> createState() => _ContentShowcaseScreenState();
}

class _ContentShowcaseScreenState extends State<ContentShowcaseScreen> {
  final ValueNotifier<double> opacity = ValueNotifier(1);

  final Widget _silverAppBar = SliverAppBar(
    expandedHeight: 150,
    floating: false,
    pinned: true,
    backgroundColor: Colors.white,
    flexibleSpace: LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        // Detect collapsed state
        final isCollapsed = constraints.maxHeight <=
            kToolbarHeight + MediaQuery.of(context).padding.top;

        return FlexibleSpaceBar(
          title: isCollapsed
              ? Text(
                  'ByteArk',
                  style: Styles.header,
                )
              : null, // Hide title when expanded
          background: Image.asset(
            'assets/images/bg_byteark_opacity.png',
            fit: BoxFit.scaleDown,
          ),
        );
      },
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: CustomScrollView(
        slivers: [
          _silverAppBar,
          SliverList(
            delegate: SliverChildListDelegate([
              _buildVideoItem(
                context,
                title: 'Sample VOD Content',
                description: 'High quality video streaming',
                color: Theme.of(context).colorScheme.primary,
                nextColor: Theme.of(context).colorScheme.secondary,
                onTap: () => _navigateToPlayer(context, isVod: true),
              ),
              _buildVideoItem(
                context,
                title: 'Ad-supported Content',
                description: 'Free content with ads',
                color: Theme.of(context).colorScheme.secondary,
                nextColor: Theme.of(context).colorScheme.tertiary,
                onTap: () =>
                    _navigateToPlayer(context, isVod: true, withAds: true),
              ),
              _buildVideoItem(
                context,
                title: 'Live Event Stream',
                description: 'Real-time streaming content',
                color: Theme.of(context).colorScheme.tertiary,
                nextColor: Theme.of(context).colorScheme.error,
                onTap: () => _navigateToPlayer(context, isLive: true),
              ),
              _buildVideoItem(
                context,
                title: 'Live Stream with Ads',
                description: 'Live content with ad breaks',
                color: Theme.of(context).colorScheme.error,
                nextColor: Theme.of(context).colorScheme.primary,
                onTap: () =>
                    _navigateToPlayer(context, isLive: true, withAds: true),
              ),
              _buildVideoItem(
                context,
                title: 'Multi-language Content',
                description: 'Content with subtitle support',
                color: Theme.of(context).colorScheme.primary,
                nextColor: Theme.of(context).colorScheme.secondary,
                onTap: () => _navigateToPlayer(context,
                    isVod: true, withSubtitles: true),
              ),
              _buildVideoItem(
                context,
                title: 'Multi-language Audio',
                description: 'Content with multiple audio tracks',
                color: Theme.of(context).colorScheme.secondary,
                nextColor: Theme.of(context).colorScheme.surface,
                onTap: () => _navigateToPlayer(context,
                    isVod: true, withMultiAudio: true),
              ),
            ]),
          ),
        ],
      ),
    );
  }

  Widget _buildVideoItem(
    BuildContext context, {
    required String title,
    required String description,
    required Color color,
    required Color nextColor,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: nextColor,
        child: Container(
          decoration: BoxDecoration(
            color: color,
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(80.0),
            ),
          ),
          padding: const EdgeInsets.fromLTRB(32, 40, 32, 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                description,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
              ),
              const SizedBox(height: 8),
              Text(
                title,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: Theme.of(context).colorScheme.onPrimary,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Icon(
                    Icons.play_circle_outline,
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Tap to Play',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                  ),
                ],
              ),
            ],
          ),
        ),
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
        builder: (context) => const HomeScreen2(),
      ),
    );
  }
}
