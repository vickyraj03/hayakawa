import 'package:flutter/material.dart';
import 'package:hayakawa_new/screens/dashboard_screen/classes/checking,dart';
import 'package:hayakawa_new/widgets/style/style_insets.dart';
import 'package:hayakawa_new/widgets/youTube_widget.dart';


class MyWidgetVideo extends StatefulWidget {
   MyWidgetVideo({super.key,required this.Url});

   String Url;

  @override
  State<MyWidgetVideo> createState() => _MyWidgetVideoState();
}

class _MyWidgetVideoState extends State<MyWidgetVideo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding:  EdgeInsets.only(top: Insets.xxl),
        child: Stack(
          children: [
            YoutubeWidget( videoUrl: widget.Url,),
            Positioned(child: IconButton(
              icon: Icon(Icons.arrow_back_ios,
              color: Colors.white,
              ),
              onPressed: (){
                  Navigator.of(context).pop();
              },
              
            ))
          ],
        ),
      )
    );
  }
}