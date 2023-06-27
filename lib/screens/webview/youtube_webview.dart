// import 'dart:async';
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:hayakawa_new/modeks/Classs/active_class_model.dart';
// import 'package:webview_flutter/webview_flutter.dart';




// class Webviewyoutube extends StatefulWidget {
//   var infoNew,locationNew,datumInfo;
//   Webviewyoutube(this.infoNew,this.locationNew, this.datumInfo);
// 	@override
// 	State<StatefulWidget> createState() {
// 		var batchDetailState = new _WebviewyoutubeState(this.infoNew,this.locationNew,this.datumInfo);
// 		return batchDetailState;
// 	}
//  // @override
//  // _LoginScreenState createState() => new _PayviewState();
// }

// class _WebviewyoutubeState extends State<Webviewyoutube> {
//  _WebviewyoutubeState(this.info,this.location, this.datumInfos);
//    String? info;
//    String? location;
//  ActiveClassResult? datumInfos;
//   var videoID, classURL;
// late  BuildContext context;
//  // final flutterWebviewPlugin = new FlutterWebviewPlugin();
// final Completer<WebViewController> _controller =
//       Completer<WebViewController>();
//   StreamSubscription? _onDestroy;
//   StreamSubscription<String>? _onUrlChanged;
// //late  StreamSubscription<WebViewStateChanged> _onStateChanged;
//   //var _studentId, _url;
//   String? token;



//   /* _fetchHome() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     var studentId = prefs.getString('studentId');
//     var url = NetworkUtils.host;

//     setState(() {
//       _studentId = studentId;
//       _url = url + "studyinjapan.php?studentId=" + _studentId;
//       print(_url);
//     });
//   } */

//   @override
//   void dispose() {
//     // Every listener should be canceled, the same should be done with this stream.
//     _onDestroy!.cancel();
//     _onUrlChanged!.cancel();
//   //  _onStateChanged.cancel();
//   //  _controller.dispose();
//     super.dispose();
//   }

//   @override
//   void initState() {
//     super.initState();
//     //_fetchHome();
//    // _controller.close();
//  if (Platform.isAndroid) {
//       WebView.platform = SurfaceAndroidWebView();
//     }
   
//   }

//   @override
//   Widget build(BuildContext context) {
//     setState(() => this.context = context);
//     //String loginUrl = "someservise.com/auth";
//     return  Scaffold(
    
//          appBar: AppBar(

//             automaticallyImplyLeading: true,
//             backgroundColor: Colors.white,
//             title: Text(info!,style: TextStyle(fontSize: 16, color: Colors.indigo[900],),),
//               iconTheme: new IconThemeData(color: Colors.indigo[900]),
//                         elevation: 0,
//               leading: IconButton(
//                 iconSize: 18,
//                 icon:Icon(Icons.arrow_back),
//               onPressed: () {
//                 // Navigator.pop(context, true);
//                  Navigator.pushReplacement(
//                     context,
//                     MaterialPageRoute(
//                         builder: (BuildContext ctx) => ClassesPage(datumInfos)));
//               },
//             ),
//           ),

//      body: WebView(
//          initialUrl:  location!,

//     ));


//   }
// }