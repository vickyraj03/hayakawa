import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hayakawa_new/config/get_it/get_instances.dart';

import 'package:hayakawa_new/cubit/recorder/recorder_state.dart';
import 'package:hayakawa_new/cubit/recorder/recorer_cubit.dart';
import 'package:hayakawa_new/models/recorder/recorder_class_model.dart';
import 'package:hayakawa_new/models/recorder/recorder_model.dart';
import 'package:hayakawa_new/models/recorder/video_model.dart';
import 'package:hayakawa_new/screens/dashboard_screen/classes/Live_video.dart';
import 'package:hayakawa_new/screens/dashboard_screen/classes/additional_class.dart';
import 'package:hayakawa_new/screens/dashboard_screen/classes/checking,dart';
import 'package:hayakawa_new/widgets/Container/new_Container.dart';
import 'package:hayakawa_new/widgets/Error_text/error_text.dart';
import 'package:hayakawa_new/widgets/appIcon.dart';
import 'package:hayakawa_new/widgets/style/app_color.dart';
import 'package:hayakawa_new/widgets/style/font_size.dart';
import 'package:hayakawa_new/widgets/style/style_insets.dart';
import 'package:hayakawa_new/widgets/style/style_space.dart';
import 'package:hayakawa_new/widgets/style/text_style.dart';
import 'package:video_player/video_player.dart';
// import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../config/request/request.dart';
import '../../../cubit/active_class/active_class_cubit.dart';

class Recorder extends StatefulWidget {
  String studentId;
  String crhId;
  String jlptlevel;
  Recorder(
      {super.key,
      required this.studentId,
      required this.crhId,
      required this.jlptlevel});

  @override
  State<Recorder> createState() => _RecorderState();
}

class _RecorderState extends State<Recorder> {
  late RecorderClassCubit _recorderCubit;
  RecorderData? recorderData;
  bool isActive = true;
  bool isComplete = false;

  @override
  void initState() {
    super.initState();
    _recorderCubit = getItInstance<RecorderClassCubit>();
    _loadRecorderclass();
  }

  _loadRecorderclass() async {
    _recorderCubit.getBatchs(jsonEncode(
        BatchRequest(widget.studentId, widget.crhId, widget.jlptlevel)));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RecorderClassCubit, RecorderState>(
        bloc: _recorderCubit,
        builder: (context, state) {
          if (state is RecorderLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is ErrorState) {
            return ErrorTxt(
              message: '${state.error}',
              ontap: () => _loadRecorderclass(),
            );
          }

          if (state is BatchLoaded) {
            if (state.batch.result == "success") {
              recorderData = state.batch.data!;
              if (recorderData!.batchList!.isNotEmpty) {
                return RecorderUI();
              } else {
                return Center(child: Text(''));
              }
            }

            if (state.batch.result == "error") {
              return Center(child: Text(''));
            } else {
              Future.delayed(Duration.zero, () async {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(""),
                ));
              });
            }
          }
          return CircularProgressIndicator();
        },
        listener: (conttext, state) {
          if (state is BatchLoaded) {
            if (state.batch.result == "success") {
              recorderData = state.batch.data!;
              print("Helooooooooooooooooooooo");
            }
          }
        });
    // return BlocConsumer<RecorderClassCubit, RecorderState>(
    //     bloc: _recorderCubit,
    //     builder: (context, state) {
    //       if (state is RecorderLoading) {
    //         return Center(child: CircularProgressIndicator());
    //        } else if (state is ErrorState) {
    //         return ErrorTxt(
    //           message: '${state.error}',
    //           ontap: () => _loadRecorderclass(),
    //         );
    //       }

    //       if (state is BatchLoaded) {
    //         if (state.batch.result == "success") {
    //           recorderData = state.batch.data!;
    //           if(recorderData!.batchList!.isNotEmpty){
    //             return RecorderUI();
    //           }else{
    //             return Center(child: Text(''));
    //           }
    //         }

    //          if (state.batch.result == "error") {

    //             return Center(child: Text('No data found'));

    //         } else {
    //           Future.delayed(Duration.zero, () async {
    //             ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    //               content: Text(""),
    //             ));
    //           });
    //         }
    //       }
    //       return CircularProgressIndicator();
    //     },
    //     listener: (conttext, state) {
    //       if (state is BatchLoaded) {
    //       if (state.batch.result == "success") {
    //           recorderData = state.batch.data!;

    //         }
    //       }
    //     });
  }

  Widget RecorderUI() {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.appPrimaryColor,
        centerTitle: true,
        // automaticallyImplyLeading: false,
        //  leading: Icon(Icons.drag_handle),
        title: AppIcon(
          icon: AppIcons.hayakawa_red_white,
          size: Insets.xxl * 2.5,
          color: AppColors.PrimaryColor,
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          VSpace(Insets.lg),
          Padding(
            padding: EdgeInsets.only(bottom: Insets.sm, left: Insets.sm),
            child: textStyle(text: 'Class', style: TextStyles.h2),
          ),
          VSpace.med,
          Padding(
            padding: EdgeInsets.only(left: Insets.sm),
            child: Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () => setState(() {
                    isActive = true;
                    isComplete = false;
                  }),
                  child: DecoratedContainer(
                    padding: EdgeInsets.symmetric(
                        horizontal: Insets.xl, vertical: Insets.sm),
                    clipFCorner: true,
                    tabDecoration: isActive == true ? true : false,
                    fullcontainer: isComplete == false ? true : false,
                    child: textStyle(
                      text: 'Recorded Videos',
                      style: isActive == true
                          ? TextStyles.body3w
                              .copyWith(color: AppColors.PrimaryColor)
                          : TextStyles.body3,
                    ),
                  ),
                ),
                HSpace.lg,
                GestureDetector(
                  onTap: () => setState(() {
                    isComplete = true;
                    isActive = false;
                  }),
                  child: DecoratedContainer(
                    clipFCorner: true,
                    tabDecoration: isComplete == true ? true : false,
                    fullcontainer: isActive == false ? true : false,
                    padding: EdgeInsets.symmetric(
                        horizontal: Insets.xl, vertical: Insets.sm),
                    child: textStyle(
                        text: 'Additional Videos',
                        style: isComplete == false
                            ? TextStyles.body3
                            : TextStyles.body3w.copyWith(
                                color: AppColors.PrimaryColor,
                              )),
                  ),
                ),
              ],
            ),
          ),
          VSpace.med,
          Visibility(
              visible: isActive,
              child: Expanded(
                  child: Padding(
                padding: EdgeInsets.all(Insets.sm),
                child: RecorderVideo(),
              ))),
          Visibility(
              visible: isComplete,
              child: Expanded(
                  child: Padding(
                padding: EdgeInsets.all(Insets.sm),
                child: AdditionalClass(
                    studentId: widget.studentId,
                    crhId: widget.crhId,
                    jlptlevel: widget.jlptlevel),
              ))),
        ],
      ),
    );
  }

  Widget RecorderVideo() {
    return Column(
      children: [
        textStyle(text: '${recorderData?.courseName}'),
        VSpace.med,
        textStyle(text: 'SENSEI : ${recorderData?.teacherName}'),
        Expanded(
          child: ListView.builder(
              itemCount: recorderData?.batchList?.length,
              itemBuilder: (context, index) {
                print(
                    "###################### ${recorderData?.batchList?.length}");
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => youtubeClass(
                                  batchId:
                                      "${recorderData?.batchList![index].batchId}",
                                )));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DecoratedContainer(
                      clipFCorner: true,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: Insets.lg, horizontal: Insets.lg),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            textStyle(
                                text:
                                    '${recorderData?.batchList![index].batchName}'),
                            Icon(Icons.arrow_forward_ios)
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }),
        )
      ],
    );
  }
}

class youtubeClass extends StatefulWidget {
  String batchId;
  youtubeClass({super.key, required this.batchId});

  @override
  State<youtubeClass> createState() => _youtubeClassState();
}

class _youtubeClassState extends State<youtubeClass> {
  late RecorderClassCubit _recorderCubit;
  RecorderClass? _class;
  VideoData? _videoData;

  @override
  void initState() {
    super.initState();
    _recorderCubit = getItInstance<RecorderClassCubit>();
    _loadRecorderclass();
  }

  _loadRecorderclass() async {
    _recorderCubit.getClass(jsonEncode(ClassRequest(widget.batchId)));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RecorderClassCubit, RecorderState>(
        bloc: _recorderCubit,
        builder: (context, state) {
          if (state is RecorderLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is ErrorState) {
            return ErrorTxt(
              message: '${state.error}',
              ontap: () => _loadRecorderclass(),
            );
          }

          if (state is ClassLoaded) {
            if (state.classData.result == "success") {
              _class = state.classData.data!;
              if (_class!.classList!.isNotEmpty) {
                return _VideoUI();
              } else {
                return Center(child: Text(''));
              }
            }

            if (state.classData.result == "error") {
              return Center(child: Text(''));
            } else {
              Future.delayed(Duration.zero, () async {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(""),
                ));
              });
            }
          }
          return CircularProgressIndicator();
        },
        listener: (conttext, state) {
          if (state is ClassLoaded) {
            if (state.classData.result == "success") {
              _class = state.classData.data!;
              print("classssssssssssss");
            }
          }

          if (state is VideoLoaded) {
            if (state.videoData.result == "success") {
              _videoData = state.videoData.data;
            }
          }
        });
  }

  Widget _VideoUI() {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.appPrimaryColor,
        centerTitle: true,
        // automaticallyImplyLeading: false,
        //  leading: Icon(Icons.drag_handle),
        title: AppIcon(
          icon: AppIcons.hayakawa_red_white,
          size: Insets.xxl * 2.5,
          color: AppColors.PrimaryColor,
        ),
      ),
      body: Column(children: [
        VSpace.med,
        textStyle(text: 'SENSEI : ${_class?.teacherName}'),
        Expanded(
          child: ListView.builder(
              itemCount: _class?.classList?.length,
              itemBuilder: (context, index) {
                print("###################### ${_class?.classList?.length}");
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => VideoPlayers(
                                classID: '${_class?.classList![index].id}')));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DecoratedContainer(
                      clipFCorner: true,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: Insets.lg, horizontal: Insets.lg),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            textStyle(
                                text:
                                    'Class ${_class?.classList![index].className}'),
                            Icon(Icons.arrow_forward_ios)
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }),
        ),
      ]),
    );
  }
}

class VideoPlayers extends StatefulWidget {
  String classID;
//  String videoUrl;
  VideoPlayers({super.key, required this.classID});

  @override
  State<VideoPlayers> createState() => _VideoPlayersState();
}

class _VideoPlayersState extends State<VideoPlayers> {
  late RecorderClassCubit _recorderCubit;
  VideoData? _videoModel;

// late YoutubePlayerController _controller;
  @override
  void initState() {
    super.initState();
    _recorderCubit = getItInstance<RecorderClassCubit>();
    _loadRecorderclass();
    // videoUrl = _videoModel!.videoUrl!;
  }

  _loadRecorderclass() async {
    _recorderCubit.getVideo(jsonEncode(VideoRequest(widget.classID)));
    //  await loadVideo();
  }

  // loadVideo(){
  //    _controller = YoutubePlayerController(
  //     initialVideoId:YoutubePlayer.convertUrlToId('${_videoModel!.videoUrl}')!,
  //     flags: const YoutubePlayerFlags(
  //       mute: false,
  //       autoPlay: true,
  //       disableDragSeek: false,
  //       loop: false,
  //       isLive: false,
  //       forceHD: false,
  //       enableCaption: true,
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RecorderClassCubit, RecorderState>(
        bloc: _recorderCubit,
        builder: (context, state) {
          if (state is RecorderLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is ErrorState) {
            return ErrorTxt(
              message: '${state.error}',
              ontap: () => _loadRecorderclass(),
            );
          }

          if (state is VideoLoaded) {
            if (state.videoData.result == "success") {
              _videoModel = state.videoData.data!;
              if (_videoModel!.videoUrl != "") {
                return MyWidgetVideo(Url: _videoModel!.videoUrl!);
              } else {
                return Center(child: Text(''));
              }
            }

            if (state.videoData.result == "error") {
              return Center(child: Text(''));
            } else {
              Future.delayed(Duration.zero, () async {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(""),
                ));
              });
            }
          }
          return CircularProgressIndicator();
        },
        listener: (conttext, state) {
          if (state is VideoLoaded) {
            if (state.videoData.result == "success") {
              _videoModel = state.videoData.data!;
              print("Helooooooooooooooooooooo");
            }
          }
        });
  }

//  Widget VideoYouTube(){
//   return Scaffold(
//   appBar: AppBar(
//         backgroundColor: Colors.red,
//         centerTitle: true,
//         // automaticallyImplyLeading: false,
//         //  leading: Icon(Icons.drag_handle),
//         title: AppIcon(
//           icon: AppIcons.hayakawa_red_white,
//           size: Insets.xxl * 2.5,
//           color: AppColors.PrimaryColor,
//         ),
//       ),
//   body:
//   YoutubePlayer(
//         controller: YoutubePlayerController(
//       initialVideoId:_videoModel!.videoUrl!,
//       flags: const YoutubePlayerFlags(
//         mute: false,
//         autoPlay: true,
//         disableDragSeek: false,
//         loop: false,
//         isLive: false,
//         forceHD: false,
//         enableCaption: true,
//       ),
//     ),
//         showVideoProgressIndicator: true,
//         progressIndicatorColor: Colors.blueAccent,
//         topActions: <Widget>[
//           const SizedBox(width: 8.0),
//           Expanded(
//             child: Text(
//               _controller.metadata.title,
//               style: const TextStyle(
//                 color: Colors.white,
//                 fontSize: 18.0,
//               ),
//               overflow: TextOverflow.ellipsis,
//               maxLines: 1,
//             ),
//           ),
// ])
// );
//  }
}
