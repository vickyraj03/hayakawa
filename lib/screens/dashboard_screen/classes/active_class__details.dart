
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hayakawa_new/config/data/perferences.dart';
import 'package:hayakawa_new/models/Classs/active_class_model.dart';
import 'package:hayakawa_new/models/dashboard_model/dashboard_model.dart';
import 'package:hayakawa_new/screens/dashboard_screen/classes/recorder.dart';
import 'package:hayakawa_new/screens/login_screen/sign_up_page.dart';
import 'package:hayakawa_new/widgets/Container/new_Container.dart';
import 'package:hayakawa_new/widgets/appIcon.dart';
import 'package:hayakawa_new/widgets/style/app_color.dart';
import 'package:hayakawa_new/widgets/style/font_size.dart';
import 'package:hayakawa_new/widgets/style/style_insets.dart';
import 'package:hayakawa_new/widgets/style/style_space.dart';
import 'package:hayakawa_new/widgets/style/text_style.dart';
import 'package:hayakawa_new/screens/dashboard_screen/classes/checking,dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hayakawa_new/screens/dashboard_screen/classes/Live_video.dart';

import 'package:http/http.dart' as http;

import 'dart:convert' as JSON;

import 'package:url_launcher/url_launcher.dart';

List<LiveDetails> classDetailButton = const <LiveDetails>[
  LiveDetails(title: 'Live', icon: "assets/img/live.jpg"),
  LiveDetails(title: 'Youtube', icon: "assets/img/youtube.jpg"),
];

class ActiveClassDetails extends StatefulWidget {
  ActiveClassResult activeClassResult;
  ActiveClassDetails({super.key, required this.activeClassResult});

  @override
  State<ActiveClassDetails> createState() => _ActiveClassDetailsState();
}

class _ActiveClassDetailsState extends State<ActiveClassDetails> {
  var _studentId,
      _url,
      _scheduleInfo,
      _assInfo,
      _presInfo,
      _mediaInfo,
      _listenInfo;
  var zoom_url, g_url;
  var msg1, mesg;
  var ref, betch_id, cj_lel, up_grde;
  var _urlLive, _urlYoutube, _urlSeminor, _urlHistory;
  String? url, url_intership, jat_url;
  String? test1, test2;
  String? header, mess;
  String? batch_header, batch_message;
  String? expiredDate, batchstatus;
  bool? valDate;
  String? _urlcourse_complete;
  String FromDate = "From Date";
  String ToDate = "To Date";
  // VideoPlayerController _controller;
  var msgg;

  final List<LiveDetails> classDetailButtonList = [
];
  _fetchInitstate() async {
   
    print('---test----');
    // print(classDetailButton.length);

    // print(classDetailButton[1].title);
    for (int i = 0; i < classDetailButton.length; i++) {
      if (classDetailButton[i].title == "Schedule") {
        if (widget.activeClassResult.batch!.batchSchedule!.isNotEmpty) {
          classDetailButtonList.add(
            LiveDetails(
                title: classDetailButton[i].title,
                icon: classDetailButton[i].icon),
          );
        }
        if (widget.activeClassResult.tblCourse!.progType == "Interactive") {
          classDetailButtonList.add(
            LiveDetails(
                title: 'Interactive', icon: "assets/svg/INTERACTIVE.svg"),
          );
        }

        if (widget.activeClassResult.tblCourse!.progType != "Distance" &&
            widget.activeClassResult.tblCourse!.upgradeType != "ReActivation") {
          classDetailButtonList.add(
            LiveDetails(
                title: 'LeaveInfo', icon: "assets/img/leave-information.png"),
          );
          classDetailButtonList.add(
            LiveDetails(title: 'Attendance', icon: "assets/img/attendance.png"),
          );
        }
        if (widget.activeClassResult.batch!.status == "3" &&
            widget.activeClassResult.tblCourse!.upgradeType != "ReActivation") {
          classDetailButtonList.add(
            LiveDetails(
                title: "Course_complete", icon: "assets/img/certificate.png"),
          );
        }

        if (widget.activeClassResult.batch!.status == "3" ||
            widget.activeClassResult.tblCourse!.upgradeType == "ReActivation") {
          classDetailButtonList.add(
            LiveDetails(title: "Cjat Exam", icon: "assets/img/exams.png"),
          );
        } else if (widget.activeClassResult.tblCourse!.progType != "Distance" &&
            widget.activeClassResult.tblCourse!.upgradeType != "ReActivation") {
          classDetailButtonList.add(
            LiveDetails(title: "Test-1", icon: "assets/img/books.png"),
          );
          classDetailButtonList.add(
            LiveDetails(title: "Test-2", icon: "assets/img/books.png"),
          );
        }
      } else if (classDetailButton[i].title == "Re-Join" ||
          classDetailButton[i].title == "ReActivate" ||
          classDetailButton[i].title == "XTRA Class") {
        if (widget.activeClassResult.tblCourse!.jlptlevel != 'BJT') {
          if (widget.activeClassResult.tblCourse!.courseType != 'Spoken') {
            classDetailButtonList.add(
              LiveDetails(
                  title: classDetailButton[i].title,
                  icon: classDetailButton[i].icon),
            );
          }
        }
        // } else if (classDetailButton[i].title == "ReActivate") {
        //   if ((_info.tblCourse.jlptlevel != 'BJT') ||
        //       (_info.tblCourse.jlptlevel != 'SPOKEN')) {
        //     classDetailButtonList.add(
        //       LiveDetails(
        //           title: classDetailButton[i].title,
        //           icon: classDetailButton[i].icon),
        //     );
        //   }
      } else {
        classDetailButtonList.add(
          LiveDetails(
              title: classDetailButton[i].title,
              icon: classDetailButton[i].icon),
        );
      }
    }
    //classDetailButtonList.add();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    var studentId = Preferences.getUserid();
    var url = 'https://www.hayakawa.in/app/';
    setState(() {
      _studentId = studentId;
      _url = url;
      _urlcourse_complete =
          'https://hayakawa.in/app/download_certificate.php?batch_name=' +
              widget.activeClassResult.batch!.batchName! +
              '&prog_type=' +
              widget.activeClassResult.tblCourse!.progType! +
              '&batch_id=' +
              widget.activeClassResult.batch!.id! +
              '&ref_id=' +
              widget.activeClassResult.courseHistory!.refId! +
              '&student_id=' +
              _studentId +
              '&course_id=' +
              widget.activeClassResult.courseHistory!.courseId!;
      //  print(_urlcourse_complete);

      url_intership = 'https://www.hayakawa.in/app/' +
          "internship.php?studentId=" +
          studentId!;
    });
    _urlHistory =
        _url + "appmocktest-history-result.php?studentId=" + studentId;
    _urlLive = _url +
        "appliveclass.php?studentId=" +
        _studentId +
        "&crh_id=" +
        widget.activeClassResult.courseHistory!.crhId +
        "&jlevel=" +
        widget.activeClassResult.tblCourse!.jlptlevel;
    _urlYoutube = _url +
        "apprecordedclass.php?studentId=" +
        _studentId +
        "&crh_id=" +
        widget.activeClassResult.courseHistory!.crhId +
        "&jlptlevel=" +
        widget.activeClassResult.tblCourse!.jlptlevel;
    _urlSeminor = widget.activeClassResult.batch!
        .batchScheduleUrl; // _url + "studyinjapan.php?studentId=" + _studentId;
  }

  _interactive() async {
    final response = await http.get(Uri.parse(
        'https://www.hayakawa.in/app/get-interactive-message.php?batch_id=' +
            widget.activeClassResult.batch!.id!));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      final jsonDecoded = JSON.jsonDecode(response.body);
      final results =Response(data: jsonDecoded, status: ServiceStatus.success);
      final loginResult = interactivemodel.fromJson(results.data);
      debugPrint('Api${jsonDecoded}');
      print(loginResult.message);

      setState(() {
        batch_header = loginResult.message!;
        batch_message = loginResult.batch_message!;
        zoom_url = loginResult.zoomUrl;
        g_url = loginResult.googleClassroom;

        print("Hellooo    ${batch_message}");
        mesg = batch_message!.split(" ");

        var tt = mesg[23];
        msg1 = tt.split("meeting:");
        msgg = msg1[1].trim();
        print("Hey        ${msgg}");
      });
      // _showAlert(
      //   context,
      //   batch_header,
      // );
Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      IntractiveClass(interactive: loginResult,)));

      //alertDlgInter(context, batch_header.toString());
      // _alertMsg(context, batch_message);
      return results;

      // return checkmodel.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

 

  alertDlgInter(BuildContext context, String message) async =>
      //Product add to cart

      showDialog(
          context: context,
          builder: (BuildContext context) {
            var alertDialog = Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(Consts.padding),
              ),
              elevation: 0.0,
              backgroundColor: Colors.transparent,
              child: Stack(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(
                      top: Consts.avatarRadius + Consts.padding,
                      bottom: Consts.padding,
                      left: Consts.padding,
                      right: Consts.padding,
                    ),
                    margin: EdgeInsets.only(top: Consts.avatarRadius),
                    decoration: new BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(Consts.padding),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 10.0,
                          offset: const Offset(0.0, 10.0),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment:CrossAxisAlignment.start, // To make the card compact
                      children: <Widget>[
                        Text(
                          "${batch_message}",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.w500),
                        ),
                        
                        SizedBox(height: 24.0),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                        //   children: <Widget>[
                        //     Align(
                        //         alignment: Alignment.bottomCenter,
                        //         child: IconButton(
                        //           icon: Image.asset(
                        //             "assets/img/Zoom_logo.png",
                        //           ),
                        //           iconSize: 60,
                        //           onPressed: () {
                        //             _lun();
                        //           },
                        //         )
                        //         // ElevatedButton(
                        //         //   onPressed: () {
                        //         //     Navigator.of(context)
                        //         //         .pop(); // To close the dialog
                        //         //   },
                        //         //   child: Text('Proceed Later'),
                        //         // ),
                        //         ),
                        //     Align(
                        //         alignment: Alignment.bottomRight,
                        //         child: IconButton(
                        //           icon: Image.asset(
                        //             "assets/img/google-classroom.jpg",
                        //           ),
                        //           iconSize: 100,
                        //           onPressed: () {
                        //             _Glink();
                        //           },
                        //         )
                        //         // ElevatedButton(
                        //         //   onPressed: () {},
                        //         //   child: Text('Proceed Now'),
                        //         // ),
                        //         ),
                        //   ],
                        // ),
                      ],
                    ),
                  ),
                  Positioned(
                      top: 45,
                      left: 10,
                      right: 10,
                      child: Material(
                        elevation: 0.0,
                        shape: CircleBorder(),
                        clipBehavior: Clip.hardEdge,
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child:  SvgPicture.asset(
                              'assets/svg/Hayakawa_new_logo.svg',
                              color: Colors.red[900],
                            ),
                        ),
                      )),
                ],
              ),
            );
            return alertDialog;
          });

  @override
  Widget build(BuildContext context) {
    classDetailButtonList.clear();
    widget.activeClassResult.tblCourse!.progType == "Interactive" && widget.activeClassResult.batch!.status == "2"? classDetailButtonList.add( LiveDetails(title: 'Interactive', icon: "assets/svg/INTERACTIVE.svg"),):"";
    classDetailButtonList.add( LiveDetails(title: 'Live', icon: "assets/svg/LIVE.svg"),);
    classDetailButtonList.add(  LiveDetails(title: 'Recorded', icon: "assets/svg/RECORDED.svg"),);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[900],
        centerTitle: true,
        // automaticallyImplyLeading: false,
        //  leading: Icon(Icons.drag_handle),
        title: AppIcon(
          icon: AppIcons.hayakawa_red_white,
          size: Insets.xxl * 2.5,
          color: AppColors.PrimaryColor,
        ),
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          VSpace.med,
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: Insets.sm, vertical: Insets.sm),
            child: IntrinsicHeight(
              child: DecoratedContainer(
                clipFCorner: true,
                child: Column(
                  children: [
                    DecoratedContainer(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(
                            horizontal: Insets.xs, vertical: Insets.sm),
                        color: Colors.red[900],
                        //   clipFCorner: true,
                        child: Column(
                          children: [
                            textStyle(
                              text: widget
                                  .activeClassResult.tblCourse!.courseName!,
                              style: TextStyles.body1
                                  .copyWith(color: AppColors.PrimaryColor),
                            ),
                            VSpace.xs,
                            textStyle(
                              text: widget.activeClassResult.batch!.batchName!,
                              style: TextStyles.body1
                                  .copyWith(color: AppColors.PrimaryColor),
                            ),
                          ],
                        )),
                    VSpace.xs,
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: Insets.lg, vertical: Insets.xs),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                              flex: 2,
                              child: textStyle(
                                text: 'Course Type',
                                style: TextStyles.subTitle2
                                    .copyWith(fontWeight: FontWeight.bold),
                              )),
                          Expanded(
                             flex: 2,
                              child: textStyle(
                            text:
                                widget.activeClassResult.tblCourse!.courseType!,
                            style: TextStyles.body2
                                .copyWith(color: AppColors.kTextThird),
                            textAlign: TextAlign.right,
                          )),
                        ],
                      ),
                    ),
                    VSpace.xs,
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: Insets.lg, vertical: Insets.xs),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                              flex: 2,
                              child: textStyle(
                                text: 'Program Type',
                                style: TextStyles.subTitle2
                                    .copyWith(fontWeight: FontWeight.bold),
                              )),
                          Expanded(
                             flex: 2,
                              child: textStyle(
                            text: widget.activeClassResult.tblCourse!.progType!,
                            style: TextStyles.body2
                                .copyWith(color: AppColors.kTextThird),
                            textAlign: TextAlign.right,
                          )),
                        ],
                      ),
                    ),
                    VSpace.xs,
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: Insets.lg, vertical: Insets.xs),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                              flex: 2,
                              child: textStyle(
                                text: 'Duration',
                                style: TextStyles.subTitle2
                                    .copyWith(fontWeight: FontWeight.bold),
                              )),
                          Expanded(
                             flex: 2,
                              child: textStyle(
                            text: widget
                                .activeClassResult.tblCourse!.courseDuration!,
                            style: TextStyles.body2
                                .copyWith(color: AppColors.kTextThird),
                            textAlign: TextAlign.right,
                          )),
                        ],
                      ),
                    ),
                    VSpace.xs,
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: Insets.lg, vertical: Insets.xs),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                              flex: 2,
                              child: textStyle(
                                text: 'Starts',
                                style: TextStyles.subTitle2
                                    .copyWith(fontWeight: FontWeight.bold),
                              )),
                          Expanded(
                             flex: 2,
                              child: textStyle(
                            text: widget.activeClassResult.others!.startDate
                                .toString(),
                            style: TextStyles.body2
                                .copyWith(color: AppColors.kTextThird),
                            textAlign: TextAlign.right,
                          )),
                        ],
                      ),
                    ),
                    VSpace.xs,
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: Insets.lg, vertical: Insets.xs),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                              flex: 2,
                              child: textStyle(
                                text: 'Ends',
                                style: TextStyles.subTitle2
                                    .copyWith(fontWeight: FontWeight.bold),
                              )),
                          Expanded(
                             flex: 2,
                              child: textStyle(
                            text: widget.activeClassResult.others!.endDate
                                .toString(),
                            style: TextStyles.body2
                                .copyWith(color: AppColors.kTextThird),
                            textAlign: TextAlign.right,
                          )),
                        ],
                      ),
                    ),
                    VSpace.xs,
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: Insets.lg, vertical: Insets.xs),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                              flex: 2,
                              child: textStyle(
                                text: 'Time',
                                style: TextStyles.subTitle2
                                    .copyWith(fontWeight: FontWeight.bold),
                              )),
                          Expanded(
                             flex: 2,
                              child: textStyle(
                            text: widget.activeClassResult.batch!.timing!,
                            style: TextStyles.body2
                                .copyWith(color: AppColors.kTextThird),
                            textAlign: TextAlign.right,
                          )),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            height: 400,
            child: GridView.count(
              crossAxisCount: 3,
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              children: List.generate(
                  classDetailButtonList.length == null
                      ? 2
                      : classDetailButtonList.length, (index) {
                return GestureDetector(
                  onTap: () {
                    switch (classDetailButtonList[index].title) {
                      case "Interactive":
                        {
                          _interactive();
                        }
                        break;
                      case "Live":
                        {
                          //    print(_info!.tblCourse!.videoStatus);
                          widget.activeClassResult.tblCourse!.videoLink!
                                      .isNotEmpty &&
                                  widget.activeClassResult.tblCourse!
                                          .videoStatus ==
                                      '1'
                              ? Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          MyWidgetVideo(Url:widget.activeClassResult
                                              .tblCourse!.videoLink!)))
                              : widget.activeClassResult.tblCourse!.videoLink ==
                                          "" &&
                                      widget.activeClassResult.tblCourse!
                                              .videoStatus ==
                                          '1'
                                  ? alertDlg(context, "Live Video Unavailable")
                                  : widget.activeClassResult.tblCourse!
                                              .videoStatus ==
                                          '0'
                                      ? alertDlg(context,
                                          "Your Course has expired \n Plese Reactive / Rejoin the course")
                                      : CircularProgressIndicator();

                          //                                                 print(_info!.tblCourse!.videolink);
                          //                                                    print(_info!.tblCourse!.videoStatus);
                        }
                        break;

                      case "Recorded":
                        {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      Recorder(studentId:Preferences.getUserid().toString(),crhId: "${widget.activeClassResult.courseHistory?.crhId}",jlptlevel: "${widget.activeClassResult.tblCourse?.jlptlevel}",)));
                        }
                        break;
                    }
                  },
                  child: Column(
                    //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: SvgPicture.asset(
                          classDetailButtonList[index].icon,
                          fit: BoxFit.contain,
                          height: Insets.xl,
                          width: Insets.xl,
                           color: Colors.red,
                          //SizeConfig.screenHeight! * 0.08,
                        ),
                      ),
                      SizedBox(
                        height: 1,
                      ),
                      Flexible(
                        child: Text(
                          classDetailButtonList[index].title,
                          softWrap: true,
                          textAlign: TextAlign.center,
                          style: TextStyles.subTitle5.copyWith(
                              fontSize: FontSizes.s14,
                              fontWeight: FontWeight.bold,
                              color: AppColors.kTextPrimary),
                        ),
                      )
                    ],
                  ),
                  // height: 250.0,
                  //  color: Colors.white,
                  //margin: new EdgeInsets.all(1.0),

                  // child:  Center(
                  //   child: Card(
                  //       elevation: 3,
                  //       color: Colors.white,
                  //       child: Center(
                  //         child: Column(
                  //             mainAxisAlignment:
                  //                 MainAxisAlignment
                  //                     .spaceEvenly,
                  //             //  mainAxisSize: MainAxisSize.min,
                  //             crossAxisAlignment:
                  //                 CrossAxisAlignment
                  //                     .center,
                  //             children: <Widget>[
                  //               Image.asset(
                  //                   classDetailButtonList[
                  //                           index]
                  //                       .icon,
                  //                   height: 70.0,
                  //                   width: 70.0),
                  //             ]),
                  //       )),
                  // ),
                );
              }).toList(),
            ),
          ),
        ],
      )),
    );
  }

  Widget CardItemlatest1(Iconspojo item) {
    return ColorFiltered(
      colorFilter: item.activeIcon == 1
          ? ColorFilter.mode(Colors.white10.withOpacity(0.0), BlendMode.color)
          : ColorFilter.mode(Colors.white10.withOpacity(0.0), BlendMode.color),
      //: ColorFilter.mode(Colors.white24.withOpacity(0.2), BlendMode.modulate),
      child: Column(
        //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Image.asset(
              item.image,
              fit: BoxFit.contain,
              height: Insets.xxl,
              width: Insets.xxl,
              //  color: AppColors.PrimaryColor,
              //SizeConfig.screenHeight! * 0.08,
            ),
          ),
          SizedBox(
            height: 1,
          ),
          Flexible(
            child: Text(
              item.name,
              softWrap: true,
              textAlign: TextAlign.center,
              style: TextStyles.subTitle5.copyWith(
                  fontSize: FontSizes.s14,
                  fontWeight: FontWeight.bold,
                  color: AppColors.kTextPrimary),
            ),
          )
        ],
      ),
    );
  }
}




class LiveDetails {
  const LiveDetails({required this.title, required this.icon});
  // final Widget page;
  final String title;
  final String icon;
}

class Response {
  ServiceStatus status;
  Map<String, dynamic> data;
  Response({required this.status, required this.data});
}

enum ServiceStatus { success, failure }

class interactivemodel {
  String? result;
  String? message;
  String? batch_message;
  dynamic zoomUrl;
  dynamic googleClassroom;

  interactivemodel({
    required this.result,
    required this.message,
    required this.batch_message,
    required this.zoomUrl,
    required this.googleClassroom,
  });

  factory interactivemodel.fromJson(Map<String, dynamic> json) =>
      interactivemodel(
        result: json["result"],
        message: json["message"],
        batch_message: json["batch_message"],
        zoomUrl: json["zoom_url"],
        googleClassroom: json["google_classroom"],
      );

  Map<String, dynamic> toJson() => {
        "result": result == null ? null : result,
        "message": message == null ? null : message,
        "batch_message": batch_message == null ? null : batch_message,
        "zoom_url": zoomUrl,
        "google_classroom": googleClassroom,
      };
}





class IntractiveClass extends StatefulWidget {
   IntractiveClass({super.key, required this.interactive});
   interactivemodel interactive;

  @override
  State<IntractiveClass> createState() => _IntractiveClassState();
}

class _IntractiveClassState extends State<IntractiveClass> {
 var _url;
  var zoom_url, g_url;
  var msg1, mesg;
    var msgg;

 Future<void> _lun() async {
    final Uri url = Uri.parse("$msgg");
    if (!await launchUrl(url)) {
      throw 'Could not launch $_url';
    }
  }

  Future<void> _Glink() async {
    final Uri url = Uri.parse("$g_url");
    if (!await launchUrl(url)) {
      throw 'Could not launch $_url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        centerTitle: true,
        // automaticallyImplyLeading: false,
        //  leading: Icon(Icons.drag_handle),
        title: AppIcon(
          icon: AppIcons.hayakawa_red_white,
          size: Insets.xxl * 2.5,
          color: AppColors.PrimaryColor,
        ),
      ),
      body: Padding(
        padding:  EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment:CrossAxisAlignment.start,
          children: [
            VSpace.lg,
      Text(
                            "${widget.interactive.batch_message}",
                            textAlign: TextAlign.start,
                            
                            style: TextStyle(
                                fontSize: 16.0, fontWeight: FontWeight.w500),
                          ),
      
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Align(
                                  alignment: Alignment.bottomCenter,
                                  child: IconButton(
                                    icon: Image.asset(
                                      "assets/img/Zoom_logo.png",
                                    ),
                                    iconSize: 60,
                                    onPressed: () async{
                                      final Uri url = Uri.parse(widget.interactive.zoomUrl);
    if (!await launchUrl(url)) {
      throw 'Could not launch ${widget.interactive.zoomUrl}';
    }
                                     // _lun();
                                    },
                                  )
                                  // ElevatedButton(
                                  //   onPressed: () {
                                  //     Navigator.of(context)
                                  //         .pop(); // To close the dialog
                                  //   },
                                  //   child: Text('Proceed Later'),
                                  // ),
                                  ),
                              Align(
                                  alignment: Alignment.bottomRight,
                                  child: IconButton(
                                    icon: Image.asset(
                                      "assets/img/google-classroom.jpg",
                                    ),
                                    iconSize: 100,
                                    onPressed: () async{
                                      final Uri url = Uri.parse(widget.interactive.googleClassroom);
    if (!await launchUrl(url)) {
      throw 'Could not launch ${widget.interactive.googleClassroom}';
    }
                                     // _Glink();
                                    },
                                  )
                                  // ElevatedButton(
                                  //   onPressed: () {},
                                  //   child: Text('Proceed Now'),
                                  // ),
                                  ),
                            ],
                          ),
          ],
        ),
      ),
    );
  }
}