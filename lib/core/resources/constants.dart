import 'package:base_structure/core/helper/extensions/material_color_converter.dart';
import 'package:base_structure/core/resources/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TranslationsKeys {
  static String get settings => "settings";

  static String get english => "english";

  static String get arabic => "arabic";

  static String get light => "light";

  static String get dark => "dark";
}

class ImagesKeys {
  static String get welcomeBackground => "lib/assets/welcomBg.png";

  static String get logo => "lib/assets/images/png/logo.png";
  static String get clear => "lib/assets/images/svg/clear.svg";
}

class AppTheme {
  static ThemeData appThemeData(AppThemeColors appThemeColors, bool localeEn, Brightness brightness,
      ColorScheme? colorScheme) {
    return ThemeData(
      colorScheme: colorScheme ??
          ColorScheme.fromSwatch(
            backgroundColor: appThemeColors.backgroundColor,
            primarySwatch: appThemeColors.primaryColor.toMaterialColor(),
            brightness: brightness,
          ),
      scaffoldBackgroundColor: appThemeColors.backgroundColor,
      primaryColor: appThemeColors.primaryColor,
      primaryColorLight: appThemeColors.primaryColor100,
      appBarTheme: AppBarTheme(color: appThemeColors.primaryColor),
      progressIndicatorTheme: ProgressIndicatorThemeData(color: appThemeColors.primaryColor),
      iconTheme: IconThemeData(
        color: appThemeColors.black,
        size: 32.sp,
      ),
      dividerTheme: DividerThemeData(color: appThemeColors.divider, thickness: 0.8),
      bottomNavigationBarTheme:
          BottomNavigationBarThemeData(backgroundColor: appThemeColors.primaryColor),
      textTheme: appTextTheme(),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(primary: appThemeColors.text),
      ),
      primarySwatch: appThemeColors.primaryColor.toMaterialColor(),
      fontFamily: localeEn ? "roboto" : "cocon",
      brightness: brightness,
      useMaterial3: true,
    );
  }

  static TextTheme appTextTheme() => TextTheme(
        displayLarge: TextStyle(fontSize: 57.sp, fontWeight: FontWeight.w400),
        displayMedium: TextStyle(fontSize: 45.sp, fontWeight: FontWeight.w400),
        displaySmall: TextStyle(fontSize: 36.sp, fontWeight: FontWeight.w400),
        headlineLarge: TextStyle(fontSize: 32.sp, fontWeight: FontWeight.w400),
        headlineMedium: TextStyle(fontSize: 28.sp, fontWeight: FontWeight.w400),
        headlineSmall: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.w400),
        bodyLarge: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400),
        bodyMedium: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400),
        bodySmall: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w400),
        titleLarge: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w400),
        titleMedium: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
        titleSmall: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
        labelLarge: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
        labelMedium: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w500),
        labelSmall: TextStyle(fontSize: 11.sp, fontWeight: FontWeight.w500),
      );
}
