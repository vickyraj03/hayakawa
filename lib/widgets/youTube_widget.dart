// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:visibility_detector/visibility_detector.dart';
// import 'package:youtube_player_flutter/youtube_player_flutter.dart';

// class YoutubeWidget extends StatefulWidget {
//   YoutubeWidget({super.key, required this.videoUrl});
//   String videoUrl;

//   @override
//   State<YoutubeWidget> createState() => _YoutubeWidgetState();
// }

// class _YoutubeWidgetState extends State<YoutubeWidget> {
//   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
//   late YoutubePlayerController _controller;
//   late TextEditingController _idController;
//   late TextEditingController _seekToController;
//   late PlayerState _playerState;

//   bool _isPlayerReady = false;
//   late String videoId;

//   @override
//   void initState() {
//     super.initState();
//     videoId = YoutubePlayer.convertUrlToId(widget.videoUrl)!;
//     _controller = YoutubePlayerController(
//       initialVideoId: videoId,
//       flags: const YoutubePlayerFlags(
//         mute: false,
//         autoPlay: false,
//         disableDragSeek: false,
//         loop: false,
//         isLive: false,
//         forceHD: false,
//         enableCaption: true,
//       ),
//     )..addListener(listener);
//     _idController = TextEditingController();
//     _seekToController = TextEditingController();
//   }

//   void listener() {
//     if (_isPlayerReady && mounted && !_controller.value.isFullScreen) {
//       setState(() {
//         _playerState = _controller.value.playerState;
//         // _videoMetaData = _controller.metadata;
//       });
//     }
//   }

//   @override
//   void deactivate() {
//     // Pauses video while navigating to next page.
//     _controller.pause();
//     super.deactivate();
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     _idController.dispose();
//     _seekToController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 200,
//       color: Colors.blue,
//       child: VisibilityDetector(
//         key: const Key("unique key"),
//         onVisibilityChanged: (info) {
//           if (info.visibleFraction == 0) {
//             _controller.pause();
//           } else {
//             _controller.value.isPlaying
//                 ? _controller.play()
//                 : _controller.pause();
//           }
//         },
//         child: YoutubePlayerBuilder(
//           onEnterFullScreen: () {
//             SystemChrome.setPreferredOrientations(
//                 [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
//           },
//           onExitFullScreen: () {
//             SystemChrome.setPreferredOrientations([
//               DeviceOrientation.landscapeRight,
//               DeviceOrientation.landscapeLeft
//             ]);
//             // The player forces portraitUp after exiting fullscreen. This overrides the behaviour.
//             // SystemChrome.setPreferredOrientations(DeviceOrientation.values);
//           },
//           player: YoutubePlayer(
//             controller: _controller,
//             showVideoProgressIndicator: true,
//             progressIndicatorColor: Colors.blueAccent,
//             topActions: <Widget>[
//               const SizedBox(width: 8.0),
//               Expanded(
//                 child: Text(
//                   _controller.metadata.title,
//                   style: const TextStyle(
//                     color: Colors.white,
//                     fontSize: 18.0,
//                   ),
//                   overflow: TextOverflow.ellipsis,
//                   maxLines: 1,
//                 ),
//               ),
//             ],
//             onReady: () {
//               _controller.addListener(listener);
//             },
//             onEnded: (data) {},
//           ),
//           builder: (context, player) => Scaffold(
//             key: _scaffoldKey,
//             body: ListView(
//               children: [
//                 player,
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
