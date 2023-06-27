import 'package:flutter/material.dart';
import 'package:hayakawa_new/widgets/style/font_size.dart';
import 'package:hayakawa_new/widgets/style/style_insets.dart';
import 'package:hayakawa_new/widgets/style/text_style.dart';


class ErrorTxt extends StatelessWidget {
  final String? message;
  final Function() ontap;
  double height;
  ErrorTxt({this.message, required this.ontap, this.height = double.infinity});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      child: Center(
        // child: InkWell(
        //   onTap: ontap,
        //   child: Container(
        //     child: Padding(
        //       padding: EdgeInsets.all(Insets.sm - 2),
        //       child: textStyle(
        //           text: message!,
        //           textAlign: TextAlign.center,
        //           style: TextStyles.subTitle5),
        //     ),
        //   ),
        // ),
      ),
    );
  }
}
