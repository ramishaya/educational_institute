import 'package:educational_institute/core/utils/constants/app_colors.dart';
import 'package:educational_institute/core/utils/theme/custom_themes/appbar_theme.dart';
import 'package:educational_institute/core/utils/theme/custom_themes/elevated_button_theme.dart';
import 'package:educational_institute/core/utils/theme/custom_themes/outlined_button_theme.dart';
import 'package:educational_institute/core/utils/theme/custom_themes/text_field_theme.dart';
import 'package:educational_institute/core/utils/theme/custom_themes/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTheme {
  //private constructor to prevent calling the constructor over and over agian
  AppTheme._();
  static ThemeData lightTheme() {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.black,
        statusBarIconBrightness: Brightness.dark));
    return ThemeData(
      useMaterial3: true,
      fontFamily: 'Ubuntu',
      brightness: Brightness.light,
      primaryColor: AppColors.primaryColor,
      scaffoldBackgroundColor: AppColors.white,
      textTheme: AppTextTheme.lightTextTheme,
      elevatedButtonTheme: AppElevatedButtonTheme.lightElevatedButtonTheme,
      appBarTheme: MyAppBarTheme.lightAppBarTheme,
      outlinedButtonTheme: AppOutLinedButtonTheme.lightOutLinedButtonTheme,
      inputDecorationTheme: AppTextFormFieldTheme.lightInputDecorationTheme,
    );
  }

  static ThemeData darkTheme() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.white.withOpacity(0.15),
        statusBarIconBrightness: Brightness.dark));

    return ThemeData(
      useMaterial3: true,
      fontFamily: 'Ubuntu',
      brightness: Brightness.dark,
      primaryColor: AppColors.primaryColor,
      scaffoldBackgroundColor: AppColors.black,
      textTheme: AppTextTheme.darkTextTheme,
      elevatedButtonTheme: AppElevatedButtonTheme.darkElevatedButtonTheme,
      appBarTheme: MyAppBarTheme.darkAppBarTheme,
      outlinedButtonTheme: AppOutLinedButtonTheme.darkOutLinedButtonTheme,
      inputDecorationTheme: AppTextFormFieldTheme.darkInputDecorationTheme,
    );
  }
}
