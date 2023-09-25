import 'package:flutter/material.dart';
import 'package:hayakawa_new/widgets/style/app_color.dart';

class DecoratedContainer extends StatelessWidget {
  const DecoratedContainer({
    Key? key,
    this.color = Colors.white,
    this.borderColor = Colors.transparent,
    this.borderWidth = 0,
    this.borderRadius = 0,
    this.width,
    this.height,
    this.child,
    this.ignorePointer = false,
    this.shadows,
    this.clipChild = false,
    this.padding,
    this.alignment,
    this.clipFCorner = false,
    this.decoration,
    this.buttonOnly = false,
    this.fullcontainer = false,
    this.decorationGradient = false,
    this.cardDecoration = false,
    this.tabDecoration = false,
    this.buttonDecoration = false,
    this.imgDecoration = false,
    this.innerDecoration = false,
  }) : super(key: key);

  final Color? color;
  final Color? borderColor;
  final double borderWidth;
  final double borderRadius;
  final EdgeInsets? padding;
  final double? width;
  final double? height;
  final Widget? child;
  final bool ignorePointer;
  final List<BoxShadow>? shadows;
  final bool clipChild;
  final Alignment? alignment;
  final bool clipFCorner;
  final Decoration? decoration;
  final bool buttonOnly;
  final bool fullcontainer;
  final bool decorationGradient;
  final bool cardDecoration;
  final bool tabDecoration;
  final bool buttonDecoration;
  final bool imgDecoration;
  final bool innerDecoration;

  @override
  Widget build(BuildContext context) {
    // Create border if we have both a color and width
    BoxBorder? border;
    if (borderColor != null && borderWidth != 0) {
      border = Border.all(color: borderColor!, width: borderWidth);
    }
    // Create decoration
    BoxDecoration dec = BoxDecoration(
      color: fullcontainer ? AppColors.appPrimaryColor : color,
      border: border,
      borderRadius: buttonOnly
          ? BorderRadius.circular(Corners.sm)
          : BorderRadius.circular(Corners.med),
      boxShadow: buttonDecoration
          ? Shadows.button
          : fullcontainer
              ? Shadows.fullShadowContainer
              : tabDecoration
                  ? Shadows.tabShadow
                  : Shadows.universal,
    );
    // Create decoration
    BoxDecoration _cornerOnly = BoxDecoration(
      color: color,
      border: border,
      borderRadius: const BorderRadius.only(
          topLeft: Corners.medRadius, topRight: Corners.medRadius),
      boxShadow: Shadows.universal,
    );
    // Image decoration
    BoxDecoration _img = BoxDecoration(
      color: color,
      boxShadow: Shadows.universal,
      borderRadius: const BorderRadius.only(
          topLeft: Corners.medRadius, topRight: Corners.medRadius),
      image: const DecorationImage(
        image: AssetImage("assets/images/bg.png"),
        fit: BoxFit.fitWidth,
      ),
    );
    // Inner Shadow Continer
    BoxDecoration _insha = BoxDecoration(
        color: color,
        borderRadius: buttonOnly
            ? BorderRadius.circular(Corners.sm)
            : BorderRadius.circular(Corners.med),
        boxShadow: [
          BoxShadow(
              blurRadius: 12,
              offset: -Offset.fromDirection(80),
              color: Colors.white),
          BoxShadow(
              blurRadius: 2,
              offset: Offset.fromDirection(80),
              color: Colors.grey),
        ]);
    // Optionally wrap the content in a clipper that matches border radius
    BoxDecoration _decorationGradient = BoxDecoration(
        border: border,
        borderRadius: BorderRadius.circular(Corners.med),
        boxShadow: Shadows.universal,
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          //stops: [0.5, 0.8, 0.8, 0.1],
          colors: [Colors.purple[100]!, AppColors.kPrimaryDarkColor],
        ));
    BoxDecoration _cardDecoration = BoxDecoration(
      border: border,
      //boxShadow: Shadows.cardContainer,
      borderRadius: BorderRadius.circular(Corners.med),
      gradient: const LinearGradient(
          colors: [
            // Colors.blue,
            Color(0xff026AA1),
            Color(0xff1697DA),
            // Colors.blueAccent,
          ],
          begin: FractionalOffset(0.0, 0.0),
          end: FractionalOffset(1.0, 0.0),
          stops: [0.0, 1.0],
          tileMode: TileMode.clamp),
    );

    return Container(
      decoration: innerDecoration
          ? _insha
          : imgDecoration
              ? _img
              : decorationGradient
                  ? _decorationGradient
                  : clipFCorner
                      ? dec
                      : cardDecoration
                          ? _cardDecoration
                          : _cornerOnly,
      width: width,
      height: height,
      padding: padding,
      alignment: alignment,
      child: child,
    );
  }
}

boxDecoration1([_border, _borderRadius, _color, _shadow]) {
  return BoxDecoration(
      border: _border ?? Border.all(width: 0),
      borderRadius: _borderRadius ?? BorderRadius.circular(Corners.med),
      color: _color ?? Colors.white,
      boxShadow: _shadow ?? Shadows.universal);
}

class Shadows {
  static List<BoxShadow> get universal => [
        BoxShadow(
            color: Colors.grey.withOpacity(0.4),
            blurRadius: 4,
            spreadRadius: 0.0,
            offset: const Offset(0, 0))
      ];
  static List<BoxShadow> get calenderArrow => [
        BoxShadow(
            color: Colors.grey.withOpacity(0.4),
            blurRadius: 4,
            spreadRadius: 6,
            offset: const Offset(0, 0))
      ];

  static List<BoxShadow> get button => [
        BoxShadow(
            color: AppColors.kPrimaryColor,
            blurRadius: 4,
            spreadRadius: 0.0,
            offset: const Offset(0, 0))
      ];

  static List<BoxShadow> get tabShadow => [
        BoxShadow(
            color: Colors.red,
            blurRadius: 0.5,
            spreadRadius: 0.0,
            offset: const Offset(0, 0))
      ];

  static List<BoxShadow> get small => [
        BoxShadow(
            color: const Color(0xff333333).withOpacity(.15),
            spreadRadius: 0,
            blurRadius: 3,
            offset: const Offset(0, 1)),
      ];

  static List<BoxShadow> get fullShadowContainer => [
        BoxShadow(
          color: Colors.red,
          blurRadius: 1,
        ),
      ];
  /* static List<BoxShadow> get cardContainer =>[
    BoxShadow(color: Colors.blue, blurRadius: 5.0,spreadRadius: 0.1, offset: Offset(0, 0)),
  ];*/
}

class Corners {
  static const double sm = 5.0;
  static const BorderRadius smBorder =
      BorderRadius.only(topRight: smRadius, topLeft: smRadius);
  static const Radius smRadius = Radius.circular(sm);

  static const double med = 10.0;
  static const BorderRadius medBorder =
      BorderRadius.only(topRight: medRadius, topLeft: medRadius);
  static const Radius medRadius = Radius.circular(med);

  static const double lg = 15.0;
  static const BorderRadius lgBorder =
      BorderRadius.only(topRight: lgRadius, topLeft: lgRadius);
  static const Radius lgRadius = Radius.circular(lg);
}
