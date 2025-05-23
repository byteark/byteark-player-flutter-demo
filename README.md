# ByteArk Player Plugin

![Pub Version](https://img.shields.io/pub/v/byteark_player_flutter)

The ByteArk Player plugin is a powerful and flexible video player package designed for seamless integration into Flutter applications. This plugin provides a smooth video playback experience, supports various media formats, and is highly customizable to suit your application's requirements. Whether you're developing a media app, an educational platform, or any project requiring video playback, ByteArk Player makes it simple to get started.

**Disclaimer:**
This is the non-commercial version of ByteArk Player. Commercial use and/or business support requires a license. Please contact sales@byteark.com to get more information about our solutions.

|             | Android | iOS   |
|-------------|---------|-------|
| **Support** | SDK 21+ | 14.0+ |

![The screenshot](https://byteark-sdk.st-th-1.byteark.com/assets/images/byteark_player_flutter_screenshot.jpg)

---

# Installation

### Use this package to integrate the ByteArk Player plugin into your project. Follow the instructions across Flutter, Android, and iOS platforms.

## Flutter Integration


1. Add the dependency

   
   1. Add the ByteArk Player plugin to your project by running this command in your terminal

      ```none
      $ flutter pub add byteark_player_flutter
      ```

   This command automatically updates your `pubspec.yaml`  file to include the ByteArk Player package and runs the `flutter pub get` command.

   \
   **Alternatively**, you can manually add the following line in your `pubspec.yaml` file under `dependencies`

   ```javascript
   dependencies:
     byteark_player: ^1.0.6 // Put the latest version of the plugin.
   ```

   If you manually edited your `pubspec.yaml` file, you can run this command to fetch the new dependency

   ```javascript
   $ flutter pub get
   ```
2. Import and use ByteArk Player widget

   
   1. Now, you can start using the **ByteArk Player** plugin in your Dart code by importing it at the top of your file

      ```javascript
      import 'package:byteark_player_flutter/presentation/byteark_player.dart';
      .
      .
      ByteArkPlayer(playerConfig: playerConfig)
      ```


---

## iOS Configuration

To integrate ByteArk Player into your Flutter iOS project using CocoaPods, follow these steps


1. Cocoapods will install SDK directly from Github private repository using ssh key, if you haven't set an ssh key to your Github account please follow [Adding a new SSH key to your GitHub account](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/adding-a-new-ssh-key-to-your-github-account) document on Github website.
2. Open `Podfile`

   
   1. Navigate to your iOS project directory and open the `Podfile`, Add the following code into the file.

```javascript
// Set platform to iOS 14
platform :ios, '14.0'
.
.
.
// Specify the sources for CocoaPods to fetch the required dependencies:
source 'https://github.com/CocoaPods/Specs.git'
source 'https://github.com/byteark/byteark-player-sdk-ios-specs.git'
source 'https://github.com/byteark/lighthouse-sdk-native-ios-specs.git'
```


2. Install the Pods

   
   1. Open a terminal window and navigate to the `ios` directory of your Flutter project, Run the following command to install the CocoaPods dependencies and update the repository

      ```javascript
      pod install --repo-update
      ```
3. Open the Workspace

   
   1. After running `pod install --repo-update`, CocoaPods will create an Xcode workspace file (`.xcworkspace`), Open this workspace in Xcode
4. Build and Run

   
   1. After making the above changes, **build and run your project** on an iOS simulator or physical device to verify the integration.


---

## Android Configuration

To integrate ByteArk Player into your Flutter Android project, follow these steps


1. **Modify the AndroidManifest.xml**

   
   1. Navigate to `android/app/src/main/AndroidManifest.xml` and apply the following changes

      
      1. **Add required permissions** for network access, foreground services, and boot reception. Add these lines inside the `<manifest>`

         ```none
         <uses-permission android:name="android.permission.INTERNET"/>
         <uses-permission android:name="android.permission.ACCESS_NETWORK_STATE"/>
         <uses-permission android:name="android.permission.FOREGROUND_SERVICE"/>
         <uses-permission android:name="android.permission.RECEIVE_BOOT_COMPLETED"/>
         ```
      2. Set a theme for `android:resource` using the `@style/Theme.AppCompat` attribute inside the `<activity>`, This allows you to apply a theme compatible with `FlutterFragmentActivity`, such as `@style/Theme.AppCompat` or any other `AppCompat-based` or `MaterialComponents` theme.

         ```javascript
         <meta-data
                android:name="io.flutter.embedding.android.NormalTheme"
                android:resource="@style/Theme.AppCompat"/>
         ```
      3. **Add ByteArk Player Service** inside the `<application>` to enable media browsing and service functionality

         ```javascript
         <!-- ByteArk -->
         <service android:name="com.byteark.bytearkplayercore.handler.exoplayer.service.ByteArkPlayerService"
               android:enabled="true"
               android:exported="true">
               <intent-filter>
                    <action android:name="androidx.media3.session.MediaLibraryService"/>
                    <action android:name="android.media.browse.MediaBrowserService" />
               </intent-filter>
         </service>
         ```
      4. **Add** Nielsen inside the `<application>` to enable Nielsen service functionality

         ```swift
         <!--Nielsen-->
         <meta-data
               android:name="com.google.android.gms.ads.APPLICATION_ID"
               android:value="ca-app-pub-3940256099942544~3347511713"/>
         ```
2. Navigate to `android/app/src/main/kotlin/com/example/your_project_name/MainActivity.kt` and update the main activity

   
   1. **Extend** `FlutterFragmentActivity()` to ensure proper integration

      ```kotlin
      import io.flutter.embedding.android.FlutterFragmentActivity
      
      class MainActivity: FlutterFragmentActivity()
      ```
3. Configure Local Properties

   
   1. In the `android/local.properties` file, set up your GitLab private tokens for `ByteArk Player` and `ByteArk LightHouse`.
   2. Add the following lines, replacing `[YOUR_PRIVATE_TOKEN]` with the token provided by the ByteArk team

      ```javascript
      gitLabByteArkPlayerPrivateToken=[YOUR_PRIVATE_TOKEN]
      gitLabByteArkLighthousePrivateToken=[YOUR_PRIVATE_TOKEN]
      ```
4. Build and Run

   
   1. After making the above changes, **build and run your project** on an Android emulator or physical device to verify the integration.


---

# Usage

Here's a basic example of how to use **ByteArk Player widget** to play a video in your Flutter app

```javascript
import 'package:byteark_player_flutter/data/byteark_player_license_key.dart';
import 'package:byteark_player_flutter/domain/byteark_player_listener.dart';
import 'package:flutter/material.dart';
import 'package:byteark_player_flutter/data/byteark_player_config.dart';
import 'package:byteark_player_flutter/data/byteark_player_item.dart';
import 'package:byteark_player_flutter/presentation/byteark_player.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // Declare required variables
  late ByteArkPlayerItem _item;
  late ByteArkPlayerConfig _config;
  late ByteArkPlayerListener _listener;
  late ByteArkPlayer _player;

  @override
  void initState() {
    super.initState();

    // Step 1: Create a listener to handle player and ad events
    _listener = ByteArkPlayerListener(
      onPlayerReady: () {
        debugPrint("Player is ready.");
      },
      onAdsStart: (data) {
        debugPrint("Ad started. Data: ${data.toMap()}");
      },
    );

    // Step 2: Define the video source using ByteArkPlayerItem
    _item = ByteArkPlayerItem(
      url:
          "https://byteark-playertzxedwv.stream-playlist.byteark.com/streams/TZyZheqEJUwC/playlist.m3u8",
    );

    // Step 3: Configure the player using ByteArkPlayerConfig
    _config = ByteArkPlayerConfig(
      // Optional : Set up ads if needed.
      adsSettings: ByteArkAdsSettings(
        adTagUrl:
            "https://pubads.g.doubleclick.net/gampad/ads?iu=/21775744923/external/single_ad_samples&sz=640x480&cust_params=sample_ct%3Dlinear&ciu_szs=300x250%2C728x90&gdfp_req=1&output=vast&unviewed_position_start=1&env=vp&impl=s&correlator=",
      ),
      licenseKey: ByteArkPlayerLicenseKey(
        android: "ANDROID_KEY", // Replace with your Android license key
        iOS: "IOS_KEY", // Replace with your iOS license key
      ),
      playerItem: _item,
    );

    // Step 4: Initialize the ByteArkPlayer with the config and listener
    _player = ByteArkPlayer(playerConfig: _config, listener: _listener);
  }

  @override
  void dispose() {
    // Clean up player instance.
    _player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ByteArk Player Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('ByteArk Player Demo'),
          centerTitle: true,
        ),
        body: Column(
          children: [
            // Step 5: Embed the player into your UI using AspectRatio
            AspectRatio(
              aspectRatio: 16 / 9,
              child: _player,
            ),
            const SizedBox(height: 16),
            // Optional: Add controls to interact with the player
            ElevatedButton(
              onPressed: () => _player.pause(),
              child: const Text("Pause"),
            ),
          ],
        ),
      ),
    );
  }
}
```


---

# Player Configuration

## ByteArkPlayerItem

The ByteArkPlayerItem class represents a media item to be played in the ByteArk Player. It contains essential metadata and properties necessary for configuring and displaying the media content.

```swift
class ByteArkPlayerItem {
  final String? mediaId; // A unique identifier for the media item.
  final String? posterImage; // URL of the poster image for the media item.
  final String? title; // Title of the media item.
  final String? subtitle; // Subtitle or description of the media item.
  final String? url; // URL for the media content (e.g., video or audio).
  final String? shareUrl; // URL for sharing the media item.
  final ByteArkNielsenMetaData? nielsenMetaData; // Nielsen metadata associated with the media item.
  final ByteArkDrm? drm; // Digital Rights Management settings for the media item.
}
```

| **Property** Name | Type | Description |
|----|----|----|
| `mediaId` | String? | A unique identifier for the media item, used for tracking and referencing. |
| `posterImage` | String? | URL of the poster image associated with the media item, used for display in the player UI. |
| `title` | String? | The title of the media item, which may be displayed in the player interface. |
| `subtitle` | String? | A subtitle or description of the media item, providing additional context to the user. |
| `url` (required) | String? | URL for the media content (e.g., video or live), where the player fetches the media for playback. |
| `shareUrl` | String? | A URL specifically for sharing the media item, allowing users to easily share content with others. |
| `nielsenMetaData` | ByteArkNielsenMetaData? | Contains Nielsen metadata associated with the media item, used for analytics and tracking purposes. |
| `drm` | ByteArkDrm? | Contains Digital Rights Management settings for the media item, ensuring proper content protection. |

## ByteArkPlayerConfig

The ByteArkPlayerConfig class is used to configure various settings and features of the ByteArk Player. Each property can be set to customize the player's behavior and appearance.

```swift
class ByteArkPlayerConfig {
  final ByteArkPlayerLicenseKey licenseKey; // The license key of the player contains both the Android and iOS keys.
  final bool? autoPlay; // Automatically start playback when the player is ready.
  final bool? backButton; // Show a back button for navigating back.
  final VoidCallback? backButtonAction; // Action to perform when the back button is pressed.
  final bool? control; // Show playback controls (play, pause, etc.) on the UI.
  final bool? muted; // Start the player in a muted state.
  final bool? pictureInPicture; // Enable Picture-in-Picture mode.
  final bool? seekButtons; // Show seek buttons for navigating the media.
  final int? seekTime; // Duration in seconds to seek forward or backward.
  final ByteArkPlayerItem? playerItem; // The media item to be played.
  final ByteArkPlayerPlaylist? playlist; // Playlist of media items to play.
  final bool? shareButton; // Show a button to share the media.
  final bool? fullScreenButton; // Show a button to toggle fullscreen mode.
  final bool? settingButton; // Show a settings button for player options.
  final bool? secureSurface; // Enable a secure surface for playback (e.g., for DRM).
  final bool? allowBackgroundPlaying; // Allow playback to continue in the background.
  final ByteArkPlaybackSetting? playbackSetting; // Custom playback settings (e.g., speed).
  final ByteArkNielsenSetting? nielsenSetting; // Nielsen tracking settings for media.
  final ByteArkLighthouseSetting? lighthouseSetting; // Lighthouse tracking settings for media.
  final ByteArkChromeCastSetting? chromeCastSetting; // Chromecast settings for streaming.
  final ByteArkAdsInsertionSetting? adsInsertionSetting; // Settings for ad insertion during playback.
  final ByteArkAdsSettings? adsSettings; // General ad settings for the player.
  final bool? secureSurface; // Determines whether the player should use a secure surface for rendering protected content.
  final ByteArkPlayerSubtitleSize? subtitleSize; // Set subtitle size.
  final bool? subtitleBackgroundEnabled; // enable or disable subtitle background.
  final int? subtitlePaddingBottomPercentage; /// Specifies the bottom padding for subtitles as a percentage.
}
```

| **Property** Name | Type | Description |
|----|----|----|
| `licenseKey`  (required) | ByteArkPlayerLicenseKey | The license key of the player contains both the Android and iOS keys. |
| `autoPlay` | bool? | Automatically starts playback when the player is ready. |
| `backButton` | bool? | Determines if a back button should be displayed for navigation. |
| `backButtonAction` | VoidCallback? | Defines the action to perform when the back button is pressed. |
| `control` | bool? | Indicates whether playback controls (play, pause, etc.) should be shown on the UI. |
| `muted` | bool? | Specifies if the player should start in a muted state. |
| `pictureInPicture` | bool? | Enables Picture-in-Picture mode for the player. |
| `seekButtons` | bool? | Controls the visibility of seek buttons for navigating through the media. |
| `seekTime` | int? | Sets the duration in seconds for seeking forward or backward. |
| `playerItem` (required) | ByteArkPlayerItem? | Specifies the media item to be played. |
| `playlist` | ByteArkPlayerPlaylist? | Defines a playlist of media items for playback. |
| `shareButton` | bool? | Determines if a share button should be displayed for sharing the media. |
| `fullScreenButton` | bool? | Indicates if a button for toggling fullscreen mode should be shown. |
| `settingButton` | bool? | Controls the visibility of a settings button for player options. |
| `secureSurface` | bool? | Enables a secure surface for playback, which is useful for DRM content. |
| `allowBackgroundPlaying` | bool? | Allows playback to continue when the app is in the background. |
| `playbackSetting` | ByteArkPlaybackSetting? | Contains custom playback settings (e.g., speed, quality). |
| `nielsenSetting` | ByteArkNielsenSetting? | Defines settings for Nielsen tracking related to media consumption. |
| `lighthouseSetting` | ByteArkLighthouseSetting? | Contains settings for Lighthouse tracking related to media consumption. |
| `chromeCastSetting` | ByteArkChromeCastSetting? | Defines settings for Chrome cast integration and functionality. |
| `adsInsertionSetting` | ByteArkAdsInsertionSetting? | Specifies settings for ad insertion during media playback. |
| `adsSettings` | ByteArkAdsSettings? | Contains general ad settings for the player. |
| `secureSurface` | bool? | Set this to `true`  to prevent screenshot capture or video recording of a video player. |
| `subtitleSize` | ByteArkPlayerSubtitleSize? | Defines the subtitle size, default to medium. |
| `subtitleBackgroundEnabled` | bool? | Specifies whether a background should be displayed behind subtitles. |
| `subtitlePaddingBottomPercentage` | int? (1-100) | Specifies the bottom padding for subtitles as a percentage. |


---

# Player APIs

The SDK provided methods and variables that can access from ByteArkPlayer instance to control playback behavior or get information from media content.

## ByteArkPlayerController

The ByteArkPlayerController class provides an interface for controlling media playback in the ByteArk Player, This class interacts with the underlying platform-specific implementation to perform media control operations.

| Function Name | Description |
|----|----|
|  `play()` | Starts or resumes media playback. |
|  `pause()` | Pauses the current media playback. |
|  `togglePlayback()` | Toggles between playing and pausing the media. |
|  `seekForward()` | Seeks the media forward by a preset interval. |
|  `seekBackward()` | Seeks the media backward by a preset interval. |
|  `seekTo(int position)` | Seeks to a specific position in the media (in seconds).\[position\] is the target position in the media. |
|  `switchMediaSource(ByteArkPlayerConfig config)` |  Switches the current media source to a new one.\[config\] contains the configuration for the new media source. |
|  `toggleFullScreen()` | Toggles between fullscreen and normal display modes. |
| `dispose()` | Releases resources used by the player and performs cleanup. |
| `currentPosition()` | Retrieves the current playback position in seconds. |
| `getCurrentAudio()` | Gets the current audio track. |
| `getAudios()` | Gets the list of available audio tracks. |
| `setAudio(ByteArkPlayerMediaTrack track)` | Sets the current audio track. |
| `getCurrentSubtitle()` | Gets the current subtitle. |
| `getSubtitles()` | Gets the list of available subtitles. |
| `setSubtitle(ByteArkPlayerMediaTrack track)` | Sets the subtitle. |
| `getCurrentResolution()` | Gets the current resolution. |
| `getResolutions()` | Gets the list of available resolutions. |
| `setResolution(ByteArkPlayerMediaTrack track)` | Sets the video resolution. |
| `getAvailablePlaybackSpeeds()` | Gets the available playback speeds. |
| `getCurrentPlaybackSpeed()` | Gets the current playback speed. |
| `setPlaybackSpeed(double speed)` | Sets the playback speed. |
| `getCurrentTime()` | Gets the current time. |
| `getDuration()` | Gets the duration of content. |


### Example usage

```swift
late ByteArkPlayerItem _item;
late ByteArkPlayerConfig _config;
late ByteArkPlayer _player;

@override
void initState() {
  super.initState();

  // Step 1: Define the video source using ByteArkPlayerItem
  // Replace the URL with your actual video stream URL
  _item = ByteArkPlayerItem(
    url: "https://byteark-playertzxedwv.stream-playlist.byteark.com/streams/TZyZheqEJUwC/playlist.m3u8",
  );

  // Step 2: Configure the player with license key and video item
  // Replace license keys with your valid Android/iOS keys
  _config = ByteArkPlayerConfig(
    licenseKey: ByteArkPlayerLicenseKey(
      android: "ANDROID_KEY", // Your Android license key here
      iOS: "IOS_KEY",         // Your iOS license key here
    ),
    playerItem: _item,
  );

  // Step 3: Create the player using the config
  _player = ByteArkPlayer(playerConfig: _config);
}

// Step 4: Add player controls (e.g., play button)
ElevatedButton(
  onPressed: () {
    // Call play function to start the video
    _player.play();
  },
  child: const Text("Play"),
);

@override
void dispose() {
  // Step 5: Always dispose of the player when done to release resources
  _player.dispose();
  super.dispose();
}
```


---

## ByteArkPlayerEventChannel

This section sets up an event listener to handle various events emitted by the ByteArk Player. The listener subscribes to a stream (ByteArkPlayerEventChannel.stream) and reacts to different events, which correspond to changes in the player's state, such as playback actions, fullscreen changes, or errors. Each event is identified by an enum value from ByteArkPlayerEventTypes

| Event | Description |
|----|----|
| `onPlayerReady` | Triggered when the player is ready for interaction. |
| `onPlayerLoadingMetadata` | Triggered when the player starts loading media metadata. |
| `onPlaybackFirstPlay` | Triggered when the media starts playing for the first time. |
| `onPlaybackPlay` | Triggered when the media playback resumes. |
| `onPlaybackPause` | Triggered when the media playback is paused. |
| `onPlaybackSeeking` | Triggered when seeking in the media begins. |
| `onPlaybackSeeked` | Triggered when the seek operation completes. |
| `onPlaybackEnded` | Triggered when the media playback reaches the end. |
| `onPlaybackTimeupdate` | Triggered at regular intervals to update the current playback time. |
| `onPlaybackBuffering` | Triggered when the media enters a buffering state. |
| `onPlaybackBuffered` | Triggered when buffering completes. |
| `onPlaybackError` | Triggered when a playback error occurs. |
| `onPlayerEnterFullscreen` | Triggered when the player enters fullscreen mode. |
| `onPlayerExitFullscreen` | Triggered when the player exits fullscreen mode. |
| `onPlayerEnterPictureInPictureMode` | Triggered when the player enters Picture-in-Picture mode. |
| `onPlayerExitPictureInPictureMode` | Triggered when the player exits Picture-in-Picture mode. |
| `onPlaybackResolutionChanged` | Triggered when the playback resolution changes. |
| `onAdsRequest` | An ad request. |
| `onAdsBreakStart` | An ad break starts (multiple ads may play in sequence). |
| `onAdsBreakEnd` | An ad break ends. |
| `onAdsStart` (return ByteArkPlayerAdsData) | An ad starts playing. |
| `onAdsImpressed` (return ByteArkPlayerAdsData) | An impression is recorded for the ad. |
| `onAdsCompleted` (return ByteArkPlayerAdsData) | An ad finishes playing. |
| `onAdsFirstQuartile` (return ByteArkPlayerAdsData) | The first 25% of the ad has been played. |
| `onAdsMidPoint` (return ByteArkPlayerAdsData) | 50% of the ad has been played. |
| `onAdsThirdQuartile` (return ByteArkPlayerAdsData) | 75% of the ad has been played. |
| `onAdsClicked` (return ByteArkPlayerAdsData) | The user clicks on the ad. |
| `onAdsSkipped` (return ByteArkPlayerAdsData) | The user skips the ad. |
| `onAllAdsCompleted` | All ads in the ad break have finished playing. |
| `onAdsError` (return ByteArkPlayerAdsErrorData) | An error occurs in the ad manager. |

### Example usage

```swift
  // Step 1: Declare a listerner.
  late ByteArkPlayerListener _listener;

  @override
  void initState() {
    super.initState();
    
    // Step 2: Create a listener to handle player and ad events
    _listener = ByteArkPlayerListener(
      onPlayerReady: () {
        debugPrint("Player is ready.");
      },
      onAdsStart: (data) {
        debugPrint("Ad started. Data: ${data.toMap()}");
      },
    );
    
    // Step 3: add listener to ByteArkPlayer.
    _player = ByteArkPlayer(
      playerConfig: _config,
      listener: _listener,
    );

  }
```


---