


import 'package:flutter/cupertino.dart';

class textStyle extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final int? maxLines;
  final TextAlign? textAlign;
  final TextDirection? textDirection;
  final   overflow;
  const textStyle({Key? key, required this.text,  this.style, this.maxLines, this.textAlign , this.overflow, this.textDirection}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: style,
      maxLines: maxLines,
      softWrap: maxLines == 1? false:true,
      textAlign:textAlign,
      overflow: overflow,
      textDirection: textDirection,
    );
  }
}


