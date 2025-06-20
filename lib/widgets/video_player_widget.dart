// import 'package:flutter/material.dart';
// import 'package:byteark_player_flutter/byteark_player_flutter.dart';

// class VideoPlayerWidget extends StatelessWidget {
//   final BytearkPlayerController controller;
//   final bool isFullscreen;
//   final Function(bool) onFullscreenToggle;

//   const VideoPlayerWidget({
//     super.key,
//     required this.controller,
//     required this.isFullscreen,
//     required this.onFullscreenToggle,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return AspectRatio(
//       aspectRatio: 16 / 9,
//       child: Stack(
//         children: [
//           BytearkPlayer(
//             controller: controller,
//             onFullscreenToggle: onFullscreenToggle,
//           ),
//           Positioned(
//             bottom: 0,
//             left: 0,
//             right: 0,
//             child: Container(
//               padding: const EdgeInsets.all(8.0),
//               decoration: BoxDecoration(
//                 gradient: LinearGradient(
//                   begin: Alignment.bottomCenter,
//                   end: Alignment.topCenter,
//                   colors: [
//                     Colors.black.withOpacity(0.7),
//                     Colors.transparent,
//                   ],
//                 ),
//               ),
//               child: Row(
//                 children: [
//                   StreamBuilder<Duration>(
//                     stream: controller.positionStream,
//                     builder: (context, snapshot) {
//                       final position = snapshot.data ?? Duration.zero;
//                       return Text(
//                         '${position.inMinutes}:${(position.inSeconds % 60).toString().padLeft(2, '0')}',
//                         style: const TextStyle(color: Colors.white),
//                       );
//                     },
//                   ),
//                   const SizedBox(width: 8),
//                   Expanded(
//                     child: StreamBuilder<Duration>(
//                       stream: controller.positionStream,
//                       builder: (context, snapshot) {
//                         final position = snapshot.data ?? Duration.zero;
//                         return Slider(
//                           value: position.inSeconds.toDouble(),
//                           max: controller.duration?.inSeconds.toDouble() ?? 0,
//                           onChanged: (value) {
//                             controller.seekTo(Duration(seconds: value.toInt()));
//                           },
//                         );
//                       },
//                     ),
//                   ),
//                   StreamBuilder<Duration>(
//                     stream: controller.durationStream,
//                     builder: (context, snapshot) {
//                       final duration = snapshot.data ?? Duration.zero;
//                       return Text(
//                         '${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}',
//                         style: const TextStyle(color: Colors.white),
//                       );
//                     },
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
