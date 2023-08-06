import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

enum AppIcons {
  hayakawa,
  hayakawa_red_white,
  INTERACTIVE,
  LIVE,
  RECORDED,
  Hayakawa_new_logo
}

class AppIcon extends StatelessWidget {
  final AppIcons icon;
  final double size;
  final Color? color;

  const AppIcon({Key? key, required this.icon, this.size = 20, this.color})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    String i = describeEnum(icon).toLowerCase().replaceAll("-", "_");
    String path = 'assets/svg/' + i + '.svg';
    //debugPrint(path);
    return SvgPicture.asset(
      path,
      width: size,
      height: size,
      color: color,
    );
  }
}
