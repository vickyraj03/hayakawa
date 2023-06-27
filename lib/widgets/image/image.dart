

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hayakawa_new/widgets/style/style_insets.dart';

import '../style/font_size.dart';

class Cachednetworkimage extends StatelessWidget {
  Cachednetworkimage(
      {Key? key,
      required this.imgurl,
      this.containerheight,
      this.text = '',
      this.borderRadius = const BorderRadius.only(
          topRight: Radius.circular(20),
          topLeft: Radius.circular(20),
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20))})
      : super(key: key);

  String? imgurl, unitstatus;
  double? containerheight;
  String text;
  BorderRadius? borderRadius;
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imgurl!,
      placeholder: (context, url) => Padding(
        padding: EdgeInsets.all(Insets.sm + 2),
        child: Container(
          // height: containerheight,
          decoration: BoxDecoration(
            image: const DecorationImage(
              fit: BoxFit.contain,
              image: ExactAssetImage('assets/img/noimage.png'),
            ),
            borderRadius: BorderRadius.all(Radius.circular(Insets.sm + 2)),
          ),
          //child: Container(),//Loading(), TO-DO: loader has to show when the actual image is loading, not on the NOIMAGE
          child: CircularProgressIndicator(),
        ),
      ),
      imageBuilder: (context, image) => Container(
        child:  Container(color: Colors.transparent),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Insets.lg),
            image: DecorationImage(image: image, fit: BoxFit.cover)),
      ),
      errorWidget: (context, url, error) => Padding(
          padding: EdgeInsets.all(Insets.sm + 2),
          child: Container(
            child: Container(color: Colors.transparent),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(Insets.sm + 2)),
                image:  DecorationImage(
                        image: ExactAssetImage('assets/images/noimage.png'),
                        fit: BoxFit.contain)),
          )),
    );
  }
}