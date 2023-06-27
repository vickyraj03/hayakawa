import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'app_color.dart';

class FontSizes {

  static double get scale => 1;
  static double get s6 => 6 * scale;
  static double get s7 => 7 * scale;
  static double get s8 => 8 * scale;
  static double get s10 => 10 * scale;
  static double get s11 => 11 * scale;
  static double get s12 => 12 * scale;
  static double get s13 => 13 * scale;
  static double get s14 => 14 * scale;
  static double get s15 => 15 * scale;
  static double get s16 => 16 * scale;
  static double get s18 => 18 * scale;
  static double get s20 => 20 * scale;
  static double get s22 => 22 * scale;
  static double get s24 => 24 * scale;
  static double get s26 => 26 * scale;
  static double get s50 => 50 * scale;
}
/// Fonts - A list of Font Families, this is uses by the TextStyles class to create concrete styles.
class Fonts {
  static const String roboto = "Roboto";
  static const String montserrat = "Montserrat";
  static const String ltkaff = "29LTKaff";
  static const String fraunces = "Fraunces";
}
class TextStyles {
  /// Declare a base style for each Family
  static const TextStyle ltkaff = TextStyle(fontFamily: Fonts.ltkaff, fontWeight: FontWeight.w400, );
  static const TextStyle montserrat = TextStyle(fontFamily: Fonts.montserrat, fontWeight: FontWeight.w400, );
  static const TextStyle fraunces = TextStyle(fontFamily: Fonts.fraunces, fontWeight: FontWeight.w400,);

  static TextStyle get h1 => montserrat.copyWith(fontWeight: FontWeight.w600, fontSize: FontSizes.s26, letterSpacing: -1, color: AppColors.kTextPrimary);
  static TextStyle get h2 => h1.copyWith(fontSize: FontSizes.s24, letterSpacing: -.5,color: AppColors.kTextPrimary);
  static TextStyle get h3 => h1.copyWith(fontSize: FontSizes.s22, letterSpacing: -.05,color: AppColors.kTextPrimary/* height: 1.29*/);
  static TextStyle get title1 => montserrat.copyWith(fontWeight: FontWeight.bold, fontSize: FontSizes.s16,color: AppColors.kTextPrimary);
  static TextStyle get title2 => title1.copyWith(fontWeight: FontWeight.w500, fontSize: FontSizes.s14, color: AppColors.kTextPrimary);
  static TextStyle get body1 => montserrat.copyWith(fontWeight: FontWeight.normal, fontSize: FontSizes.s16, color: AppColors.kTextPrimary);
  static TextStyle get body2 => body1.copyWith(fontSize: FontSizes.s14,  fontWeight: FontWeight.bold,color: AppColors.kTextPrimary);
  //static TextStyle get body2 => body1.copyWith(fontSize: FontSizes.s15, letterSpacing: .2,color: AppColors.kTextThird,fontWeight: FontWeight.w400);
  static TextStyle get body3 => body1.copyWith(fontSize: FontSizes.s12,  fontWeight: FontWeight.bold,color: AppColors.kTextPrimary);
  static TextStyle get body3w => body1.copyWith(fontSize: FontSizes.s12,  fontWeight: FontWeight.bold,color: Colors.white);
  static TextStyle get body4 => body1.copyWith(fontSize: FontSizes.s10,  fontWeight: FontWeight.bold,color: AppColors.kTextPrimary);
  static TextStyle get body5 => body1.copyWith(fontSize: FontSizes.s8,  fontWeight: FontWeight.bold,color: AppColors.kTextPrimary);


  static TextStyle get callout1 =>montserrat.copyWith( fontSize: FontSizes.s12, letterSpacing: .5,color: AppColors.kTextPrimary);
  static TextStyle get callout2 => callout1.copyWith(fontSize: FontSizes.s10,  letterSpacing: .25,color: AppColors.kTextPrimary);
  static TextStyle get caption => montserrat.copyWith(fontWeight: FontWeight.w500, fontSize: FontSizes.s11,color: AppColors.kTextPrimary);
  static TextStyle get subTitle1 => montserrat.copyWith(fontSize: FontSizes.s18,fontWeight: FontWeight.w600, color: AppColors.kTextPrimary, letterSpacing: 0);
  static TextStyle get subTitle2 => montserrat.copyWith(  fontSize: FontSizes.s16, fontWeight: FontWeight.w500,color: AppColors.kTextPrimary,letterSpacing: 0);
  static TextStyle get subTitle3 => montserrat.copyWith(  fontSize: FontSizes.s15, fontWeight: FontWeight.w500,color: AppColors.kTextThird,letterSpacing: 0);
  static TextStyle get subTitle4 => montserrat.copyWith(  fontSize: FontSizes.s14, fontWeight: FontWeight.w500,color: AppColors.kTextThird,letterSpacing: 0);
  static TextStyle get subTitle5 => montserrat.copyWith(  fontSize: FontSizes.s10, fontWeight: FontWeight.w400,color: AppColors.kTextPrimary,letterSpacing: 0);
}