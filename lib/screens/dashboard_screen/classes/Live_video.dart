import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:hayakawa_new/screens/dashboard_screen/classes/checking,dart';
import 'package:hayakawa_new/widgets/appIcon.dart';
import 'package:hayakawa_new/widgets/style/app_color.dart';
import 'package:hayakawa_new/widgets/style/style_insets.dart';

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
      body: Checking(widget.Url),
    );
  }
}