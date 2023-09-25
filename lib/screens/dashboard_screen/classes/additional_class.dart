import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hayakawa_new/models/recorder/video_model.dart';
import 'package:hayakawa_new/screens/dashboard_screen/classes/Live_video.dart';
import 'package:hayakawa_new/screens/dashboard_screen/classes/checking,dart';
import 'package:hayakawa_new/widgets/Container/new_Container.dart';
import 'package:hayakawa_new/widgets/Error_text/error_text.dart';
import 'package:hayakawa_new/widgets/appIcon.dart';
import 'package:hayakawa_new/widgets/style/app_color.dart';
import 'package:hayakawa_new/widgets/style/font_size.dart';
import 'package:hayakawa_new/widgets/style/style_insets.dart';
import 'package:hayakawa_new/widgets/style/style_space.dart';
import 'package:hayakawa_new/widgets/style/text_style.dart';

import '../../../config/get_it/get_instances.dart';
import '../../../config/request/request.dart';
import '../../../cubit/additional_class/additional_class_cubit.dart';
import '../../../cubit/additional_class/additional_class_state.dart';
import '../../../models/additional_class/additional_class_model.dart';

class AdditionalClass extends StatefulWidget {
  AdditionalClass(
      {super.key,
      required this.studentId,
      required this.crhId,
      required this.jlptlevel});

  String studentId;
  String crhId;
  String jlptlevel;

  @override
  State<AdditionalClass> createState() => _AdditionalClassState();
}

class _AdditionalClassState extends State<AdditionalClass> {
  late AdditionaClassCubit _additional;

  Data? _additionalClass;

  @override
  void initState() {
    super.initState();
    _additional = getItInstance<AdditionaClassCubit>();
    _loadAdditionalclass();
    // _loadActiveclass();
  }

  _loadAdditionalclass() async {
    // _recorderCubit.getBatchs(jsonEncode(BatchRequest(widget.studentId,widget.crhId,widget.jlptlevel)));
    _additional.getAdditonalClass(jsonEncode(
        AdditionalRequest(widget.studentId, widget.crhId, widget.jlptlevel)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocConsumer<AdditionaClassCubit, AdditionalState>(
            bloc: _additional,
            builder: (context, state) {
              if (state is AdditionalLoading) {
                return Center(child: CircularProgressIndicator());
              } else if (state is ErrorState) {
                return ErrorTxt(
                  message: '${state.error}',
                  ontap: () => _loadAdditionalclass(),
                );
              }

              if (state is AdditionalLoaded) {
                if (state.additionalClass.result == "success") {
                  _additionalClass = state.additionalClass.data;
                  if (_additionalClass!.purchasedStatus == 1) {
                    return _additionalUI();
                  } else if (_additionalClass!.purchasedStatus == 0) {
                    return Padding(
                      padding: EdgeInsets.all(Insets.lg),
                      child: textStyle(
                          text:
                              'Sorry, you are not subscribed for additional class videos!'),
                    );
                  } else {
                    return Center(child: Text(''));
                  }
                }

                if (state.additionalClass.result == "error") {
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
              // if (state is ClassLoaded) {
              // if (state.classData.result == "success") {
              //     _class = state.classData.data!;
              //     print("classssssssssssss");

              //   }
              // }

              // if(state is VideoLoaded){
              //   if(state.videoData.result == "success"){
              //        _videoData = state.videoData.data;
              //   }
              // }
            }));
  }

  Widget _additionalUI() {
    return Column(
      children: [
        textStyle(text: '${_additionalClass?.courseName}'),
        VSpace.med,
        // textStyle(text: '${_additionalClass?.purchasedStatus}'),
        Expanded(
          child: ListView.builder(
              itemCount: _additionalClass?.batchList?.length,
              itemBuilder: (context, index) {
                print(
                    "###################### ${_additionalClass?.batchList?.length}");
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                AdditionalClassList(
                                  batchId:
                                      "${_additionalClass!.batchList![index].batchId}",
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
                                    '${_additionalClass?.batchList![index].batchName}'),
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

class AdditionalClassList extends StatefulWidget {
  AdditionalClassList({super.key, required this.batchId});
  String batchId;

  @override
  State<AdditionalClassList> createState() => _AdditionalClassListState();
}

class _AdditionalClassListState extends State<AdditionalClassList> {
  late AdditionaClassCubit _additional;

  List<ClassList>? classList;
  AdditonalClass1Result? _adittionalClass;

  @override
  void initState() {
    super.initState();
    _additional = getItInstance<AdditionaClassCubit>();
    _loadAdditionalclass();
    // _loadActiveclass();
  }

  _loadAdditionalclass() async {
    // _recorderCubit.getBatchs(jsonEncode(BatchRequest(widget.studentId,widget.crhId,widget.jlptlevel)));
    _additional
        .getAdditonalClass1(jsonEncode(AdditionalClassRequest(widget.batchId)));
  }

  @override
  Widget build(BuildContext context) {
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
        body: BlocConsumer<AdditionaClassCubit, AdditionalState>(
            bloc: _additional,
            builder: (context, state) {
              if (state is AdditionalLoading) {
                return Center(child: CircularProgressIndicator());
              } else if (state is ErrorState) {
                return ErrorTxt(
                  message: '${state.error}',
                  ontap: () => _loadAdditionalclass(),
                );
              }

              if (state is AdditionalClassLoaded) {
                if (state.additionalClass.result == "success") {
                  classList = state.additionalClass.cassresult?.classList;
                  _adittionalClass = state.additionalClass.cassresult;
                  if (classList!.isNotEmpty) {
                    return _VideoUI();
                  } else {
                    return Center(child: Text(''));
                  }
                }

                if (state.additionalClass.result == "error") {
                  return Center(child: Text(''));
                } else {
                  Future.delayed(Duration.zero, () async {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(""),
                    ));
                  });
                }
              }
              return const CircularProgressIndicator();
            },
            listener: (conttext, state) {}));
  }

  Widget _VideoUI() {
    return Scaffold(
        body: Column(
      children: [
        VSpace.med,
        textStyle(text: 'SENSEI : ${_adittionalClass?.teacherName}'),
        Expanded(
          child: ListView.builder(
              itemCount: classList!.length,
              itemBuilder: (context, index) {
                print("###################### ${classList?.length}");
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => VideoPlayers(
                                classID: '${classList![index].id}')));
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
                                text: 'Class ${classList![index].className}'),
                            Icon(Icons.arrow_forward_ios)
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }),
        ),
      ],
    ));
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
  late AdditionaClassCubit _additionaClassCubit;
  AdditonalClassVideo? _videoModel;

// late YoutubePlayerController _controller;
  @override
  void initState() {
    super.initState();
    _additionaClassCubit = getItInstance<AdditionaClassCubit>();
    _loadRecorderclass();
    // videoUrl = _videoModel!.videoUrl!;
  }

  _loadRecorderclass() async {
    _additionaClassCubit.getVideo(jsonEncode(VideoRequest(widget.classID)));
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
    return BlocConsumer<AdditionaClassCubit, AdditionalState>(
        bloc: _additionaClassCubit,
        builder: (context, state) {
          if (state is AdditionalLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is ErrorState) {
            return ErrorTxt(
              message: '${state.error}',
              ontap: () => _loadRecorderclass(),
            );
          }

          if (state is AdditionaVideoLoaded) {
            if (state.videoModel.result == "success") {
              _videoModel = state.videoModel;
              if (_videoModel?.data?.videoUrl != "") {
                return MyWidgetVideo(Url: _videoModel!.data!.videoUrl!);
              } else {
                return Center(child: Text(''));
              }
            }

            if (state.videoModel.result == "error") {
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
          if (state is AdditionaVideoLoaded) {
            if (state.videoModel.result == "success") {
              _videoModel = state.videoModel;
              print("Helooooooooooooooooooooo");
            }
          }
        });
  }
}
