import 'package:flutter/material.dart';

class AppColors {
  static const primaryColor = Color(0XFF183191);

  static const darkPrimaryColor = Color(0XFF000f65);
  static const Color lightPrimaryColor = Color(0XFF7878e4);
  static const secondaryColor = Color(0XFF048489);

  static const gradientColor1 = Color(0XFF0079c1);
  static const gradientColor2 = Color(0XFF00b4b6);

  //-- app basic colors

  static const Color accent = Color(0XFFb0c7ff);

  //-- Gradient Colors

  static const Gradient linearGradient = LinearGradient(
      begin: Alignment(0.0, 0.0),
      end: Alignment(0.787, -0.787),
      colors: [Color(0XFF183191), Color(0XFF0079c1), Color(0XFF00b4b6)]);

  //-- Text Colors

  static const Color textWhite = Colors.white;

  //-- background Colors
  static const Color light = Color(0XFFF6F6F6);
  static const Color dark = Color(0XFF272727);
  static const Color primaryBackground = Color(0XFFF3F5FF);

  //--Background Container Color

  static const Color lightContainer = Color(0XFFF6F6F6);

  //--Button Colors

  static const Color buttonPrimary = Color(0XFF183191);
  static const Color buttonSecondary = Color(0XFF048489);
  static const Color buttonDisabled = Color(0XFFC4C4C4);

  //-- Border Colors
  static const Color borderPrimary = Color(0XFFD9D9D9);
  static const Color borderSecondary = Color(0XFFE6E6E6);

  //-- Error and validate colors

  static const Color error = Color(0XFFD32F2F);
  static const Color sucsses = Color(0XFF388E3C);
  static const Color warning = Color(0XFFF57C00);
  static const Color info = Color(0XFF1976D2);

  //-- Neutral shades
  static const Color black = Color(0XFF232323);
  static const Color blackk = Color(0XFF000000);

  static const Color darkerGrey = Color(0XFF4F4F4F);

  static const Color darkGrey = Color(0XFF939393);

  static const Color grey = Color(0XFFE0E0E0);

  static const Color softGrey = Color(0XFFF4F4F4);

  static const Color lightGrey = Color(0XFFF9F9F9);
  static const Color white = Color(0XFFFFFFFF);
}
