import 'package:byteark_player_flutter/data/byteark_player_config.dart';
import 'package:byteark_player_flutter/data/byteark_player_item.dart';
import 'package:byteark_player_flutter/data/byteark_player_license_key.dart';
import 'package:byteark_player_flutter/data/byteark_player_subtitle_size.dart';
import 'package:demo_byteark_player_flutter_integration/screens/byteark_player_screen.dart';
import 'package:flutter/material.dart';

class PlayerConfigPage extends StatefulWidget {
  const PlayerConfigPage({super.key});

  @override
  _PlayerConfigPageState createState() => _PlayerConfigPageState();
}

class _PlayerConfigPageState extends State<PlayerConfigPage> {
  bool _autoPlay = true;
  bool _backButton = true;
  bool _control = true;
  bool _muted = false;
  bool _pip = false;
  bool _seekButtons = true;
  bool _shareButton = false;
  bool _fullScreenButton = true;
  bool _settingButton = true;
  bool _secureSurface = false;
  bool _allowBackgroundPlaying = false;
  bool _subtitleBg = true;
  bool _enableAds = false;

  int _seekTime = 10;
  int _subtitlePadding = 5;
  ByteArkPlayerSubtitleSize _subtitleSize = ByteArkPlayerSubtitleSize.medium;
  double _playbackSpeed = 1.0;

  void _startPlayer() {
    final item = ByteArkPlayerItem(
      url:
          "https://byteark-playertzxedwv.stream-playlist.byteark.com/streams/TZyZheqEJUwC/playlist.m3u8",
      title: "Sample Video",
      subtitle: "Sample Video Description",
    );

    final config = ByteArkPlayerConfig(
      licenseKey: ByteArkPlayerLicenseKey(android: "ANDROID_KEY", iOS: ''),
      autoPlay: _autoPlay,
      control: _control,
      seekButtons: _seekButtons,
      seekTime: _seekTime,
      fullScreenButton: _fullScreenButton,
      settingButton: _settingButton,
      secureSurface: _secureSurface,
      subtitleBackgroundEnabled: _subtitleBg,
      subtitlePaddingBottomPercentage: _subtitlePadding,
      subtitleSize: _subtitleSize,
      playerItem: item,
      adsSettings: _enableAds
          ? ByteArkAdsSettings(
              adTagUrl:
                  "https://pubads.g.doubleclick.net/gampad/ads?iu=/21775744923/external/single_ad_samples&sz=640x480&cust_params=sample_ct%3Dlinear&ciu_szs=300x250%2C728x90&gdfp_req=1&output=vast&unviewed_position_start=1&env=vp&impl=s&correlator=",
            )
          : null,
    );

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ByteArkPlayerScreen(config: config),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('ByteArk Player Config')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          SwitchListTile(
            title: Text('Auto Play'),
            value: _autoPlay,
            onChanged: (v) => setState(() => _autoPlay = v),
          ),
          SwitchListTile(
            title: Text('Back Button'),
            value: _backButton,
            onChanged: (v) => setState(() => _backButton = v),
          ),
          SwitchListTile(
            title: Text('Controls'),
            value: _control,
            onChanged: (v) => setState(() => _control = v),
          ),
          SwitchListTile(
            title: Text('Muted'),
            value: _muted,
            onChanged: (v) => setState(() => _muted = v),
          ),
          SwitchListTile(
            title: Text('Picture in Picture'),
            value: _pip,
            onChanged: (v) => setState(() => _pip = v),
          ),
          SwitchListTile(
            title: Text('Seek Buttons'),
            value: _seekButtons,
            onChanged: (v) => setState(() => _seekButtons = v),
          ),
          SwitchListTile(
            title: Text('Share Button'),
            value: _shareButton,
            onChanged: (v) => setState(() => _shareButton = v),
          ),
          SwitchListTile(
            title: Text('Full Screen Button'),
            value: _fullScreenButton,
            onChanged: (v) => setState(() => _fullScreenButton = v),
          ),
          SwitchListTile(
            title: Text('Setting Button'),
            value: _settingButton,
            onChanged: (v) => setState(() => _settingButton = v),
          ),
          SwitchListTile(
            title: Text('Secure Surface'),
            value: _secureSurface,
            onChanged: (v) => setState(() => _secureSurface = v),
          ),
          SwitchListTile(
            title: Text('Background Playing'),
            value: _allowBackgroundPlaying,
            onChanged: (v) => setState(() => _allowBackgroundPlaying = v),
          ),
          SwitchListTile(
            title: Text('Subtitle Background'),
            value: _subtitleBg,
            onChanged: (v) => setState(() => _subtitleBg = v),
          ),
          SwitchListTile(
            title: Text('Enable Ads'),
            value: _enableAds,
            onChanged: (v) => setState(() => _enableAds = v),
          ),
          ListTile(
            title: Text('Seek Time (sec): $_seekTime'),
            trailing: Slider(
              value: _seekTime.toDouble(),
              min: 5,
              max: 60,
              divisions: 11,
              label: '$_seekTime s',
              onChanged: (v) => setState(() => _seekTime = v.toInt()),
            ),
          ),
          ListTile(
            title: Text('Subtitle Padding: $_subtitlePadding%'),
            trailing: Slider(
              value: _subtitlePadding.toDouble(),
              min: 0,
              max: 20,
              divisions: 20,
              label: '$_subtitlePadding%',
              onChanged: (v) => setState(() => _subtitlePadding = v.toInt()),
            ),
          ),
          ListTile(
            title: Text('Subtitle Size'),
            trailing: DropdownButton<ByteArkPlayerSubtitleSize>(
              value: _subtitleSize,
              items: ByteArkPlayerSubtitleSize.values.map((size) {
                return DropdownMenuItem(
                  value: size,
                  child: Text(size.toString().split('.').last),
                );
              }).toList(),
              onChanged: (size) {
                if (size != null) {
                  setState(() => _subtitleSize = size);
                }
              },
            ),
          ),
          ListTile(
            title: Text('Playback Speed: ${_playbackSpeed}x'),
            trailing: Slider(
              value: _playbackSpeed,
              min: 0.5,
              max: 2.0,
              divisions: 3,
              label: '${_playbackSpeed}x',
              onChanged: (v) => setState(() => _playbackSpeed = v),
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _startPlayer,
            child: Text('Launch Player'),
          ),
        ],
      ),
    );
  }
}
