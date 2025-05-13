import 'package:byteark_player_flutter/data/byteark_player_config.dart';
import 'package:byteark_player_flutter/data/byteark_player_item.dart';
import 'package:byteark_player_flutter/data/byteark_player_license_key.dart';
import 'package:byteark_player_flutter/data/byteark_player_media_track.dart';
import 'package:byteark_player_flutter/presentation/byteark_player.dart';
import 'package:flutter/material.dart';

class PlayerPlaylistScreen extends StatelessWidget {
  PlayerPlaylistScreen({super.key});

  static final _licenseKey = ByteArkPlayerLicenseKey(
      android: "ANDROID_LICENSE_KEY", iOS: "IOS_LICENSE_KEY");

  final List<ByteArkPlayerConfig> playerConfigItems = [
    ByteArkPlayerConfig(
        licenseKey: _licenseKey,
        playerItem: ByteArkPlayerItem(
            title: "VOD",
            subtitle: "VOD subtitle",
            url:
                "https://byteark-playertzxedwv.stream-playlist.byteark.com/streams/TZyZheqEJUwC/playlist.m3u8")),
    ByteArkPlayerConfig(
        licenseKey: _licenseKey,
        adsSettings: ByteArkAdsSettings(
            adTagUrl:
                "https://pubads.g.doubleclick.net/gampad/ads?iu=/40391221/byteark_promo_ad_units_1&description_url=[placeholder]&tfcd=0&npa=0&sz=640x480&gdfp_req=1&unviewed_position_start=1&output=vast&env=vp&impl=s&correlator=&vad_type=linear"),
        playerItem: ByteArkPlayerItem(
            title: "VOD with Ads",
            subtitle: "VOD with Ads subtitle",
            url:
                "https://byteark-playertzxedwv.stream-playlist.byteark.com/streams/TZyZheqEJUwC/playlist.m3u8")),
    ByteArkPlayerConfig(
        licenseKey: _licenseKey,
        playerItem: ByteArkPlayerItem(
            title: "VOD with Subtitle",
            subtitle: "VOD with Subtitle subtitle",
            url:
                "https://byteark-playertzxedwv.stream-playlist.byteark.com/streams/TZyZhhLbiVxG/playlist.m3u8")),
    ByteArkPlayerConfig(
        licenseKey: _licenseKey,
        playerItem: ByteArkPlayerItem(
            title: "VOD with Multiple Audio",
            subtitle: "VOD with Multiple Audio subtitle",
            url:
                "https://byteark-playertzxedwv.stream-playlist.byteark.com/streams/UQbEQX4yUCnG/playlist.m3u8")),
    ByteArkPlayerConfig(
        licenseKey: _licenseKey,
        playerItem: ByteArkPlayerItem(
            title: "Live",
            subtitle: "Live subtitle",
            url: "https://thaipbs-live.cdn.byteark.com/live/playlist.m3u8")),
    ByteArkPlayerConfig(
      licenseKey: _licenseKey,
      adsSettings: ByteArkAdsSettings(
          adTagUrl:
              "https://pubads.g.doubleclick.net/gampad/ads?iu=/40391221/byteark_promo_ad_units_1&description_url=[placeholder]&tfcd=0&npa=0&sz=640x480&gdfp_req=1&unviewed_position_start=1&output=vast&env=vp&impl=s&correlator=&vad_type=linear"),
      playerItem: ByteArkPlayerItem(
          title: "Live with Ads",
          subtitle: "Live with Ads subtitle",
          url: "https://thaipbs-live.cdn.byteark.com/live/playlist.m3u8"),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("ByteArk Player Playlist Demo")),
      body: ListView.builder(
        itemCount: playerConfigItems.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(playerConfigItems[index].playerItem?.title ?? "-"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      VideoPlayerScreen(playerConfigItems[index]),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class VideoPlayerScreen extends StatefulWidget {
  final ByteArkPlayerConfig playerConfig;
  const VideoPlayerScreen(this.playerConfig, {super.key});

  @override
  State<StatefulWidget> createState() {
    return _VideoPlayerScreenState();
  }
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late ByteArkPlayer _player;

  @override
  void initState() {
    _player = ByteArkPlayer(playerConfig: widget.playerConfig);
    super.initState();
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.playerConfig.playerItem?.title ?? "-"),
        ),
        body: Column(
          children: [
            AspectRatio(aspectRatio: 16 / 9, child: _player),
            Expanded(
              child: DefaultTabController(
                length: 2,
                child: Column(
                  children: [
                    // Tabs
                    const TabBar(
                      tabs: [
                        Tab(text: "Info"),
                        Tab(text: "Controller"),
                      ],
                    ),
                    Expanded(
                      child: TabBarView(
                        children: [
                          // Tab 1: Video Title & Description
                          VideoInfoTab(
                              widget.playerConfig.playerItem?.title ?? "-",
                              widget.playerConfig.playerItem?.subtitle ?? "-"),
                          // Tab 2: Video Controls
                          VideoControllerTab(widget.playerConfig, _player),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}

class VideoInfoTab extends StatelessWidget {
  final String title;
  final String subTitle;
  const VideoInfoTab(this.title, this.subTitle, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style:
                  const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          Text(subTitle, style: const TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}

class VideoControllerTab extends StatefulWidget {
  final ByteArkPlayerConfig _config;
  final ByteArkPlayer _player;

  const VideoControllerTab(this._config, this._player, {super.key});

  @override
  State<StatefulWidget> createState() => _VideoControllerTabState();
}

class _VideoControllerTabState extends State<VideoControllerTab>
    with AutomaticKeepAliveClientMixin {
  late ByteArkPlayer _player;

  @override
  void initState() {
    _player = widget._player;
    super.initState();
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context); // Ensure AutomaticKeepAlive is applied
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ElevatedButton(
            onPressed: () {
              _player.play();
            },
            child: const Text("Play"),
          ),
          ElevatedButton(
            onPressed: () {
              _player.pause();
            },
            child: const Text("Pause"),
          ),
          ElevatedButton(
            onPressed: () {
              _player.togglePlayback();
            },
            child: const Text("Toggle Playback"),
          ),
          ElevatedButton(
            onPressed: () {
              _player.seekForward();
            },
            child: const Text("Seek Forward"),
          ),
          ElevatedButton(
            onPressed: () {
              _player.seekBackward();
            },
            child: const Text("Seek Backward"),
          ),
          ElevatedButton(
            onPressed: () {
              _player.seekTo(50);
            },
            child: const Text("Seek To"),
          ),
          ElevatedButton(
            onPressed: () {
              _player.switchMediaSource(widget._config);
            },
            child: const Text("Switch Media Source"),
          ),
          ElevatedButton(
            onPressed: () {
              _player.toggleFullScreen();
            },
            child: const Text("Toggle Full Screen"),
          ),
          ElevatedButton(
            onPressed: () async {
              var currentAudio = await _player.getCurrentAudio();
              debugPrint(currentAudio?.toMap().toString());
            },
            child: const Text("Get Current Audio"),
          ),
          ElevatedButton(
            onPressed: () async {
              var audio = await _player.getAudios();
              for (var element in audio) {
                debugPrint(element.toMap().toString());
              }
            },
            child: const Text("Get Audios"),
          ),
          ElevatedButton(
            onPressed: () {
              // var track = ByteArkPlayerMediaTrack(
              //     id: "SxTFInMH:Spanish", name: "Spanish", language: "es");
              var track = ByteArkPlayerMediaTrack(
                  id: "1", name: "Spanish", language: "spa");
              _player.setAudio(track);
            },
            child: const Text("Set Audio"),
          ),
          ElevatedButton(
            onPressed: () async {
              var subtitle = await _player.getCurrentSubtitle();
              debugPrint(subtitle?.toMap().toString());
            },
            child: const Text("Get Current Subtitle"),
          ),
          ElevatedButton(
            onPressed: () async {
              var subTitles = await _player.getSubtitles();
              for (var element in subTitles) {
                debugPrint(element.toMap().toString());
              }
            },
            child: const Text("GetSubtitles"),
          ),
          ElevatedButton(
            onPressed: () {
              // var track = ByteArkPlayerMediaTrack(
              //     id: "subtitle-1:Chinese", name: "Chinese", language: "zh");
              var track = ByteArkPlayerMediaTrack(
                  id: "0", name: "Japanese", language: "jpn");
              _player.setSubtitle(track);
            },
            child: const Text("setSubtitle"),
          ),
          ElevatedButton(
            onPressed: () async {
              var subtitle = await _player.getCurrentResolution();
              debugPrint(subtitle?.toMap().toString());
            },
            child: const Text("Get Current Resolution"),
          ),
          ElevatedButton(
            onPressed: () async {
              var subTitles = await _player.getResolutions();
              for (var element in subTitles) {
                debugPrint(element.toMap().toString());
              }
            },
            child: const Text("Get Resolutions"),
          ),
          ElevatedButton(
            onPressed: () {
              // var track = ByteArkPlayerMediaTrack(id: "3", name: "720p");
              var track = ByteArkPlayerMediaTrack(id: "3", name: "240p");
              _player.setResolution(track);
            },
            child: const Text("Set Resolution"),
          ),
          ElevatedButton(
            onPressed: () async {
              var playbackSpeed = await _player.getCurrentPlaybackSpeed();
              debugPrint(playbackSpeed.toString());
            },
            child: const Text("Get Current PlaybackSpeed"),
          ),
          ElevatedButton(
            onPressed: () async {
              var playbackSpeeds = await _player.getAvailablePlaybackSpeeds();
              for (var element in playbackSpeeds) {
                debugPrint(element.toString());
              }
            },
            child: const Text("Get Available PlaybackSpeeds"),
          ),
          ElevatedButton(
            onPressed: () {
              _player.setPlaybackSpeed(1.0);
            },
            child: const Text("Set PlaybackSpeed"),
          ),
          ElevatedButton(
              onPressed: () async {
                var time = await _player.getCurrentTime();
                debugPrint(time.toString());
              },
              child: const Text("Get CurrentTime")),
          ElevatedButton(
            onPressed: () async {
              var duration = await _player.getDuration();
              debugPrint(duration.toString());
            },
            child: const Text("Get Duration"),
          ),
        ],
      ),
    );
  }
}
