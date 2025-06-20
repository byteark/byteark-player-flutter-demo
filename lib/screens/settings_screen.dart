import 'package:flutter/material.dart';
import 'package:byteark_player_flutter/data/byteark_player_subtitle_size.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _autoplay = false;
  bool _loop = false;
  bool _control = true;
  bool _seekButtons = true;
  bool _fullScreenButton = true;
  bool _settingButton = true;
  bool _secureSurface = false;
  bool _subtitleBg = true;
  bool _enableAds = false;

  String _selectedQuality = 'Auto';
  final List<String> _qualities = ['Auto', '1080p', '720p', '480p', '360p'];

  int _seekTime = 10;
  int _subtitlePadding = 5;
  ByteArkPlayerSubtitleSize _subtitleSize = ByteArkPlayerSubtitleSize.medium;
  double _playbackSpeed = 1.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Player Settings'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
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
          SwitchListTile(
            title: const Text('Loop'),
            subtitle: const Text('Repeat video when finished'),
            value: _loop,
            onChanged: (value) {
              setState(() {
                _loop = value;
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
              contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
          SwitchListTile(
            title: const Text('Seek Buttons'),
            subtitle: const Text('Show forward/backward buttons'),
            value: _seekButtons,
            onChanged: (value) {
              setState(() {
                _seekButtons = value;
              });
            },
          ),
          ListTile(
            title: const Text('Seek Time'),
            subtitle: Text('$_seekTime seconds'),
            trailing: SizedBox(
              width: 200,
              child: Slider(
                value: _seekTime.toDouble(),
                min: 5,
                max: 60,
                divisions: 11,
                label: '$_seekTime s',
                onChanged: (v) => setState(() => _seekTime = v.toInt()),
              ),
            ),
          ),
          SwitchListTile(
            title: const Text('Full Screen Button'),
            subtitle: const Text('Show full screen toggle button'),
            value: _fullScreenButton,
            onChanged: (value) {
              setState(() {
                _fullScreenButton = value;
              });
            },
          ),
          SwitchListTile(
            title: const Text('Settings Button'),
            subtitle: const Text('Show settings menu button'),
            value: _settingButton,
            onChanged: (value) {
              setState(() {
                _settingButton = value;
              });
            },
          ),
          SwitchListTile(
            title: const Text('Secure Surface'),
            subtitle: const Text('Prevent screen capture'),
            value: _secureSurface,
            onChanged: (value) {
              setState(() {
                _secureSurface = value;
              });
            },
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
          SwitchListTile(
            title: const Text('Subtitle Background'),
            subtitle: const Text('Show background behind subtitles'),
            value: _subtitleBg,
            onChanged: (value) {
              setState(() {
                _subtitleBg = value;
              });
            },
          ),
          ListTile(
            title: const Text('Subtitle Size'),
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
                onChanged: (v) => setState(() => _subtitlePadding = v.toInt()),
              ),
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'Ads Settings',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          SwitchListTile(
            title: const Text('Enable Ads'),
            subtitle: const Text('Show ads during playback'),
            value: _enableAds,
            onChanged: (value) {
              setState(() {
                _enableAds = value;
              });
            },
          ),
          const SizedBox(height: 24),
          const Text(
            'Player Events',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Available Events:'),
                  const SizedBox(height: 8),
                  _buildEventItem(
                      'onPlayerReady', 'Triggered when player is ready'),
                  _buildEventItem(
                      'onPlay', 'Triggered when video starts playing'),
                  _buildEventItem('onPause', 'Triggered when video is paused'),
                  _buildEventItem(
                      'onEnded', 'Triggered when video playback ends'),
                  _buildEventItem('onError', 'Triggered when an error occurs'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEventItem(String event, String description) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.arrow_right, size: 20),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  event,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  description,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
